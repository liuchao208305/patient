//
//  QuestionViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface QuestionViewController : BaseViewController

@property (strong,nonatomic)UIView *questionView;
@property (strong,nonatomic)UILabel *questionLabel;
@property (strong,nonatomic)UIImageView *questionImage;

@property (assign,nonatomic)BOOL flag1;
@property (assign,nonatomic)BOOL flag2;

@property (strong,nonatomic)UITableView *tableView1;
@property (strong,nonatomic)UITableView *tableView2;

@end
