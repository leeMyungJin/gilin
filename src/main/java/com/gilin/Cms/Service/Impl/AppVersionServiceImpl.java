package com.gilin.Cms.Service.Impl;

import com.gilin.Cms.Mapper.AppVersionMapper;
import com.gilin.Cms.Service.AppVersionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppVersionServiceImpl implements AppVersionService {

    @Autowired
    AppVersionMapper appVersionMapper;

    @Override
    public String getVersion() {
        return appVersionMapper.getVersion();
    }

    @Override
    public void update(String version) {
        appVersionMapper.update(version);
    }


}
