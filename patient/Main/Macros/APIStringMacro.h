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
//#define kServerAddress     @"http://192.168.5.44:83/jiuzhekan_http/"// 内网测试地址－秦兵
//#define kServerAddressPay   @"http://192.168.5.44:83/jiuzhekan_pay/"//外网测试地址—秦兵－支付
#define kServerAddress     @"http://101.68.79.26:84/jiuzhekan_http/"// 外网测试地址
#define kServerAddressPay   @"http://101.68.79.26:84/jiuzhekan_pay/"//外网测试地址—支付
//#define kServerAddress     @"http://101.68.79.26:83/jiuzhekan_http/"// 外网预发布地址
//#define kServerAddressPay   @"http://101.68.79.26:83/jiuzhekan_pay/"//外网预发布地址—支付
#else
//Release状态下的线上API
//#define kServerAddress     @"http://101.68.79.26:84/jiuzhekan_http/"//外网上线地址
//#define kServerAddressPay   @"http://101.68.79.26:84/jiuzhekan_pay/"//外网上线地址—支付
#endif

#define	kCODE	    @"code"
#define	kMESSAGE	@"message"
#define	kDATA	    @"data"

typedef enum {
    kSUCCESS = 0,//成功
    kERROR = 1,//失败
    kTOKENINVALID = 3,//Token失效
} SERVER_RETURN_CODE;

/*========================================接口===============================================*/
#define kJZK_LOGIN_GET_CATPCHA @"public/v1/user/getCode?" //获取验证码
#define kJZK_QUICK_LOGIN @"public/v1/user/fastLogin?"//快速登录
#define kJZK_NORMAL_LOGIN @"public/v1/user/login?"//常规登录
#define kJZK_THIRD_LOGIN @"public/v1/user/insertLogin?"//第三方登录
#define kJZK_INFO_INFORMATION @"public/v1/user/index?"//首页信息
#define kJZK_DISEASE_INFOMATION @"public/v1/getSpecialDetail?"//疾病专题信息
#define kJZK_MORE_HEALTH_INFORMATION @"public/v1/user/getFoodBasicAppPage?"//健康饮食列表
#define kJZK_HEALTH_INFORMATION @"public/v1/user/getFoodBasicDetail?"//健康饮食信息
#define kJZK_HEALTH_COMMENT_AND_FAVOURITE @"private/v1/user/likeOrAtteation?"//健康点赞和收藏
#define kJZK_MORE_STUDIO_INFORMATION @"public/v1/user/getMoreDoctorOrg?"//工作室列表
#define kJZK_STUDIO_INFORMATION @"public/v1/minDoctor/getDoctorOrg?"//工作室信息
#define kJZK_STUDIO_INFORMATION_FIX @"public/v2/minDoctor/getDoctorOrgDetail?"//工作室信息Fix
#define kJZK_MORE_PERSON_INFORMATION @"public/v1/user/doctorPage?"//专家列表
#define kJZK_EXPERT_INFORMATION @"public/v1/userDotor/detail?"//专家信息
#define kJZK_EXPERT_INFORMATION_FIX @"private/v2/getDoctorDetailByDoctorID?"//专家信息
#define kJZK_CLINIC_INFORMATION @"public/v1/userDotor/fujin?" //诊所信息
#define kJZK_EXPERT_FOCUS @"private/v1/user/atteationOrexit?"//专家关注
#define kJZK_DOCTOR_INFORMATION @"public/v1/user/selOutpat?"//医生信息
#define kJZK_SCHEDULE_INFORMATION @"public/v1/user/selDoctorPaiban?"//时间表信息

