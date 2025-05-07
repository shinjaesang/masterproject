package org.myweb.first.inventory.model.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.myweb.first.inventory.model.dto.Inventory;
import org.myweb.first.inventory.model.dto.InventorySearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class InventoryDao {
    @Autowired
    private SqlSession sqlSession;

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
} 