package org.myweb.first.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.myweb.first.product.model.service.ProductService;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/product")
public class ProductImageController {
    @Autowired
    private ProductService productService;

    @GetMapping("/image/{productId}")
    public void getProductImage(@PathVariable("productId") String productId, HttpServletResponse response) throws IOException {
        byte[] imageBytes = productService.getProductImage(productId);
        if (imageBytes != null && imageBytes.length > 0) {
            String contentType = "image/jpeg";
            // PNG 시그니처: 89 50 4E 47 0D 0A 1A 0A
            if (imageBytes.length > 8 &&
                (imageBytes[0] & 0xFF) == 0x89 &&
                (imageBytes[1] & 0xFF) == 0x50 &&
                (imageBytes[2] & 0xFF) == 0x4E &&
                (imageBytes[3] & 0xFF) == 0x47) {
                contentType = "image/png";
            }
            response.setContentType(contentType);
            response.getOutputStream().write(imageBytes);
        }
    }
} 