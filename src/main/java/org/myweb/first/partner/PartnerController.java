package org.myweb.first.partner;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/partner")
public class PartnerController {
    @GetMapping("partner.do")
    public String partnerPage() {
        return "partner/partner";
    }

    @GetMapping("register.do")
    public String partnerRegisterPage() {
        return "partner/partner_register";
    }

    @GetMapping("edit.do")
    public String partnerEditPage() {
        return "partner/partner_edit";
    }
} 