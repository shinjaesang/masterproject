package org.myweb.first.inventory.model.service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.myweb.first.inventory.model.dao.InventoryDao;
import org.myweb.first.inventory.model.dto.Inventory;
import org.myweb.first.inventory.model.dto.InventorySearchCondition;
import org.myweb.first.inventory.model.dto.DailyInventory;
import org.myweb.first.inventory.model.dto.DailyInventorySearchCondition;

@Service
public class InventoryServiceImpl implements InventoryService {
    @Autowired
    private InventoryDao inventoryDao;

    @Override
    public List<Inventory> getCurrentInventoryList() {
        return inventoryDao.selectCurrentInventoryList();
    }

    @Override
    public List<Inventory> searchInventory(InventorySearchCondition cond) {
        return inventoryDao.searchInventory(cond);
    }

    @Override
    public int countInventory(InventorySearchCondition cond) {
        return inventoryDao.countInventory(cond);
    }

    @Override
    public List<DailyInventory> searchDailyInventory(DailyInventorySearchCondition cond) {
        return inventoryDao.searchDailyInventory(cond);
    }

    @Override
    public int countDailyInventory(DailyInventorySearchCondition cond) {
        return inventoryDao.countDailyInventory(cond);
    }

    @Override
    public List<String> selectDateHeaders(DailyInventorySearchCondition cond) {
        return inventoryDao.selectDateHeaders(cond);
    }

    @Override
    public List<Map<String, String>> getCategories() {
        // TODO: 실제로는 DB에서 카테고리 목록을 가져와야 함
        // 임시 구현: 하드코딩된 카테고리 목록 반환
        List<Map<String, String>> categories = new ArrayList<>();
        
        Map<String, String> category1 = new HashMap<>();
        category1.put("code", "전자제품");
        category1.put("name", "전자제품");
        categories.add(category1);
        
        Map<String, String> category2 = new HashMap<>();
        category2.put("code", "전자부품");
        category2.put("name", "전자부품");
        categories.add(category2);
        
        Map<String, String> category3 = new HashMap<>();
        category3.put("code", "가전제품");
        category3.put("name", "가전제품");
        categories.add(category3);
        
        return categories;
    }
} 