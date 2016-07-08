//
//  MineWalletData.h
//  patient
//
//  Created by ChaosLiu on 16/7/8.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineWalletData : NSObject

@property (strong,nonatomic)NSString *price;
@property (strong,nonatomic)NSString *dates;
@property (assign,nonatomic)int type;
@property (strong,nonatomic)NSString *obj_id;
@property (strong,nonatomic)NSString *deal_id;
@property (assign,nonatomic)int obj_type;

@end
