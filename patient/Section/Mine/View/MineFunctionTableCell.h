//
//  MineFunctionTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FunctionDelegate <NSObject>

-(void)function1Clicked;
-(void)function2Clicked;
-(void)function3Clicked;
-(void)function4Clicked;
-(void)function5Clicked;
-(void)function6Clicked;
//-(void)function7Clicked;
//-(void)function8Clicked;

@end

@interface MineFunctionTableCell : UITableViewCell

@property (strong,nonatomic)UICollectionView *collectionView;

@property (weak,nonatomic)id<FunctionDelegate> functionDelegate;

@end
