package org.myweb.first.inventory.model.service;

import java.util.List;
import java.util.Map;
import org.myweb.first.inventory.model.dto.DailyInventory;
import org.myweb.first.inventory.model.dto.DailyInventorySearchCondition;
import org.myweb.first.inventory.model.dto.Inventory;
import org.myweb.first.inventory.model.dto.InventorySearchCondition;

public interface InventoryService {
    List<Inventory> getCurrentInventoryList();
    List<Inventory> searchInventory(InventorySearchCondition cond);
    int countInventory(InventorySearchCondition cond);
    
    // 일자별 재고 조회
    List<DailyInventory> searchDailyInventory(DailyInventorySearchCondition cond);
    int countDailyInventory(DailyInventorySearchCondition cond);
    List<String> selectDateHeaders(DailyInventorySearchCondition cond);
    
    // 카테고리 목록 조회
    List<Map<String, String>> getCategories();
} 