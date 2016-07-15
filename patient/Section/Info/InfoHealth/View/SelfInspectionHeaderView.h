//
//  SelfInspectionHeaderViewOne.h
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DaBianCountDelegate <NSObject>

-(void)sendDabianCount:(NSString *)string;

@end

@protocol XiaoBianCountDelegate <NSObject>

-(void)sendXiaobianBaitianCount:(NSString *)string;
-(void)sendXiaobianWanshangCount:(NSString *)string;

@end

@protocol Yuejingmoci1Delegate <NSObject>

-(void)sendYuejingmoci1:(NSString *)string;

@end

@protocol Yuejingmoci2Delegate <NSObject>

-(void)sendYuejingmoci2:(NSString *)string;

@end

@protocol ChuchaonianlingDelegate <NSObject>

-(void)sendChuchaonianling:(NSString *)string;

@end

@protocol YuejingzhouqiDelegate <NSObject>

-(void)sendYuejingzhouqi:(NSString *)string;

@end

@protocol ChixutianshuDelegate <NSObject>

-(void)sendChixutianshu:(NSString *)string;

@end

@protocol TiwenDelegate <NSObject>

-(void)tiwenButtonClicked;

@end

@interface SelfInspectionHeaderView : UIView

@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UILabel *titleLabelFix;
//@property (strong,nonatomic)UITextField *contentTextField;
@property (strong,nonatomic)UIButton *contentButton;
@property (strong,nonatomic)UILabel *contentLabel;
@property (strong,nonatomic)UISegmentedControl *segmentedControl;
@property (strong,nonatomic)UILabel *contentLabel1_1;
@property (strong,nonatomic)UITextField *contentTextField1;
@property (strong,nonatomic)UILabel *contentLabel1_2;
@property (strong,nonatomic)UILabel *contentLabel2_1;
@property (strong,nonatomic)UITextField *contentTextField2;
@property (strong,nonatomic)UILabel *contentLabel2_2;
@property (strong,nonatomic)UIView *lineView;

-(void)initView:(NSString *)title;
-(void)initView:(NSString *)title titleFix:(NSString *)titleFix;
-(void)initView:(NSString *)title content:(NSString *)content array:(NSArray *)segmentedArray hideFlag:(BOOL)hideFlag;
-(void)initView:(NSString *)title array:(NSArray *)segmentedArray leftHideFlag:(BOOL)leftHideFlag;
-(void)initView:(NSString *)title array:(NSArray *)segmentedArray righHideFlag:(BOOL)righHideFlag;
-(void)initView:(NSString *)title content1_1:(NSString *)content1_1 content1_2:(NSString *)content1_2 content1_3:(NSString *)content1_3 content2_1:(NSString *)content2_1 content2_2:(NSString *)content2_2 content2_3:(NSString *)content2_3;

@property (weak,nonatomic)id<DaBianCountDelegate> daBianCountDelegate;
@property (weak,nonatomic)id<XiaoBianCountDelegate> xiaoBianCountDelegate;
@property (weak,nonatomic)id<Yuejingmoci1Delegate> yuejingmoci1Delegate;
@property (weak,nonatomic)id<Yuejingmoci2Delegate> yuejingmoci2Delegate;
@property (weak,nonatomic)id<ChuchaonianlingDelegate> chuchaonianlingDelegate;
@property (weak,nonatomic)id<YuejingzhouqiDelegate> yuejingzhouqiDelegate;
@property (weak,nonatomic)id<ChixutianshuDelegate> chixutianshuDelegate;
@property (weak,nonatomic)id<TiwenDelegate> tiwenDelegate;

@end
