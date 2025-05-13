package org.myweb.first.partner.model.service;

import java.util.List;
import java.util.Map;

import org.myweb.first.partner.model.dto.Partner;
import org.myweb.first.partner.model.dto.PartnerSearchCondition;

public interface PartnerService {
    List<Partner> selectAllPartners();
    Partner selectPartnerById(String partnerId);
    int insertPartner(Partner partner);
    int updatePartner(Partner partner);
    int deletePartner(String partnerId);
    List<Partner> searchPartners(PartnerSearchCondition cond);
    List<Map<String, String>> selectSuppliersOnly();
    List<Map<String, String>> selectVendorsOnly();
    List<Map<String, String>> selectVendorGroups();
} 