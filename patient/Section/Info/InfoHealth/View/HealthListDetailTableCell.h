//
//  HealthListDetailTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/7/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthListDetailTableCell : UITableViewCell

@property (strong,nonatomic)UILabel *complainLabel1;
@property (strong,nonatomic)UILabel *complainLabel2;
@property (strong,nonatomic)UIView *complainLineView;
@property (strong,nonatomic)UILabel *shuimianLabel1;
@property (strong,nonatomic)UILabel *shuimianLabel2;
@property (strong,nonatomic)UIView *shuimianLineView;
@property (strong,nonatomic)UILabel *yinshiLabel1;
@property (strong,nonatomic)UILabel *yinshiLabel2;
@property (strong,nonatomic)UIView *yinshiLineView;
@property (strong,nonatomic)UILabel *yinshuiLabel1;
@property (strong,nonatomic)UILabel *yinshuiLabel2;
@property (strong,nonatomic)UIView *yinshuiLineView;
@property (strong,nonatomic)UILabel *dabianLabel1;
@property (strong,nonatomic)UILabel *dabianLabel2_1;
@property (strong,nonatomic)UILabel *dabianLabel2_2;
@property (strong,nonatomic)UILabel *dabianLabel2_3;
@property (strong,nonatomic)UIImageView *dabianImageView;
@property (strong,nonatomic)UIView *dabianLineView;
@property (strong,nonatomic)UILabel *xiaobianLabel1;
@property (strong,nonatomic)UILabel *xiaobianLabel2_1;
@property (strong,nonatomic)UILabel *xiaobianLabel2_1Fix;
@property (strong,nonatomic)UILabel *xiaobianLabel2_2;
@property (strong,nonatomic)UIView *xiaobianLineView;

@property (strong,nonatomic)UILabel *daixiaLabel1;
@property (strong,nonatomic)UILabel *daixiaLabel2;
@property (strong,nonatomic)UIView *daixiaLineView;
@property (strong,nonatomic)UILabel *yuejingLabel1;
@property (strong,nonatomic)UILabel *yuejingLabel2_1;
@property (strong,nonatomic)UILabel *yuejingLabel2_2;
@property (strong,nonatomic)UILabel *yuejingLabel2_3;
@property (strong,nonatomic)UILabel *yuejingLabel2_4;
@property (strong,nonatomic)UILabel *yuejingLabel2_5;
@property (strong,nonatomic)UILabel *yuejingLabel2_6;
@property (strong,nonatomic)UILabel *yuejingLabel2_7;
@property (strong,nonatomic)UILabel *yuejingLabel2_8;
@property (strong,nonatomic)UIView *yuejingLineView;

@property (strong,nonatomic)UILabel *hanreLabel1;
@property (strong,nonatomic)UILabel *hanreLabel2;
@property (strong,nonatomic)UIView *hanreLineView;
@property (strong,nonatomic)UILabel *tiwenLabel1;
@property (strong,nonatomic)UILabel *tiwenLabel2;
@property (strong,nonatomic)UIView *tiwenLineView;
@property (strong,nonatomic)UILabel *chuhanLabel1;
@property (strong,nonatomic)UILabel *chuhanLabel2;
@property (strong,nonatomic)UIView *chuhanLineView;
@property (strong,nonatomic)UILabel *zhaopianLabel1;
@property (strong,nonatomic)UILabel *zhaopianLabel2;

@property (strong,nonatomic)NSMutableArray *photoArray;
-(void)initViewWithPhotoArray:(NSMutableArray *)photoArray originHeight:(CGFloat)originHeight photoString:(NSString *)photoString;

@end
