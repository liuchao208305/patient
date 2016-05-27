//
//  TestChooseContactViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface TestChooseContactViewController : BaseViewController

@property (strong,nonatomic)UICollectionView *collectionView;

@property (strong,nonatomic)NSMutableArray *contactArray;
@property (strong,nonatomic)NSMutableArray *contactIdArray;
@property (strong,nonatomic)NSMutableArray *contactNameArray;

@end
