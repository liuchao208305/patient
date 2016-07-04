//
//  TestResultListViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/23.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@protocol TestListDelegate <NSObject>

-(void)testListChoosed:(NSString *)time type:(NSString *)type;

@end

@interface TestResultListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSString *sourceVC;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSString *patientId;
@property (strong,nonatomic)NSString *patientImageString;

@property (strong,nonatomic)NSMutableArray *resultArray;
@property (strong,nonatomic)NSMutableArray *resultPatientIdArray;
@property (strong,nonatomic)NSMutableArray *resultPatientImageArray;
@property (strong,nonatomic)NSMutableArray *resultIdArray;
@property (strong,nonatomic)NSMutableArray *resultMainArray;
@property (strong,nonatomic)NSMutableArray *resultTrendArray;
@property (strong,nonatomic)NSMutableArray *resultTimeArray;

@property (weak,nonatomic)id<TestListDelegate> testListDelegate;

@end
