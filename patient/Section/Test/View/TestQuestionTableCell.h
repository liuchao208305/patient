//
//  TestQuestionTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/4/20.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionDelegate <NSObject>

-(void)changeAnsweredQuestionQuantity:(BOOL)flag;

@end

@interface TestQuestionTableCell : UITableViewCell

@property (strong,nonatomic)UIView *topBackView;
@property (strong,nonatomic)UILabel *quesionLabel;

@property (strong,nonatomic)UIView *separateLineView;

@property (strong,nonatomic)UIView *bottomBackView;
@property (strong,nonatomic)UIButton *noneButton;
@property (strong,nonatomic)UIButton *fewButton;
@property (strong,nonatomic)UIButton *occasionButton;
@property (strong,nonatomic)UIButton *alwaysButton;

@property (assign,nonatomic)BOOL isNoneButtonClicked;
@property (assign,nonatomic)BOOL isFewButtonClicked;
@property (assign,nonatomic)BOOL isOccasionButtonClicked;
@property (assign,nonatomic)BOOL isAlwaysButtonClicked;

@property (assign,nonatomic)BOOL isQuestionAnswered;

@property (weak,nonatomic)id<QuestionDelegate> questionDelegate;

@end
