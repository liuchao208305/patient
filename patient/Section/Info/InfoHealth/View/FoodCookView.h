//
//  FoodCookView.h
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCookView : UIView

@property (strong,nonatomic)NSString *dishId;
@property (strong,nonatomic)NSString *dishQuantity;

@property (strong,nonatomic)UIImageView *dishImageView;
@property (strong,nonatomic)UILabel *dishNameLabel;

@end
