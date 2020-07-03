package com.atguigu.scw.test;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.utils.MD5Util;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import java.util.List;

@RunWith(value= SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-beans.xml",
        "classpath:spring/spring-mybatis.xml","classpath:spring/spring-tx.xml"})

public class MapperTest {
    //自动装配mapper对象：
    //@Autowired 只能在spring管理的组件类中使用
    @Autowired
    TAdminMapper tadminMapper;

    @Test
    public void test1() {
        List<TAdmin> tAdmins = tadminMapper.selectByExample(null);
        System.out.println(tAdmins);
    }

    @Test
    public void testMd5Util(){
/*        String encodePwd16 = MD5Util.digest16("123456");
        System.out.println("encodePwd16 = " + encodePwd16);
        String encodePwd321 = MD5Util.digest("123457");
        System.out.println("encodePwd321 = " + encodePwd321);*/
//e10adc3949ba59abbe56e057f20f883e
        String encodePwd32 = MD5Util.digest("123456");
        System.out.println("encodePwd32 = " + encodePwd32);
    }
}

