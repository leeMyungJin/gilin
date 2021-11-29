package com.gilin.Cms.Mapper;

import com.gilin.Cms.Vo.CmsNoticeVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface CmsNoticeMapper {

    public List<CmsNoticeVo> getList();
    public List<CmsNoticeVo> getMustList();
    public Map<String, Integer> getCount();
    public List<CmsNoticeVo> getListBySearch(HashMap<String, Object> params);
    public void create(HashMap<String, Object> params);
    public void update(HashMap<String, Object> params);
    public void delete(HashMap<String, Object> params);
    public List<CmsNoticeVo> getListPaging(HashMap<String, Object> params);

}
