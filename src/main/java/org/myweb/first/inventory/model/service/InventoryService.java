package org.myweb.first.inventory.model.service;

import java.util.List;
import org.myweb.first.inventory.model.dto.Inventory;
import org.myweb.first.inventory.model.dto.InventorySearchCondition;

public interface InventoryService {
    List<Inventory> getCurrentInventoryList();
    List<Inventory> searchInventory(InventorySearchCondition cond);
    int countInventory(InventorySearchCondition cond);
} 