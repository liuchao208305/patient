//
//  MineQuestionListViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "YJSegmentedControl.h"

@interface MineQuestionListViewController : BaseViewController<YJSegmentedControlDelegate,UITableViewDelegate,UITableViewDataSource>

@property (assign,nonatomic)NSInteger questionType;

@property (assign,nonatomic)BOOL flag1;
@property (assign,nonatomic)BOOL flag2;
@property (assign,nonatomic)BOOL flag3;
@property (assign,nonatomic)BOOL flag4;
@property (assign,nonatomic)BOOL flag5;

@property (strong,nonatomic)YJSegmentedControl *segmentControl;
@property (strong,nonatomic)UITableView *tableView1;
@property (strong,nonatomic)UITableView *tableView2;
@property (strong,nonatomic)UITableView *tableView3;
@property (strong,nonatomic)UITableView *tableView4;
@property (strong,nonatomic)UITableView *tableView5;

@property (strong,nonatomic)NSMutableArray *questionArrayAll;
@property (strong,nonatomic)NSMutableArray *questionIdArrayAll;
@property (strong,nonatomic)NSMutableArray *questionPayStatusArrayAll;
@property (strong,nonatomic)NSMutableArray *questionAnswerStatusArrayAll;
@property (strong,nonatomic)NSMutableArray *questionPublicStatusArrayAll;
@property (strong,nonatomic)NSMutableArray *questionContentArrayAll;
@property (strong,nonatomic)NSMutableArray *questionAskTimeArrayAll;
@property (strong,nonatomic)NSMutableArray *questionAnswerTimeArrayAll;
@property (strong,nonatomic)NSMutableArray *questionPayTimeArrayAll;
@property (strong,nonatomic)NSMutableArray *questionMoneyArrayAll;
@property (strong,nonatomic)NSMutableArray *questionExpertIdArrayAll;
@property (strong,nonatomic)NSMutableArray *questionExpertNameArrayAll;
@property (strong,nonatomic)NSMutableArray *questionAudienceArrayAll;

@property (strong,nonatomic)NSMutableArray *questionArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionIdArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionPayStatusArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionAnswerStatusArrayUnPayed;
@property (strong,nonatomic)NSMutableArray *questionPublicStatusArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionContentArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionAskTimeArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionAnswerTimeArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionPayTimeArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionMoneyArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionExpertIdArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionExpertNameArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *questionAudienceArrayUnpayed;

@property (strong,nonatomic)NSMutableArray *questionArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionIdArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionPayStatusArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionAnswerStatusArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionPublicStatusArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionContentArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionAskTimeArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionAnswerTimeArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionPayTimeArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionMoneyArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionExpertIdArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionExpertNameArrayUnanswered;
@property (strong,nonatomic)NSMutableArray *questionAudienceArrayUnanswered;

@property (strong,nonatomic)NSMutableArray *questionArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionIdArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionPayStatusArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionAnswerStatusArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionPublicStatusArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionContentArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionAskTimeArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionAnswerTimeArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionPayTimeArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionMoneyArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionExpertIdArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionExpertNameArrayAnswered;
@property (strong,nonatomic)NSMutableArray *questionAudienceArrayAnswered;

@property (strong,nonatomic)NSMutableArray *questionArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionIdArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionPayStatusArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionAnswerStatusArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionPublicStatusArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionContentArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionAskTimeArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionAnswerTimeArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionPayTimeArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionMoneyArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionExpertIdArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionExpertNameArrayPublic;
@property (strong,nonatomic)NSMutableArray *questionAudienceArrayPublic;

@end
