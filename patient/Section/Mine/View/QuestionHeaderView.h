//
//  QuestionHeaderView.h
//  patient
//
//  Created by ChaosLiu on 16/7/6.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionHeadViewClickedDelegate <NSObject>

-(void)questionHeadViewClicked;

@end

@interface QuestionHeaderView : UIView

@property (strong,nonatomic)UILabel *leftLabel;
@property (strong,nonatomic)UILabel *rightLabel;
@property (strong,nonatomic)UIImageView *rightImageView;

@property (strong,nonatomic)UIView *bottomLineView;

@property (weak,nonatomic)id<QuestionHeadViewClickedDelegate>questionHeadViewClickedDelegate;

@end
