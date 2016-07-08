//
//  TestQuestionTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/4/20.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

/**
 *  按钮选中状态
 */
typedef NS_OPTIONS(NSInteger, CellBtnStatu) {
    /**
     *  无选中状态
     */
    CellBtnStatuUnkown = 0,
    /**
     *  "没有"按钮
     */
    CellBtnStatuNone  = 1,
    /**
     *  "很少"按钮
     */
    CellBtnStatuFew  = 2,
    /**
     *  "有时"按钮
     */
    CellBtnStatuOccasion  = 3,
    /**
     *  "经常"按钮
     */
    CellBtnStatuOften = 4,
    /**
     *  "总是"按钮
     */
    CellBtnStatuAlways = 5
};

#import <UIKit/UIKit.h>

@protocol QuestionDelegate <NSObject>

@optional

/**
 *  5个按钮的点击回调事件
 *
 *  @param sender  按钮
 *  @param cellTag 按钮tag值
 *  @param str     问题名字
 */
- (void)cellBtnClick:(UIButton *)snedr cellTag:(NSInteger)cellTag item_name:(NSString *)str;

@end


@interface TestQuestionTableCell : UITableViewCell

@property (strong,nonatomic)UIView *topBackView;
@property (strong,nonatomic)UILabel *quesionLabel;

@property (strong,nonatomic)UIView *separateLineView;

@property (strong,nonatomic)UIView *bottomBackView;
@property (strong,nonatomic)UIButton *noneButton;
@property (strong,nonatomic)UIButton *fewButton;
@property (strong,nonatomic)UIButton *occasionButton;
@property (strong,nonatomic)UIButton *oftenButton;
@property (strong,nonatomic)UIButton *alwaysButton;

@property (assign,nonatomic)NSInteger cellTag;
@property (assign,nonatomic)NSInteger cellBtnStatu;

@property (weak,nonatomic)id<QuestionDelegate> delegate;

- (void)initViewWith:(CellBtnStatu)btnStatu;

@end
