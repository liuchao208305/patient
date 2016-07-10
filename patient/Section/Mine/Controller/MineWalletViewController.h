//
//  MineWalletViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/8.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "MineWalletHeaderView.h"

@interface MineWalletViewController : BaseViewController

@property (strong,nonatomic)MineWalletHeaderView *mineWalletHeaderView;

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UILabel *accountLabel;
@property (strong,nonatomic)UILabel *moneyLabel1;
@property (strong,nonatomic)UILabel *moneyLabel2;
@property (strong,nonatomic)UILabel *moneyLabel3;

@property (strong,nonatomic)NSMutableArray *tradeArray;
@property (strong,nonatomic)NSMutableArray *tradeIdArray;
@property (strong,nonatomic)NSMutableArray *tradeTypeArray;
@property (strong,nonatomic)NSMutableArray *tradeMoneyArray;
@property (strong,nonatomic)NSMutableArray *tradeTimeArray;

@end
