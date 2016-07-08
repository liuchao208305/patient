//
//  TestViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface TestViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

/**
 *  布局
 */
@property (strong,nonatomic)UIView *topFixedView;
@property (strong,nonatomic)UILabel *answerLabel1;
@property (strong,nonatomic)UILabel *answerLabel2;
@property (strong,nonatomic)UILabel *numberLabel;

@property (strong,nonatomic)UITableView *tableView;

/**
 *  网络请求数据源
 */
@property (strong,nonatomic)NSMutableArray *questionArray;
@property (strong,nonatomic)NSMutableArray *questionGroupIdArray;
@property (strong,nonatomic)NSMutableArray *questionItemIdArray;
@property (strong,nonatomic)NSMutableArray *questionItemNameArray;
@property (strong,nonatomic)NSMutableArray *questionItemStarArray;
@property (strong,nonatomic)NSMutableArray *questionItemRepeatArray;

@property (strong,nonatomic)NSMutableArray *commiteArray;

@property (strong,nonatomic)UIButton *confirmButton;
@property (strong,nonatomic)NSString *contactId;

/**
 *  保存Cell状态按钮
 */
@property (strong,nonatomic)NSMutableArray *cellBtnStatuArr;

/**
 *  本地Cell点击状态缓存
 */
@property (strong,nonatomic)NSMutableArray *cellBtnStatuArrLocal;

/**
 *  cell上按钮状态
 *
 *  @param cellBtnStatuArr 按钮状态数组
 *
 *  @return id
 */
- (instancetype)initWithCellBtnStatuArr:(NSMutableArray *)cellBtnStatuArr;

@end
