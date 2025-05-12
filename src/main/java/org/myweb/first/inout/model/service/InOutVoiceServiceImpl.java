package org.myweb.first.inout.model.service;

import java.util.List;
import java.util.Map;

import org.myweb.first.inout.model.dao.InOutVoiceDao;
import org.myweb.first.inout.model.dto.InOutVoice;
import org.myweb.first.inout.model.dto.InOutVoiceProductDetail;
import org.myweb.first.inout.model.service.InOutVoiceService;
import org.myweb.first.inventory.model.dao.InventoryDao;
import org.myweb.first.inventory.model.dto.WarehouseStock;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class InOutVoiceServiceImpl implements InOutVoiceService {
    
    private final InOutVoiceDao inOutVoiceDao;
    private final InventoryDao inventoryDao;
    
    public InOutVoiceServiceImpl(InOutVoiceDao inOutVoiceDao, InventoryDao inventoryDao) {
        this.inOutVoiceDao = inOutVoiceDao;
        this.inventoryDao = inventoryDao;
    }

    @Override
    public List<InOutVoice> selectInOutVoiceList(Map<String, Object> params) {
        return inOutVoiceDao.selectInOutVoiceList(params);
    }

    @Override
    public InOutVoice selectInOutVoiceById(String inoutvoiceId) {
        return inOutVoiceDao.selectInOutVoiceById(inoutvoiceId);
    }

    @Override
    public int insertInOutVoice(InOutVoice inOutVoice) {
        return inOutVoiceDao.insertInOutVoice(inOutVoice);
    }

    @Override
    public int updateInOutVoice(InOutVoice inOutVoice) {
        return inOutVoiceDao.updateInOutVoice(inOutVoice);
    }

    @Override
    public int deleteInOutVoice(String inoutvoiceId) {
        return inOutVoiceDao.deleteInOutVoice(inoutvoiceId);
    }

    @Override
    public int selectInOutVoiceTotalCount(Map<String, Object> params) {
        return inOutVoiceDao.selectInOutVoiceTotalCount(params);
    }

    @Override
    public List<InOutVoiceProductDetail> selectInOutVoiceProductList(String inoutvoiceId) {
        return inOutVoiceDao.selectInOutVoiceProductList(inoutvoiceId);
    }

    @Override
    public int insertInOutVoiceProduct(String inoutvoiceId, String productId, int quantity, String workerId) {
        return inOutVoiceDao.insertInOutVoiceProduct(inoutvoiceId, productId, quantity, workerId);
    }

    @Override
    @Transactional
    public int processInOutVoiceProducts(List<String> ids, String workerId) {
        // 1. 처리할 상품들의 상세 정보 조회
        List<InOutVoiceProductDetail> products = inOutVoiceDao.selectProductsByIds(ids);
        
        // 2. 각 상품별로 재고 처리
        for (InOutVoiceProductDetail product : products) {
            processStock(product, workerId);
        }
        
        // 3. 상품 상태, 작업자, 작업일 업데이트
        return inOutVoiceDao.updateProductAsProcessed(ids, workerId);
    }
    
    private void processStock(InOutVoiceProductDetail product, String workerId) {
        String inoutvoiceType = product.getInoutvoiceType();
        int quantity = product.getQuantity();
        
        switch (inoutvoiceType) {
            case "입고":
                processInStock(product, workerId);
                break;
            case "출고":
                processOutStock(product, workerId);
                break;
            case "이동":
                processMoveStock(product, workerId);
                break;
        }
    }
    
    private void processInStock(InOutVoiceProductDetail product, String workerId) {
        String warehouseId = product.getInWarehouseId();
        String productId = product.getProductId();
        int quantity = product.getQuantity();
        
        WarehouseStock stock = inventoryDao.selectStock(warehouseId, productId);
        int inStockQuantity;
        if (stock == null) {
            // 신규 재고 등록
            stock = new WarehouseStock();
            stock.setWarehouseId(warehouseId);
            stock.setProductId(productId);
            stock.setStockQuantity(quantity);
            inventoryDao.insertStock(stock);
            inStockQuantity = quantity;
        } else {
            // 기존 재고 증가
            stock.setStockQuantity(stock.getStockQuantity() + quantity);
            inventoryDao.updateStock(stock);
            inStockQuantity = stock.getStockQuantity();
        }
        
        // 재고 이력 기록
        Map<String, Object> historyParams = new java.util.HashMap<>();
        historyParams.put("inWarehouseId", warehouseId);
        historyParams.put("outWarehouseId", null);
        historyParams.put("productId", productId);
        historyParams.put("inStockQuantity", inStockQuantity);
        historyParams.put("outStockQuantity", null);
        historyParams.put("changeQuantity", quantity);
        historyParams.put("changeType", "입고");
        historyParams.put("inoutvoiceId", product.getInoutvoiceId());
        historyParams.put("inoutvoiceProductId", product.getInoutvoiceProductId());
        historyParams.put("createdBy", workerId);
        inventoryDao.insertStockHistory(historyParams);
    }
    
    private void processOutStock(InOutVoiceProductDetail product, String workerId) {
        String warehouseId = product.getOutWarehouseId();
        String productId = product.getProductId();
        int quantity = product.getQuantity();
        
        WarehouseStock stock = inventoryDao.selectStock(warehouseId, productId);
        if (stock == null || stock.getStockQuantity() < quantity) {
            throw new RuntimeException("재고가 부족합니다.");
        }
        
        // 재고 감소
        stock.setStockQuantity(stock.getStockQuantity() - quantity);
        inventoryDao.updateStock(stock);
        int outStockQuantity = stock.getStockQuantity();
        
        // 재고 이력 기록
        Map<String, Object> historyParams = new java.util.HashMap<>();
        historyParams.put("inWarehouseId", null);
        historyParams.put("outWarehouseId", warehouseId);
        historyParams.put("productId", productId);
        historyParams.put("inStockQuantity", null);
        historyParams.put("outStockQuantity", outStockQuantity);
        historyParams.put("changeQuantity", -quantity);
        historyParams.put("changeType", "출고");
        historyParams.put("inoutvoiceId", product.getInoutvoiceId());
        historyParams.put("inoutvoiceProductId", product.getInoutvoiceProductId());
        historyParams.put("createdBy", workerId);
        inventoryDao.insertStockHistory(historyParams);
    }
    
    private void processMoveStock(InOutVoiceProductDetail product, String workerId) {
        // 출고 창고 재고 감소
        String outWarehouseId = product.getOutWarehouseId();
        String inWarehouseId = product.getInWarehouseId();
        String productId = product.getProductId();
        int quantity = product.getQuantity();

        // 출고 창고 처리
        WarehouseStock outStock = inventoryDao.selectStock(outWarehouseId, productId);
        if (outStock == null || outStock.getStockQuantity() < quantity) {
            throw new RuntimeException("이동 출고창고 재고가 부족합니다.");
        }
        outStock.setStockQuantity(outStock.getStockQuantity() - quantity);
        inventoryDao.updateStock(outStock);
        int outStockQuantity = outStock.getStockQuantity();

        // 입고 창고 처리
        WarehouseStock inStock = inventoryDao.selectStock(inWarehouseId, productId);
        int inStockQuantity;
        if (inStock == null) {
            inStock = new WarehouseStock();
            inStock.setWarehouseId(inWarehouseId);
            inStock.setProductId(productId);
            inStock.setStockQuantity(quantity);
            inventoryDao.insertStock(inStock);
            inStockQuantity = quantity;
        } else {
            inStock.setStockQuantity(inStock.getStockQuantity() + quantity);
            inventoryDao.updateStock(inStock);
            inStockQuantity = inStock.getStockQuantity();
        }

        // 재고 이력 기록 (이동)
        Map<String, Object> historyParams = new java.util.HashMap<>();
        historyParams.put("inWarehouseId", inWarehouseId);
        historyParams.put("outWarehouseId", outWarehouseId);
        historyParams.put("productId", productId);
        historyParams.put("inStockQuantity", inStockQuantity);
        historyParams.put("outStockQuantity", outStockQuantity);
        historyParams.put("changeQuantity", quantity);
        historyParams.put("changeType", "이동");
        historyParams.put("inoutvoiceId", product.getInoutvoiceId());
        historyParams.put("inoutvoiceProductId", product.getInoutvoiceProductId());
        historyParams.put("createdBy", workerId);
        inventoryDao.insertStockHistory(historyParams);
    }

    @Override
    public int deleteInOutVoiceProducts(List<String> ids) {
        return inOutVoiceDao.deleteInOutVoiceProducts(ids);
    }
} 