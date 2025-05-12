package org.myweb.first.partner.model.service;

import java.util.List;

import org.myweb.first.partner.model.dao.PartnerDao;
import org.myweb.first.partner.model.dto.Partner;
import org.myweb.first.partner.model.dto.PartnerSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PartnerServiceImpl implements PartnerService {

    @Autowired
    private PartnerDao partnerDao;

    @Override
    public List<Partner> selectAllPartners() {
        return partnerDao.selectAllPartners();
    }

    @Override
    public Partner selectPartnerById(String partnerId) {
        return partnerDao.selectPartnerById(partnerId);
    }

    @Override
    public int insertPartner(Partner partner) {
        return partnerDao.insertPartner(partner);
    }

    @Override
    public int updatePartner(Partner partner) {
        return partnerDao.updatePartner(partner);
    }

    @Override
    public int deletePartner(String partnerId) {
        return partnerDao.deletePartner(partnerId);
    }

    @Override
    public List<Partner> searchPartners(PartnerSearchCondition cond) {
        return partnerDao.searchPartners(cond);
    }

    @Override
    public List<Partner> selectSuppliersOnly() {
        return partnerDao.selectSuppliersOnly();
    }
} 