//
//  APIStringMacro.h
//  patient
//
//  Created by ChaosLiu on 16/3/2.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#ifndef APIStringMacro_h
#define APIStringMacro_h

//接口名称相关
#ifdef DEBUG
//Debug状态下的测试API
#define kServerUrl     @"http://192.168.5.144:8080/jiuzhekan_http/public/v1/user/getCode?"
#else
//Release状态下的线上API
#define kServerUrl     @"http://www.companydomain.com/api/"
#endif

#define	kCODE	    @"code"
#define	kMESSAGE	@"message"
#define	kDATA	    @"data"

typedef enum {
    kSUCCESS = 0,//成功
    kERROR = 1,//失败
} SERVER_COMMON_STATUS;

//接口
/*
 #define GET_CONTENT_DETAIL      @"channel/getContentDetail" //获取内容详情(含上一个和下一个)
 #define GET_COMMENT_LIST        @"comment/getCommentList"   //获取评论列表
 #define COMMENT_LOGIN           @"comment/login"            //获取评论列表
 #define COMMENT_PUBLISH         @"comment/publish"          //发布评论
 #define COMMENT_DELETE          @"comment/delComment"       //删除评论
 #define LOGINOUT                @"common/logout"            //登出
 */
#define kJZK_LOGIN_GET_CATPCHA @"http://192.168.5.144:8080/jiuzhekan_http/public/v1/user/getCode?" //获取验证码
#define kJZK_QUICK_LOGIN @"http://192.168.5.144:8080/jiuzhekan_http/public/v1/user/fastLogin?"//快速登录
#define kJZK_NORMAL_LOGIN @"http://192.168.5.144:8080/jiuzhekan_http/public/v1/user/login?"//常规登录

#endif /* APIStringMacro_h */
