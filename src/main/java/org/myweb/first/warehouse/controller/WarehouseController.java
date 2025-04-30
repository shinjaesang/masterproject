package org.myweb.first.warehouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;

import java.util.List;

import org.myweb.first.warehouse.model.dto.Warehouse;
import org.myweb.first.warehouse.model.dto.WarehouseSearchCondition;
import org.myweb.first.warehouse.model.service.WarehouseService;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/warehouse")
public class WarehouseController {
    @Autowired
    private WarehouseService warehouseService;

    @GetMapping("warehouse.do")
    public String warehousePage() {
        return "warehouse/warehouse";
    }

    @GetMapping("register.do")
    public String registerWarehousePage() {
        return "warehouse/register";
    }

    @GetMapping("edit.do")
    public String editWarehousePage() {
        return "warehouse/edit";
    }

    // 창고 전체/검색 목록 조회 (JSON)
    @GetMapping("/list")
    @ResponseBody
    public List<Warehouse> getWarehouseList(WarehouseSearchCondition cond) {
        return warehouseService.searchWarehouses(cond);
    }

    // 창고 상세 조회 (JSON)
    @GetMapping("/{warehouseId}")
    @ResponseBody
    public Warehouse getWarehouse(@PathVariable("warehouseId") String warehouseId) {
        return warehouseService.selectWarehouseById(warehouseId);
    }

    // 창고 등록 (JSON)
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<String> addWarehouse(@RequestBody Warehouse warehouse) {
        int result = warehouseService.insertWarehouse(warehouse);
        if(result > 0) {
            return ResponseEntity.ok("success");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
        }
    }

    // 창고 수정 (JSON)
    @PutMapping("/update")
    @ResponseBody
    public ResponseEntity<String> updateWarehouse(@RequestBody Warehouse warehouse) {
        int result = warehouseService.updateWarehouse(warehouse);
        if(result > 0) {
            return ResponseEntity.ok("success");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
        }
    }

    // 창고 삭제 (JSON)
    @DeleteMapping("/delete/{warehouseId}")
    @ResponseBody
    public ResponseEntity<String> deleteWarehouse(@PathVariable String warehouseId) {
        int result = warehouseService.deleteWarehouse(warehouseId);
        if(result > 0) {
            return ResponseEntity.ok("success");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
        }
    }
} 