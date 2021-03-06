//
//  RecordDetailViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/26.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface RecordDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic)NSString *orderNumber;

@property (strong,nonatomic)UILabel *navTitleLabel;

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

@end
