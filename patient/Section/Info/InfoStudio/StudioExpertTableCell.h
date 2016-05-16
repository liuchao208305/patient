//
//  StudioExpertTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/5/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExpertDelegate <NSObject>

-(void)expert1Clicked;
-(void)expert2Clicked;
-(void)expert3Clicked;
-(void)expert4Clicked;
-(void)expert5Clicked;
-(void)expert6Clicked;
-(void)expert7Clicked;
-(void)expert8Clicked;

@end

@interface StudioExpertTableCell : UITableViewCell

@property (strong,nonatomic)UICollectionView *collectionView;

@property (weak,nonatomic)id<ExpertDelegate> expertDelegate;

@end
