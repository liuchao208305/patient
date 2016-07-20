//
//  HealthDiseaseHistoryViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "SelfInspectionHeaderView.h"

@protocol DiseaseListDelegate1 <NSObject>

-(void)diseaseListChoosed1;

@end

@protocol DiseaseListDelegate2 <NSObject>

-(void)diseaseListChoosed2;

@end

@interface HealthDiseaseHistoryViewController : BaseViewController

@property (assign,nonatomic)BOOL isEditable;

@property (strong,nonatomic)NSString *diseaseHistoryId;

@property (assign,nonatomic)int marryStatus;
@property (assign,nonatomic)int erziCount;
@property (assign,nonatomic)int nverCount;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)SelfInspectionHeaderView *selfInspectionHeaderView;

@property (weak,nonatomic)id<DiseaseListDelegate1> diseaseListDelegate1;

@property (weak,nonatomic)id<DiseaseListDelegate2> diseaseListDelegate2;

@end
