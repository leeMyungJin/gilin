package com.gilin.Cms.Mapper;

import com.gilin.Cms.Vo.CmsPushVo;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface CmsPushMapper {

    public List<CmsPushVo> getListBySearch(HashMap<String, Object> params);
    public void update(CmsPushVo pushVo);
    public int create(HashMap<String, String> params);
    public int create_detail(HashMap<String, String> params);

}
