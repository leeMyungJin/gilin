package com.gilin.Cms.Service.Impl;

import com.gilin.Cms.Mapper.CmsNoticeMapper;
import com.gilin.Cms.Service.CmsNoticeService;
import com.gilin.Cms.Util.Login;
import com.gilin.Cms.Vo.CmsNoticeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CmsNoticeServiceImpl implements CmsNoticeService {

    @Autowired
    CmsNoticeMapper noticeMapper;

    @Override
    public List<CmsNoticeVo> getList() {
        return noticeMapper.getList();
    }

    @Override
    public List<CmsNoticeVo> getMustList() {
        return noticeMapper.getMustList();
    }

    @Override
    public Map<String, Integer> getCount() {
        return noticeMapper.getCount();
    }

    @Override
    public List<CmsNoticeVo> getListBySearch(HashMap<String, Object> params) {
        return noticeMapper.getListBySearch(params);
    }

    @Override
    public void create(HashMap<String, Object> params) {
        params.put("cretId", Login.getId());
        noticeMapper.create(params);
    }

    @Override
    public void update(HashMap<String, Object> params) {
        params.put("updtId", Login.getId());
        noticeMapper.update(params);
    }

    @Override
    public void delete(HashMap<String, Object> params) {
        noticeMapper.delete(params);
    }

    @Override
    public List<CmsNoticeVo> getListPaging(HashMap<String, Object> params) {
        return noticeMapper.getListPaging(params);
    }


}
