package com.gilin.Cms.Mapper;

import com.gilin.Cms.Vo.CmsMemberVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface CmsMemberMapper {

    public List<CmsMemberVo> getList();

    public Map<String, Integer> getCount();

    public List<CmsMemberVo> getListSearch(HashMap<String, Object> params);

}
