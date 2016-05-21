//
//  MineFavouriteDiseaseTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/5/19.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJSegmentedControl.h"

@protocol FavouriteDiseaseDelegate <NSObject>

-(void)diseaseDetailClicked;
-(void)diseaseSymptomClicked;
-(void)diseaseCauseClicked;

@end

@interface MineFavouriteDiseaseTableCell : UITableViewCell<YJSegmentedControlDelegate>

-(void)initView:(NSInteger)number index:(NSIndexPath *)index detail:(NSMutableArray *)detailArray symptom:(NSMutableArray *)symtomArray cause:(NSMutableArray *)causeArray;

@property (strong,nonatomic)UIView *titleView;
@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)YJSegmentedControl *segmentControl;
@property (strong,nonatomic)UIView *bodyView;
@property (strong,nonatomic)UILabel *bodyLabel;

@property (strong,nonatomic)NSIndexPath *index;
@property (strong,nonatomic)NSArray *detailArray;
@property (strong,nonatomic)NSArray *symtomArray;
@property (strong,nonatomic)NSArray *causeArray;

@property (weak,nonatomic)id<FavouriteDiseaseDelegate> favouriteDiseaseDelegate;

@end
