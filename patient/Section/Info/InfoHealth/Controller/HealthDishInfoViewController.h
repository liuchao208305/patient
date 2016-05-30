//
//  HealthInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/17.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface HealthDishInfoViewController : BaseViewController

@property (assign,nonatomic)NSInteger healthType;
@property (strong,nonatomic)NSString *healthId;
@property (strong,nonatomic)NSString *healthName;

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

@property (assign,nonatomic)BOOL isCommented;
@property (assign,nonatomic)BOOL isFavourited;
@property (strong,nonatomic)UIButton *commentButton;
@property (strong,nonatomic)UIButton *favouriteButton;

@property (strong,nonatomic)UIView *bottomLineView;
@property (strong,nonatomic)UIImageView *commentBackView;
@property (strong,nonatomic)UIImageView *commentImageView;
@property (strong,nonatomic)UILabel *commentLabel;
@property (strong,nonatomic)UIImageView *favouriteBackView;
@property (strong,nonatomic)UIImageView *favouriteImageView;
@property (strong,nonatomic)UILabel *favouriteLabel;

@property (strong,nonatomic)UICollectionView *collectionView;

@end
