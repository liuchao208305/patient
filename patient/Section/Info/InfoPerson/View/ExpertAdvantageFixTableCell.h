//
//  ExpertAdvantageFixTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/5/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextEntity.h"

@interface ExpertAdvantageFixTableCell : UITableViewCell

@property (strong,nonatomic)UIView *mainView;
//@property (strong,nonatomic)UIImageView *titleImageView;
//@property (strong,nonatomic)UILabel *titleLabel;
//@property (strong,nonatomic)UILabel *bodyLabel;
//
//@property (strong,nonatomic)UIButton *button;

@property (strong,nonatomic)UIView *lineView;

@property(nonatomic, strong)TextEntity *entity;
@property(nonatomic, copy) void (^showMoreTextBlock)(UITableViewCell  *currentCell);
+(CGFloat)cellDefaultHeight:(TextEntity *)entity;
+(CGFloat)cellMoreHeight:(TextEntity *)entity;

@end
