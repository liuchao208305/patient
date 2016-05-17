//
//  HealthFoodInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface HealthFoodInfoViewController : BaseViewController

@property (assign,nonatomic)NSInteger healthType;
@property (strong,nonatomic)NSString *healthId;
@property (strong,nonatomic)NSString *healthName;

@end
