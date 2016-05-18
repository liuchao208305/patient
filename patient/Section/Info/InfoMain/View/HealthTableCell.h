//
//  HealthTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/3/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

@protocol HealthViewDelegate <NSObject>

-(void)healthViewClicked:(NSInteger)index;

@end

@interface HealthTableCell : UITableViewCell<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *healthImageView;
/*==================================================================*/
@property (strong,nonatomic)SDCycleScrollView *scrollView;

-(void)initViewWithArray:(NSMutableArray *)Array;

@property (weak,nonatomic)id<HealthViewDelegate> healthViewDelegate;

@end