#define kJZK_TREATMENT_INFORMATION @"private/v1/getConuTx?"//预约单信息
//#define kJZK_TREATMENT_CONFIRM_INFORMATION @"private/v1/user/confReservation?"//预约单确认
#define kJZK_TREATMENT_CANCEL_INFORMATION @"private/v1/user/exitConuBasic?"//预约单取消
#define kJZK_TREATMENT_DETAIL_INFORMATION @"private/v1/user/getConuByOrder?"//预约单详情
#define kJZK_TREATMENT_DETAIL_INFORMATION_PAYNOW @"private/v1/user/pay?"//预约单详情—立即支付
#define kJZK_CONTACT_INFORMATION_GET @"private/v1/user/getUserContact?"//获取常用联系人
#define KJZK_CONTACT_INFORMATION_ADD @"private/v1/user/addContact?"//添加常用联系人
#define KJZK_CONTACT_INFORMATION_DELETE @"private/v1/user/deleteContact?"//删除常用联系人
#define kJZK_ID_INFORMATION @"private/v1/user/getKeyExists?"//身份证或者医保信息
#define kJZK_RECORD_INFORMATION_ADD @"private/v1/user/addContactBook?"//添加病历本
#define kJZK_RECORD_LIST_INFORMATION @"private/v1/user/memberBookDetails?"//病历本列表信息
#define kJZK_COUPON_INFORMATION @"private/v1/user/getUserConpou?"//优惠券信息
#define kJZK_COUPON_INFORAMTION_EXCHANGE @"private/v1/user/getCouponByCode?"//优惠券兑换
#define kJZK_ORDER_INFORMATION @"private/v1/user/getConuListPage?"//订单列表信息
#define kJZK_ORDER_DETAIL_INFORMATION @"private/v1/user/getConuBasicByConId?"//订单详情

#define kJZK_HEALTH_LIST_INFORMATION @"private/v2/getJiankan?"//健康列表信息
#define kJZK_HEALTH_LIST_DETAIL_INFORMATION @"public/v2/qhealthy/interList?"//健康列表详情信息
#define kJZK_HEALTH_DISEASE_AND_MARRIAGE_INFORMATION @"private/v2/getUserHistoryByUserid?"//疾病史和婚姻史信息接口
#define kJZK_HEALTH_DISEASE_HISTORY_CONFIRM @"private/v2/qUserHistory/updateOrInster"//疾病史提交
#define kJZK_HEALTH_MARRIAGE_HISTORY_CONFIRM @"private/v2/qUserHistory/updateOrInster"//婚姻史提交
#define kJZK_HEALTH_SELF_INSPECTION_CONFIRM @"private/v2/qhealthy/add?"//健康自查提交

#define kJZK_TEST_INFORMATION_GET @"public/v1/pageAnalysis?"//获取体质测试信息
#define kJZK_TEST_INFORMATION_CONFIRM @"public/v1/commitAnalysis?"//提交体质测试信息
#define kJZK_TEST_RESULT_LIST_INFORMATION @"private/v1/getAnalysisResultPage?"//分页获取体质测试结果列表信息
#define kJZK_TEST_RESULT_DETAIL_INFORMATION @"public/v1/getAnalyResultDetail?"//获取体质测试结果详情信息

#define kJZK_QUESTION_LIST_MINE_INFORMATION @"private/v2/interloution/zijiPagelist?"//我的问题列表信息
#define kJZK_QUESTION_LIST_OTHER_INFORMATION @"private/v2/interloution/otherPagelist?"//其他问题列表信息
#define kJZK_QUESTION_INQUIRY_ALL_INFROMATION @"private/v2/getDoctorInterlocution?"//不指定专家提问信息
#define kJZK_QUESTION_INQUIRY_SPECIAL_INFORMAITON @"private/v2/getDoctorInterlocution?"//指定专家提问信息
#define kJZK_QUESTION_CONFIRM_INFORMATION @"private/v2/interloution/add?"//问题确认提交
#define kJZK_QUESTION_PAY_INFORMATION @"private/v2/limaPay?"//问题立即支付
#define kJZK_QUESTION_DELETE_INFORMATION @"private/v2/quxiaoInter?"//问答删除接口
#define kJZK_QUESTION_DETAIL_INFORMAITON @"public/v2/interloution/detail?"//问题详情接口
#define kJZK_QUESTION_FUFEITING_INFORMATION @"private/v2/clickAnswerPay?"//问题付费听接口
#define kJZK_QUESTION_MIANFEITING_INFORMATION @"private/v2/clickAnswer?"//问题免费听接口

