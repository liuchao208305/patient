//
//  TestChooseContactViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "ContactData.h"

@protocol ChooseContactDelegate <NSObject>

-(void)chooseContactSelected:(ContactData *)contactData;

@end

@interface TestChooseContactViewController : BaseViewController

@property (strong,nonatomic)UICollectionView *collectionView;

@property (strong,nonatomic)NSMutableArray *contactArray;
@property (strong,nonatomic)NSMutableArray *contactIdArray;
@property (strong,nonatomic)NSMutableArray *contactNameArray;

@property (weak,nonatomic)id<ChooseContactDelegate> chooseContactDelegate;

@end
