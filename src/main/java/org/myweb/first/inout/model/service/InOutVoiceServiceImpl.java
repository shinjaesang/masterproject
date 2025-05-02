package org.myweb.first.inout.model.service;

import java.util.List;
import java.util.Map;

import org.myweb.first.inout.model.dao.InOutVoiceDao;
import org.myweb.first.inout.model.dto.InOutVoice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class InOutVoiceServiceImpl implements InOutVoiceService {

    private final InOutVoiceDao inOutVoiceDao;

    public InOutVoiceServiceImpl(InOutVoiceDao inOutVoiceDao) {
        this.inOutVoiceDao = inOutVoiceDao;
    }

    @Override
    public List<InOutVoice> selectInOutVoiceList(Map<String, Object> params) {
        return inOutVoiceDao.selectInOutVoiceList(params);
    }

    @Override
    public InOutVoice selectInOutVoiceById(String inoutvoiceId) {
        return inOutVoiceDao.selectInOutVoiceById(inoutvoiceId);
    }

    @Override
    public int insertInOutVoice(InOutVoice inOutVoice) {
        return inOutVoiceDao.insertInOutVoice(inOutVoice);
    }

    @Override
    public int updateInOutVoice(InOutVoice inOutVoice) {
        return inOutVoiceDao.updateInOutVoice(inOutVoice);
    }

    @Override
    public int deleteInOutVoice(String inoutvoiceId) {
        return inOutVoiceDao.deleteInOutVoice(inoutvoiceId);
    }

    @Override
    public int selectInOutVoiceTotalCount(Map<String, Object> params) {
        return inOutVoiceDao.selectInOutVoiceTotalCount(params);
    }
} 