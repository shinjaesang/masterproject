package org.myweb.first.warehouse.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.warehouse.model.dto.Warehouse;
import org.myweb.first.warehouse.model.dto.WarehouseSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WarehouseDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "warehouseMapper.";

    // 창고 전체 목록 조회
    public List<Warehouse> selectAllWarehouses() {
        return sqlSession.selectList(NAMESPACE + "selectAllWarehouses");
    }

    // 창고 상세 조회
    public Warehouse selectWarehouseById(String warehouseId) {
        return sqlSession.selectOne(NAMESPACE + "selectWarehouseById", warehouseId);
    }

    // 창고 등록
    public int insertWarehouse(Warehouse warehouse) {
        return sqlSession.insert(NAMESPACE + "insertWarehouse", warehouse);
    }

    // 창고 수정
    public int updateWarehouse(Warehouse warehouse) {
        return sqlSession.update(NAMESPACE + "updateWarehouse", warehouse);
    }

    // 창고 삭제
    public int deleteWarehouse(String warehouseId) {
        return sqlSession.delete(NAMESPACE + "deleteWarehouse", warehouseId);
    }

    // 검색 조건에 따른 창고 목록 조회
    public List<Warehouse> searchWarehouses(WarehouseSearchCondition cond) {
        return sqlSession.selectList(NAMESPACE + "searchWarehouses", cond);
    }
} 