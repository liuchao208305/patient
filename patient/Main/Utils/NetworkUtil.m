//
//  NetworkUtil.m
//  patient
//
//  Created by ChaosLiu on 16/3/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "NetworkUtil.h"
#import <AFNetworking.h>

@implementation NetworkUtil

+(NetworkUtil *)sharedInstance{
    static NetworkUtil *sharedNetworkUtil = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetworkUtil = [[self alloc] init];
    });
    return sharedNetworkUtil;
}

-(AFHTTPSessionManager *)baseHtppRequest{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    
    [manager.requestSerializer setTimeoutInterval:30];
    
//        [manager.requestSerializer setValue:K_PASS_IP forHTTPHeaderField:@"Host"];
        [manager.requestSerializer setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
        [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3" forHTTPHeaderField:@"Accept-Language"];
        [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [manager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
        [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0" forHTTPHeaderField:@"User-Agent"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    
    return  manager;
}

-(void)getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    [[NetworkMonitorUtil sharedInstance] startNetWorkMonitor];
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:urlStr parameters:parameter success:^(NSURLSessionDataTask *task,id responseObject){
        successBlock(task,responseObject);
    }failure:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(task,error);
    }];
}

-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    [[NetworkMonitorUtil sharedInstance] startNetWorkMonitor];
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:urlStr parameters:parameter success:^(NSURLSessionDataTask *task,id responseObject){
        successBlock(task,responseObject);
    }failure:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(task,error);
    }];
}

-(void)upImageWithParameter:(NSDictionary *)parameter imageArray:(NSArray *)images url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    [[NetworkMonitorUtil sharedInstance] startNetWorkMonitor];
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        for (int i = 1; i<=images.count; i++) {
            NSData *imageData = UIImageJPEGRepresentation(images[i-1], 1.0);
//            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image%d",i] fileName:@"image" mimeType:@"image/jpg"];
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image%d",i] fileName:@"png" mimeType:@"image/png"];
        }
    }success:^(NSURLSessionDataTask *task,id responseObject){
        successBlock(task,responseObject);
    }failure:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(task,error);
    }];
}

- (void)uploadFileWithParameter:(NSDictionary *)parameter names:(NSArray *)names urlStr:(NSString *)urlStr fileURLs:(NSArray *)fileURLs fileName:(NSString *)fileName mimeType:(NSString *)mimeType successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    [[NetworkMonitorUtil sharedInstance] startNetWorkMonitor];
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    NSString *urlString =  [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:urlString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>formData) {
        for (int i = 0; i<fileURLs.count; i++) {
            NSData *data = [NSData dataWithContentsOfFile:fileURLs[i]];
            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%@",names[i]] fileName:fileName mimeType:mimeType];
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        successBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(task,error);
    }];
}

-(void)downloadFileWithUrlStr:(NSString *)urlStr flag:(NSString *)flag successBlock:(SuccessBlockFix)successBlock failureBlock:(FailureBlockFix)failureBlock{
    [[NetworkMonitorUtil sharedInstance] startNetWorkMonitor];
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response){
        if ([flag isEqualToString:@"advice"]) {
            NSURL *filePath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
            return [filePath URLByAppendingPathComponent:[response suggestedFilename]];
        }else{
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *path = [cachePath stringByAppendingPathComponent:response.suggestedFilename];
            return [NSURL fileURLWithPath:path];
        }
    }completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        DLog(@"Finish and Download to: %@", filePath);
        if (error) {
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            failureBlock(errorStr);
        } else{
            successBlock(filePath);
        }
    }];
    [downloadTask resume];
}

@end
