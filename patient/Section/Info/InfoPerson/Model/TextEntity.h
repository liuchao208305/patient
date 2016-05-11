//
//  TextEntity.h
//  patient
//
//  Created by ChaosLiu on 16/5/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextEntity : NSObject

@property(nonatomic, assign)int       textId;
@property(nonatomic, strong)NSString  *textName;
@property(nonatomic, strong)NSString  *textContent;
///是否展开状态，默认No
@property(nonatomic, assign)BOOL      isShowMoreText;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (instancetype)initWithTextName:(NSString *)textName textContent:(NSString *)textContent;

@end
