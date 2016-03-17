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

//接口
/*
 #define GET_CONTENT_DETAIL      @"channel/getContentDetail" //获取内容详情(含上一个和下一个)
 #define GET_COMMENT_LIST        @"comment/getCommentList"   //获取评论列表
 #define COMMENT_LOGIN           @"comment/login"            //获取评论列表
 #define COMMENT_PUBLISH         @"comment/publish"          //发布评论
 #define COMMENT_DELETE          @"comment/delComment"       //删除评论
 #define LOGINOUT                @"common/logout"            //登出
 */

#endif /* APIStringMacro_h */
