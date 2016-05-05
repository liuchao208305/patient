//
//  MedicineReceivingViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MedicineReceivingViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic)NSString *orderNumber;

@property (strong,nonatomic)UILabel *navTitleLabel;

@property (strong,nonatomic)UITableView *tableView;

@end
