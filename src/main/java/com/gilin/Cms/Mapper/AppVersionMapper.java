package com.gilin.Cms.Mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AppVersionMapper {

    public String getVersion();

    public void update(String version);

}
