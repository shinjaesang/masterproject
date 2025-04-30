package org.myweb.first.warehouse.model.service;

import java.util.List;

import org.myweb.first.warehouse.model.dto.Warehouse;
import org.myweb.first.warehouse.model.dto.WarehouseSearchCondition;

public interface WarehouseService {
    List<Warehouse> selectAllWarehouses();
    Warehouse selectWarehouseById(String warehouseId);
    int insertWarehouse(Warehouse warehouse);
    int updateWarehouse(Warehouse warehouse);
    int deleteWarehouse(String warehouseId);
    List<Warehouse> searchWarehouses(WarehouseSearchCondition cond);
} 