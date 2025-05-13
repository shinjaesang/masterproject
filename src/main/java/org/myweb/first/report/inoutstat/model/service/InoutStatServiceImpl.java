package org.myweb.first.report.inoutstat.model.service;

import org.myweb.first.report.inoutstat.model.dao.InoutStatDAO;
import org.myweb.first.report.inoutstat.model.dto.InoutStatChartDTO;
import org.myweb.first.report.inoutstat.model.dto.InoutStatDTO;
import org.myweb.first.report.inoutstat.model.dto.InoutStatSearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
public class InoutStatServiceImpl implements InoutStatService {

    @Autowired
    private InoutStatDAO inoutStatDAO;

    @Override
    public List<InoutStatDTO> getInoutStatList(InoutStatSearchDTO searchDTO) {
        return inoutStatDAO.selectInoutStatList(searchDTO);
    }

    @Override
    public InoutStatChartDTO getInoutStatChart(InoutStatSearchDTO searchDTO) {
        List<InoutStatDTO> statList = inoutStatDAO.selectInoutStatChart(searchDTO);
        
        InoutStatChartDTO chartDTO = new InoutStatChartDTO();
        chartDTO.setLabels(statList.stream()
                .map(InoutStatDTO::getStat_date)
                .collect(Collectors.toList()));
        chartDTO.setInData(statList.stream()
                .map(InoutStatDTO::getInAmount)
                .collect(Collectors.toList()));
        chartDTO.setOutData(statList.stream()
                .map(InoutStatDTO::getOutAmount)
                .collect(Collectors.toList()));
        chartDTO.setStockData(statList.stream()
                .map(InoutStatDTO::getStockAmount)
                .collect(Collectors.toList()));
        
        return chartDTO;
    }
} 