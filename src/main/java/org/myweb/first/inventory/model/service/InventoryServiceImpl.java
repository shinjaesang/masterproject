package org.myweb.first.inventory.model.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.myweb.first.inventory.model.dao.InventoryDao;
import org.myweb.first.inventory.model.dto.Inventory;
import org.myweb.first.inventory.model.dto.InventorySearchCondition;

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
} 