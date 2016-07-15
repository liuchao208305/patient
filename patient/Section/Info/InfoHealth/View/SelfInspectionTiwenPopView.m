//
//  SelfInspectionTiwenPopView.m
//  patient
//
//  Created by ChaosLiu on 16/7/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SelfInspectionTiwenPopView.h"
#import "BookClinicAddressTableCell.h"

@interface SelfInspectionTiwenPopView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SelfInspectionTiwenPopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initViewWithArray:(NSMutableArray *)tiwenArray{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = kWHITE_COLOR;
    self.tableView.layer.cornerRadius = 5;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(45);
        make.trailing.equalTo(self).offset(-45);
        make.top.equalTo(self).offset(80);
        make.height.mas_equalTo(225);
    }];
    
    self.tiwenArray = tiwenArray;
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tiwenArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"BookClinicAddressTableCell";
    BookClinicAddressTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[BookClinicAddressTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.addressLabel.text = self.tiwenArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tiwenListDelegate && [self.tiwenListDelegate respondsToSelector:@selector(tiwenSelected:)]) {
        [self.tiwenListDelegate tiwenSelected:self.tiwenArray[indexPath.row]];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
