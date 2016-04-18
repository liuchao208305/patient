//
//  ContactData.h
//  patient
//
//  Created by ChaosLiu on 16/4/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactData : NSObject

@property (strong,nonatomic)NSString *user_id;
@property (strong,nonatomic)NSString *contact_id;
@property (strong,nonatomic)NSString *real_name;
@property (assign,nonatomic)NSInteger sex;
@property (assign,nonatomic)NSInteger age;
@property (assign,nonatomic)NSInteger existsbook;
@property (strong,nonatomic)NSString *id_number;
@property (strong,nonnull)NSString *phone;

@end
