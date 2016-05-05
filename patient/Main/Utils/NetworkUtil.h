//
//  NetworkUtil.h
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkMonitorUtil.h"

#define TIMEOUT 30

typedef void(^SuccessBlock)(NSURLSessionDataTask *task,id responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask *task,NSError *error);

typedef void(^SuccessBlockFix)(id resDict);
typedef void(^FailureBlockFix)(NSString *error);

@interface NetworkUtil : NSObject

+(NetworkUtil *)sharedInstance;
-(AFHTTPSessionManager *)baseHtppRequest;

#pragma mark - GET
-(void)getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - POST
-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - AFN上传照片
-(void)upImageWithParameter:(NSDictionary *)parameter imageArray:(NSArray *)images url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - AFN上传文件
-(void)uploadFileWithParameter:(NSDictionary *)parameter names:(NSArray *)names urlStr:(NSString *)urlStr fileURLs:(NSArray *)fileURLs fileName:(NSString *)fileName mimeType:(NSString *)mimeType successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - AFN下载文件
- (void)downloadFileWithUrlStr:(NSString *)urlStr flag:(NSString *)flag successBlock:(SuccessBlockFix)successBlock failureBlock:(FailureBlockFix)failureBlock;

@end
