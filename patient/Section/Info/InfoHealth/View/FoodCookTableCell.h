//
//  FoodCookTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodCookView.h"

@protocol FoodDishViewDelegate <NSObject>

-(void)foodDishViewClicked:(NSInteger)tag;

@end

@interface FoodCookTableCell : UITableViewCell

@property (strong,nonatomic)FoodCookView *foodCookView;

-(void)initView:(NSInteger)number Withid:(NSMutableArray *)dishIdArray image:(NSMutableArray *)dishImageArray name:(NSMutableArray *)dishNameArray quantity:(NSMutableArray *)dishQuantityArray;

@property (weak,nonatomic)id<FoodDishViewDelegate> foodDishViewDelegate;

@end
