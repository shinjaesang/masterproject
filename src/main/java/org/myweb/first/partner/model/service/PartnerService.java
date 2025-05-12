package org.myweb.first.partner.model.service;

import java.util.List;

import org.myweb.first.partner.model.dto.Partner;
import org.myweb.first.partner.model.dto.PartnerSearchCondition;

public interface PartnerService {
    List<Partner> selectAllPartners();
    Partner selectPartnerById(String partnerId);
    int insertPartner(Partner partner);
    int updatePartner(Partner partner);
    int deletePartner(String partnerId);
    List<Partner> searchPartners(PartnerSearchCondition cond);
    List<Partner> selectSuppliersOnly();
} 