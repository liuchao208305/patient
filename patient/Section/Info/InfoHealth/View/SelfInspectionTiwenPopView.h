//
//  SelfInspectionTiwenPopView.h
//  patient
//
//  Created by ChaosLiu on 16/7/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TiwenListDelegate <NSObject>

-(void)tiwenSelected:(NSString *)tiwen;

@end

@interface SelfInspectionTiwenPopView : UIView

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *tiwenArray;

-(void)initViewWithArray:(NSMutableArray *)tiwenArray;

@property (weak,nonatomic)id<TiwenListDelegate> tiwenListDelegate;

@end
