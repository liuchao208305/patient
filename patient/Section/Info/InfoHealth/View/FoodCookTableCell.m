//
//  FoodCookTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "FoodCookTableCell.h"

@interface FoodCookTableCell ()

@property (strong,nonatomic)UIScrollView *scrollView;

@end

@implementation FoodCookTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark Init Section
-(void)initView:(NSInteger)number Withid:(NSMutableArray *)dishIdArray image:(NSMutableArray *)dishImageArray name:(NSMutableArray *)dishNameArray quantity:(NSMutableArray *)dishQuantityArray{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    
    self.scrollView.contentSize = CGSizeMake(2*SCREEN_WIDTH, 0);
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.contentView addSubview:self.scrollView];
    
    [self initSubView:number Withid:dishIdArray image:dishImageArray name:dishNameArray quantity:dishQuantityArray];
}

-(void)initSubView:(NSInteger)number Withid:(NSMutableArray *)dishIdArray image:(NSMutableArray *)dishImageArray name:(NSMutableArray *)dishNameArray quantity:(NSMutableArray *)dishQuantiyArray{
    for (int i = 0; i<number; i++) {
        self.foodCookView = [[FoodCookView alloc] init];
        self.foodCookView.tag = i;
        self.foodCookView.frame = CGRectMake((i+1)*(SCREEN_WIDTH-66*4)/5+i*66, 0, 66, 110);
        
        self.foodCookView.dishId = dishIdArray[i];
        [self.foodCookView.dishImageView sd_setImageWithURL:[NSURL URLWithString:dishImageArray[i]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        self.foodCookView.dishNameLabel.text = dishNameArray[i];
        self.foodCookView.dishQuantity = dishQuantiyArray[i];
        
        [self.scrollView addSubview:self.foodCookView];
        
        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(foodCookViewClicked:)];
        [self.foodCookView addGestureRecognizer:recognizer];
    }
    
    self.scrollView.contentSize = CGSizeMake(number*((SCREEN_WIDTH-46*4)/5+46)+21, 0);
}

#pragma mark Target Action
-(void)foodCookViewClicked:(UIGestureRecognizer *)sender{
    DLog(@"%ld",sender.view.tag);
    
    if (self.foodDishViewDelegate && [self.foodDishViewDelegate respondsToSelector:@selector(foodDishViewClicked:)]) {
        [self.foodDishViewDelegate foodDishViewClicked:sender.view.tag];
    }
}

@end
