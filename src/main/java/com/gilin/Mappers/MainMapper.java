package com.gilin.Mappers;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gilin.vo.MainVo;


@Mapper
public interface MainMapper  {
	public List<MainVo> getNoticeList(HashMap<String,Object> params);
}
