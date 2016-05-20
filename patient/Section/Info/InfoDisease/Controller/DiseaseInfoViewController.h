//
//  DiseaseInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface DiseaseInfoViewController : BaseViewController

@property (strong,nonatomic)NSString *diseaseId;
@property (strong,nonatomic)NSString *diseaseName;

@property (strong,nonatomic)UITableView *tableView;

@property (assign,nonatomic)BOOL isCommented;
@property (assign,nonatomic)BOOL isFavourited;
@property (strong,nonatomic)UIButton *commentButton;
@property (strong,nonatomic)UIButton *favouriteButton;

@end