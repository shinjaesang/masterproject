package org.myweb.first.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/inventory")
public class InventoryController {

    @GetMapping("/currentInventory.do")
    public String showCurrentInventory(
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        // TODO: 실제 데이터를 가져오는 로직 구현
        // 임시 데이터 설정
        model.addAttribute("inventoryList", null);
        model.addAttribute("inventorySummary", null);
        model.addAttribute("pageInfo", null);
        model.addAttribute("productTags", null);
        model.addAttribute("categories", null);
        
        return "inventory/currentInventory";
    }

    @GetMapping("/dailyInventory.do")
    public String showDailyInventory(
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        // TODO: 실제 데이터를 가져오는 로직 구현
        // 임시 데이터 설정
        model.addAttribute("dailyInventoryList", null);
        model.addAttribute("dateHeaders", null);
        model.addAttribute("pageInfo", null);
        model.addAttribute("vendorGroups", null);
        model.addAttribute("vendors", null);
        model.addAttribute("suppliers", null);
        model.addAttribute("categories", null);
        
        return "inventory/dailyInventory";
    }

    @GetMapping("/monthlyInventory.do")
    public String showMonthlyInventory(
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        // TODO: 실제 데이터를 가져오는 로직 구현
        // 임시 데이터 설정
        model.addAttribute("monthlyInventoryList", null);
        model.addAttribute("monthHeaders", null);
        model.addAttribute("pageInfo", null);
        model.addAttribute("vendorGroups", null);
        model.addAttribute("vendors", null);
        model.addAttribute("suppliers", null);
        model.addAttribute("categories", null);
        
        return "inventory/monthlyInventory";
    }
} 