#define kJZK_BOOK_INFORMATION @"private/v2/user/conu/toAdd?"//专家预约查询接口
#define kJZK_BOOK_CLINIC_ADDRESS_INFORMATION @"private/v2/user/conu/getDoctorAComms?"//专家预约页面诊所地址信息
#define kJZK_BOOK_EXPERT_TIME_INFORMATION @"private/v2/user/conu/getDatesByComm?"//专家预约页面时间信息
#define kJZK_BOOK_CONFIRM @"private/v2/user/confReservation?"//专家预约提交接口

#define kJZK_MINE_QUESTION_INFORMATION @"private/v2/user/getInterPageList?"//问答列表信息

#define kJZK_ORDER_INFORMATION_FIX @"private/v2/userCore/getUserConuPageByUserId?"//订单列表信息
#define kJZK_ORDER_LIST_PAY @"private/v1/user/pay?"//订单列表支付
#define kJZK_ORDER_DETAIL_INFORMATION_FIX @"private/v2/userCore/getConuBasicByConIDv?"//订单详情

#define kJZK_MINE_EXPERT_FIX_INFORMATION @"private/v2/userCore/getUserDoctoryByUserId?"//我的专家信息

#define kJZK_MINE_WALLET_INFORMATION_ONE @"private/v2/user/getUserMoney?"//我的钱包信息1
#define kJZK_MINE_WALLET_INFORMATION_TWO @"public/v2/user/getUserMoneyPageList?"//我的钱包信息2
#define kJZK_MINE_WALLET_TIXIAN_ONE @"private/v2/user/getUserWeixinByUserID?"//我的钱包提现1
#define kJZK_MINE_WALLET_TIXIAN_TWO @"private/v2/user/getUserApplyPayCode?"//我的钱包提现2
#define kJZK_MINE_WALLET_TIXIAN_THREE @"private/v2/user/insertUserApplyPay?"//我的钱包提现3

#define kJZK_MINE_INFORMATION_FIX @"private/v2/user/selUserInfo?"//个人中心信息

#define kJZK_MINE_FEEDBACK_CONFIRM @"public/v2/opinion/add?"//意见反馈信息提交
#define kJZK_ACCOUNT_SECURITY_INFORMATION @"private/v2/safe/toSafe?"//账户安全信息获取接口
#define kJZK_CHANGE_PHONE_INFORMATION_ONE @"private/v2/user/getPhoneCode?"//绑定手机号接口1
#define kJZK_CHANGE_PHONE_INFORMATION_TWO @"public/v2/user/validatePhoneCode"//绑定手机号接口2（旧手机）
#define kJZK_CHANGE_PHONE_INFORMATION_FOUR @"private/v2/user/updateBindingPhone?"//绑定手机号接口4（新手机）
#define kJZK_CHANGE_EMAIL_INFORMATION @"private/v2/user/updateUserEmail?"//修改绑定邮箱接口
#define kJZK_THIRD_AUTHORIZATION @"private/v2/auth/binding?"//第三方授权接口

#define kJZK_MINE_INFORMATION @"private/v1/user/selUserInfo?"//个人中心信息
#define kJZK_MINE_MESSAGE_INFORMATION @"private/v1/user/getUserMessagePage?"//消息列表信息
#define kJZK_MINE_MESSAGE_DETAIL_INFORMATION @"private/v1/user/messageDatailByID?"//消息详情信息
#define kJZK_MINE_SETTING_INFOMATION_CONFIRM @"private/v1/user/updateSet?"//提交个人设置信息
#define kJZK_MINE_PASSWORD_RESET_CAPTCHA @"public/v1/user/getPwdCode?"//重置密码验证码
#define kJZK_MINE_PASSWORD_RESET_CONFIRM @"public/v1/user/updateUserNewPwd?"//重置密码确认
#define kJZK_MINE_EXPERT_INFORMATION @"private/v1/user/getUserDoctors?"//我的专家信息
#define kJZK_MINE_FAVOURITE_INFORMATION @"private/v1/user/getUserLikePage?"//我的收藏夹信息

#define kJZK_FILE_UPLOAD @"public/v1/upload1?"//文件上传
#define kJZK_HEAD_IMAGE_UPLOAD @"private/v1/user/updateHeand?"//更改个人头像
#define kJZK_IMAGE_UPLOAD @"private/v1/user/updateConuPhoto?"//图片上传
/*========================================接口===============================================*/

#endif /* APIStringMacro_h */
