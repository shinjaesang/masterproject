package org.myweb.first.product.controller;

import java.util.List;
import java.io.IOException;

import org.myweb.first.product.model.dto.Product;
import org.myweb.first.product.model.dto.ProductSearchCondition;
import org.myweb.first.product.model.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;

@Controller
@RequestMapping("/product")
public class ProductController {
    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    private ProductService productService;

    // 상품 목록 페이지
    @GetMapping("/product.do")
    public String productList() {
        return "product/product";
    }

    // 상품 등록 페이지
    @GetMapping("/register.do")
    public String productRegister() {
        return "product/productRegister";
    }

    // 상품 수정 페이지
    @GetMapping("/edit.do")
    public String productEdit(@RequestParam("productId") String productId, Model model) {
        logger.info("상품 수정 페이지 요청: {}", productId);
        Product product = productService.selectProductById(productId);
        model.addAttribute("product", product);
        return "product/productEdit";
    }

    // 상품 목록 조회 (AJAX)
    @GetMapping("/list")
    @ResponseBody
    public List<Product> getProductList(ProductSearchCondition cond) {
        logger.info("=== 상품 목록 조회 시작 ===");
        logger.info("검색 조건: {}", cond);
        List<Product> result;
        if ((cond.getProductName() == null || cond.getProductName().isEmpty()) &&
            (cond.getProductId() == null || cond.getProductId().isEmpty()) &&
            (cond.getPartnerId() == null || cond.getPartnerId().isEmpty()) &&
            (cond.getProductType() == null || cond.getProductType().isEmpty()) &&
            (cond.getCategory() == null || cond.getCategory().isEmpty()) &&
            (cond.getCountryOfOrigin() == null || cond.getCountryOfOrigin().isEmpty())) {
            logger.info("전체 목록 조회");
            result = productService.selectAllProducts();
        } else {
            logger.info("검색 조건으로 조회");
            result = productService.searchProducts(cond);
        }
        logger.info("조회 결과: {}", result);
        logger.info("=== 상품 목록 조회 종료 ===");
        return result;
    }

    // 상품 상세 조회 (AJAX)
    @GetMapping("/{productId}")
    @ResponseBody
    public Product getProduct(@PathVariable("productId") String productId) {
        logger.info("상품 상세 조회: {}", productId);
        return productService.selectProductById(productId);
    }

    // 상품 등록
    @PostMapping("/add")
    public String addProduct(
            @RequestParam("productId") String productId,
            @RequestParam("productName") String productName,
            @RequestParam(value = "optionValue", required = false) String optionValue,
            @RequestParam("productType") String productType,
            @RequestParam("partnerId") String partnerId,
            @RequestParam("category") String category,
            @RequestParam("costPrice") Double costPrice,
            @RequestParam("sellingPrice") Double sellingPrice,
            @RequestParam(value = "manufacturer", required = false) String manufacturer,
            @RequestParam(value = "countryOfOrigin", required = false) String countryOfOrigin,
            @RequestParam(value = "safeStock", required = false) Integer safeStock,
            @RequestParam(value = "productImage", required = false) MultipartFile productImage) throws IOException {
        
        logger.info("=== 상품 등록 시작 ===");
        try {
            Product product = new Product();
            product.setProductId(productId);
            product.setProductName(productName);
            product.setOptionValue(optionValue);
            product.setProductType(productType);
            product.setPartnerId(partnerId);
            product.setCategory(category);
            product.setCostPrice(costPrice);
            product.setSellingPrice(sellingPrice);
            product.setManufacturer(manufacturer);
            product.setCountryOfOrigin(countryOfOrigin);
            product.setSafeStock(safeStock);
            
            if (productImage != null && !productImage.isEmpty()) {
                product.setProductImage(productImage.getBytes());
            }
            
            logger.info("상품 정보: {}", product);
            int result = productService.insertProduct(product);
            logger.info("상품 등록 결과: {}", result);
            logger.info("=== 상품 등록 종료 ===");
        
            return "redirect:/product/product.do";
        } catch (Exception e) {
            logger.error("상품 등록 중 오류 발생", e);
            throw e;
        }
    }

    // 상품 수정
    @PostMapping("/update")
    public String updateProduct(
            @RequestParam("productId") String productId,
            @RequestParam("productName") String productName,
            @RequestParam(value = "optionValue", required = false) String optionValue,
            @RequestParam("productType") String productType,
            @RequestParam("partnerId") String partnerId,
            @RequestParam("category") String category,
            @RequestParam("costPrice") Double costPrice,
            @RequestParam("sellingPrice") Double sellingPrice,
            @RequestParam(value = "manufacturer", required = false) String manufacturer,
            @RequestParam(value = "countryOfOrigin", required = false) String countryOfOrigin,
            @RequestParam(value = "safeStock", required = false) Integer safeStock,
            @RequestParam(value = "productImage", required = false) MultipartFile productImage,
            @RequestParam(value = "deleteImage", required = false, defaultValue = "false") String deleteImage) throws IOException {
        
        logger.info("=== 상품 수정 시작 ===");
        try {
            Product product = new Product();
            product.setProductId(productId);
            product.setProductName(productName);
            product.setOptionValue(optionValue);
            product.setProductType(productType);
            product.setPartnerId(partnerId);
            product.setCategory(category);
            product.setCostPrice(costPrice);
            product.setSellingPrice(sellingPrice);
            product.setManufacturer(manufacturer);
            product.setCountryOfOrigin(countryOfOrigin);
            product.setSafeStock(safeStock);
            
            if ("true".equals(deleteImage)) {
                logger.info("이미지 삭제 요청");
                product.setProductImage(null);
            } else if (productImage != null && !productImage.isEmpty()) {
                logger.info("새로운 이미지 업로드");
                product.setProductImage(productImage.getBytes());
            } else {
                logger.info("기존 이미지 유지");
                // 기존 이미지를 유지하기 위해 현재 이미지를 다시 설정
                Product existingProduct = productService.selectProductById(productId);
                if (existingProduct != null) {
                    product.setProductImage(existingProduct.getProductImage());
                }
            }
            
            logger.info("상품 정보: {}", product);
            int result = productService.updateProduct(product);
            logger.info("상품 수정 결과: {}", result);
            logger.info("=== 상품 수정 종료 ===");
        
            return "redirect:/product/product.do";
        } catch (Exception e) {
            logger.error("상품 수정 중 오류 발생", e);
            throw e;
        }
    }

    // 상품 삭제 (AJAX)
    @DeleteMapping("/delete/{productId}")
    @ResponseBody
    public int deleteProduct(@PathVariable("productId") String productId) {
        logger.info("상품 삭제: {}", productId);
        return productService.deleteProduct(productId);
    }
} 