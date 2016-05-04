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
//#define kServerAddress     @"http://192.168.5.46:83/jiuzhekan_http/"// 内网测试地址－秦兵
//#define kServerAddressPay   @"http://192.168.5.46:83/jiuzhekan_pay/"//外网测试地址—秦兵－支付
//#define kServerAddress     @"http://192.168.5.102:83/jiuzhekan_http/"// 内网测试地址－欧日广
#define kServerAddress     @"http://101.68.79.26:83/jiuzhekan_http/"// 外网测试地址
#define kServerAddressPay   @"http://101.68.79.26:83/jiuzhekan_pay/"//外网测试地址—支付
#else
//Release状态下的线上API
//#define kServerAddress     @"http://www.jiuzhekan.com/jiuzhekan_http/"//外网上线地址
//#define kServerAddressPay   @"http://www.jiuzhekan.com/jiuzhekan_pay/"//外网上线地址—支付
#endif

#define	kCODE	    @"code"
#define	kMESSAGE	@"message"
#define	kDATA	    @"data"

typedef enum {
    kSUCCESS = 0,//成功
    kERROR = 1,//失败
    kTOKENINVALID = 3//Token失效
} SERVER_RETURN_CODE;

/*========================================接口===============================================*/
#define kJZK_LOGIN_GET_CATPCHA @"public/v1/user/getCode?" //获取验证码
#define kJZK_QUICK_LOGIN @"public/v1/user/fastLogin?"//快速登录
#define kJZK_NORMAL_LOGIN @"public/v1/user/login?"//常规登录
#define kJZK_THIRD_LOGIN @"public/v1/user/insertLogin?"//第三方登录
#define kJZK_INFO_INFORMATION @"public/v1/user/index?"//首页信息
#define kJZK_MORE_STUDIO_INFORMATION @"/public/v1/user/getMoreDoctorOrg?"//工作室列表
#define kJZK_MORE_PERSON_INFORMATION @"public/v1/user/getMoreMaxDoctor?"//专家列表
#define kJZK_EXPERT_INFORMATION @"public/v1/userDotor/detail?"//专家信息
#define kJZK_CLINIC_INFORMATION @"public/v1/userDotor/fujin?" //诊所信息
#define kJZK_DOCTOR_INFORMATION @"public/v1/user/selOutpat?"//医生信息
#define kJZK_SCHEDULE_INFORMATION @"public/v1/user/selDoctorPaiban?"//时间表信息

#define kJZK_TREATMENT_INFORMATION @"private/v1/getConuTx?"//预约单信息
#define kJZK_TREATMENT_CONFIRM_INFORMATION @"private/v1/user/confReservation?"//预约单确认
#define kJZK_TREATMENT_CANCEL_INFORMATION @"private/v1/user/exitConuBasic?"//预约单取消
#define kJZK_TREATMENT_DETAIL_INFORMATION @"private/v1/user/getConuByOrder?"//预约单详情
#define kJZK_TREATMENT_DETAIL_INFORMATION_PAYNOW @"private/v1/user/pay?"//预约单详情—立即支付
#define kJZK_CONTACT_INFORMATION_GET @"private/v1/user/getUserContact?"//获取常用联系人
#define KJZK_CONTACT_INFORMATION_ADD @"private/v1/user/addContact?"//添加常用联系人
#define KJZK_CONTACT_INFORMATION_DELETE @"private/v1/user/deleteContact?"//删除常用联系人
#define kJZK_ID_INFORMATION @"private/v1/user/getKeyExists?"//身份证或者医保信息
#define kJZK_RECORD_INFORMATION_ADD @"private/v1/user/addContactBook?"//添加病历本
#define kJZK_COUPON_INFORMATION @"private/v1/user/getUserConpou?"//优惠券信息
#define kJZK_COUPON_INFORAMTION_EXCHANGE @"private/v1/user/getCouponByCode?"//优惠券兑换
#define kJZK_ORDER_INFORMATION @"private/v1/user/getConuListPage?"//订单列表信息
#define kJZK_ORDER_DETAIL_INFORMATION @"private/v1/user/getConuBasicByConId?"//订单详情

#define kJZK_TEST_INFORMATION_GET @"public/v1/pageAnalysis?"//获取体质测试信息
#define kJZK_TEST_INFORMATION_CONFIRM @"public/v1/commitAnalysis?"//提交体质测试信息
#define kJZK_TEST_RESULT_LIST_INFORMATION @"private/v1/getAnalysisResultPage?"//分页获取体质测试结果列表信息
#define kJZK_TEST_RESULT_DETAIL_INFORMATION @"public/v1/getAnalyResultDetail?"//获取体质测试结构详情信息

#define kJZK_MINE_INFORMATION @"private/v1/user/selUserInfo?"//个人中心信息
#define kJZK_MINE_SETTING_INFOMATION_CONFIRM @"private/v1/user/updateSet?"//提交个人设置信息
#define kJZK_MINE_PASSWORD_RESET_CAPTCHA @"public/v1/user/getPwdCode?"//重置密码验证码
#define kJZK_MINE_PASSWORD_RESET_CONFIRM @"public/v1/user/updateUserNewPwd?"//重置密码确认

#define kJZK_FILE_UPLOAD @"public/v1/upload1?"//文件上传
#define kJZK_HEAD_IMAGE_UPLOAD @"private/v1/user/updateHeand?"//更改个人头像
#define kJZK_IMAGE_UPLOAD @"private/v1/user/updateConuPhoto?"//图片上传
/*========================================接口===============================================*/

#endif /* APIStringMacro_h */
