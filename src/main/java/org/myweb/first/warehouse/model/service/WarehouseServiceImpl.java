package org.myweb.first.warehouse.model.service;

import java.util.List;

import org.myweb.first.warehouse.model.dao.WarehouseDao;
import org.myweb.first.warehouse.model.dto.Warehouse;
import org.myweb.first.warehouse.model.dto.WarehouseSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WarehouseServiceImpl implements WarehouseService {

    @Autowired
    private WarehouseDao warehouseDao;

    @Override
    public List<Warehouse> selectAllWarehouses() {
        return warehouseDao.selectAllWarehouses();
    }

    @Override
    public Warehouse selectWarehouseById(String warehouseId) {
        return warehouseDao.selectWarehouseById(warehouseId);
    }

    @Override
    public int insertWarehouse(Warehouse warehouse) {
        return warehouseDao.insertWarehouse(warehouse);
    }

    @Override
    public int updateWarehouse(Warehouse warehouse) {
        return warehouseDao.updateWarehouse(warehouse);
    }

    @Override
    public int deleteWarehouse(String warehouseId) {
        return warehouseDao.deleteWarehouse(warehouseId);
    }

    @Override
    public List<Warehouse> searchWarehouses(WarehouseSearchCondition cond) {
        return warehouseDao.searchWarehouses(cond);
    }
} 