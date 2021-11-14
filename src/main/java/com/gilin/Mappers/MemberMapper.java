package com.gilin.Mappers;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface MemberMapper  {
	public void updateNickname( HashMap<String,String> params);
	
}
