//
//  OrderHeadView.h
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderHeadViewClickedDelegate <NSObject>

-(void)orderHeadViewClicked;

@end

@interface OrderHeadView : UIView

@property (strong,nonatomic)UILabel *leftLabel;
@property (strong,nonatomic)UILabel *rightLabel;
@property (strong,nonatomic)UIImageView *rightImageView;

@property (strong,nonatomic)UIView *bottomLineView;

@property (weak,nonatomic)id<OrderHeadViewClickedDelegate> orderHeadViewClickedDelegate;

@end
