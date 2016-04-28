//
//  ContactCheckViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "ContactData.h"

@protocol ContactDelegate <NSObject>

-(void)contactSelected:(ContactData *)contactData;

@end

@interface ContactCheckViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (assign,nonatomic)BOOL isFromMineVC;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *contactArray;
@property (strong,nonatomic)NSMutableArray *contactPatientIdArray;
@property (strong,nonatomic)NSMutableArray *contactIdArray;
@property (strong,nonatomic)NSMutableArray *contactNameArray;
@property (strong,nonatomic)NSMutableArray *contactSexArray;
@property (strong,nonatomic)NSMutableArray *contactAgeArray;
@property (strong,nonatomic)NSMutableArray *contactRecordStatusArray;
@property (strong,nonatomic)NSMutableArray *contactIdNumberArray;
@property (strong,nonatomic)NSMutableArray *contactPhoneArray;

@property (weak,nonatomic)id<ContactDelegate> contactDelegate;

@end
