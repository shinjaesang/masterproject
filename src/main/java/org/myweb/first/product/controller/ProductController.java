package org.myweb.first.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/products")
public class ProductController {

    @GetMapping("/list.do")
    public String productList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        // TODO: 실제 데이터를 가져오는 로직 구현
        // 임시 데이터 설정
        model.addAttribute("products", null);
        model.addAttribute("pageInfo", null);
        model.addAttribute("suppliers", null);
        model.addAttribute("categories", null);
        
        return "product/productsList";
    }

    @GetMapping("/register.do")
    public String productRegister(Model model) {
        // TODO: 실제 데이터를 가져오는 로직 구현
        model.addAttribute("suppliers", null);
        model.addAttribute("categories", null);
        
        return "product/productsRegister";
    }

    @GetMapping("/edit.do")
    public String productEdit(
            @RequestParam(value = "id", required = true) Long id,
            Model model) {
        // TODO: 실제 데이터를 가져오는 로직 구현
        model.addAttribute("product", null);
        model.addAttribute("suppliers", null);
        model.addAttribute("categories", null);
        
        return "product/productsEdit";
    }

    @GetMapping("/detail.do")
    public String productDetail(
            @RequestParam(value = "id", required = true) Long id,
            Model model) {
        // TODO: 실제 데이터를 가져오는 로직 구현
        model.addAttribute("product", null);
        model.addAttribute("productHistory", null);
        
        return "product/productsDetail";
    }
} 