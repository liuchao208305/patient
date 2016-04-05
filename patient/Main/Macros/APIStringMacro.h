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
//#define kServerAddress     @"http://192.168.5.144:8080/jiuzhekan_http/public/v1/"// 内网测试地址－秦兵
//#define kServerAddress     @"http://192.168.5.102:83/jiuzhekan_http/public/v1/"// 内网测试地址－欧日广
#define kServerAddress     @"http://101.68.79.26:83/jiuzhekan_http/public/v1/"// 外网测试地址
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
} SERVER_RETURN_CODE;

//接口
/*
 #define GET_CONTENT_DETAIL      @"channel/getContentDetail" //获取内容详情(含上一个和下一个)
 #define GET_COMMENT_LIST        @"comment/getCommentList"   //获取评论列表
 #define COMMENT_LOGIN           @"comment/login"            //获取评论列表
 #define COMMENT_PUBLISH         @"comment/publish"          //发布评论
 #define COMMENT_DELETE          @"comment/delComment"       //删除评论
 #define LOGINOUT                @"common/logout"            //登出
 */
#define kJZK_LOGIN_GET_CATPCHA @"user/getCode?" //获取验证码
#define kJZK_QUICK_LOGIN @"user/fastLogin?"//快速登录
#define kJZK_NORMAL_LOGIN @"user/login?"//常规登录
#define kJZK_INFO_INFORMATION @"user/index?"//首页信息
#define kJZK_EXPERT_INFORMATION @"userDotor/detail?"//专家信息
#define kJZK_CLINIC_INFORMATION @"userDotor/fujin?" //诊所信息
#define kJZK_DOCTOR_INFORMATION @"user/selOutpat?"//医生信息
#define kJZK_SCHEDULE_INFORMATION @"user/selDoctorPaiban?"//时间表信息

#endif /* APIStringMacro_h */
