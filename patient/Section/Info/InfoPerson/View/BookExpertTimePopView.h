//
//  BookExpertTimePopView.h
//  patient
//
//  Created by ChaosLiu on 16/7/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClinicTimeDelegate <NSObject>

-(void)clinicTimeSelected:(NSString *)unformatTime formatTime:(NSString *)formatTime;

@end

@protocol ClinicTimeFixDelegate <NSObject>

-(void)removeClinicTimePopView;

@end

@interface BookExpertTimePopView : UIView

@property (strong,nonatomic)UIView *topFixView;
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *bottomFixView;

@property (strong,nonatomic)NSMutableArray *timeUnformatArray;
@property (strong,nonatomic)NSMutableArray *timeFormatArray;
@property (strong,nonatomic)NSMutableArray *timePeriodArray;
@property (strong,nonatomic)NSMutableArray *timeFullFlagArray;

-(void)initViewWithTimeUnformatArray:(NSMutableArray *)timeUnformatArray timeFormatArray:(NSMutableArray *)timeFormatArray timePeriodArray:(NSMutableArray *)timePeriodArray timeFullFlagArray:(NSMutableArray *)timeFullFlagArray;

@property (weak,nonatomic)id<ClinicTimeDelegate> clinicTimeDelegate;
@property (weak,nonatomic)id<ClinicTimeFixDelegate> clinicTimeFixDelegate;

@end
