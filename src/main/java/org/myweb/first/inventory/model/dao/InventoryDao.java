package org.myweb.first.inventory.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.inventory.model.dto.Inventory;
import org.myweb.first.inventory.model.dto.InventorySearchCondition;
import org.myweb.first.inventory.model.dto.WarehouseStock;
import org.springframework.stereotype.Repository;

@Repository
public class InventoryDao {
    private final SqlSession sqlSession;

    public InventoryDao(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    private static final String NAMESPACE = "inventoryMapper.";

    public List<Inventory> selectCurrentInventoryList() {
        return sqlSession.selectList(NAMESPACE + "selectCurrentInventoryList");
    }

    public List<Inventory> searchInventory(InventorySearchCondition cond) {
        return sqlSession.selectList(NAMESPACE + "searchInventory", cond);
    }

    public int countInventory(InventorySearchCondition cond) {
        return sqlSession.selectOne(NAMESPACE + "countInventory", cond);
    }

    public WarehouseStock selectStock(String warehouseId, String productId) {
        Map<String, String> params = Map.of(
            "warehouseId", warehouseId,
            "productId", productId
        );
        return sqlSession.selectOne("inventoryMapper.selectStock", params);
    }

    public int insertStock(WarehouseStock stock) {
        return sqlSession.insert("inventoryMapper.insertStock", stock);
    }

    public int updateStock(WarehouseStock stock) {
        return sqlSession.update("inventoryMapper.updateStock", stock);
    }

    public int insertStockHistory(Map<String, Object> params) {
        return sqlSession.insert("inventoryMapper.insertStockHistory", params);
    }
} 