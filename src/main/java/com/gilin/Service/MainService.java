package com.gilin.Service;

import java.util.HashMap;
import java.util.List;

import com.gilin.vo.MainVo;
import com.gilin.vo.ProjectVo;

public interface MainService {
	 public List<MainVo> getNoticeList(HashMap<String,Object> params);
}