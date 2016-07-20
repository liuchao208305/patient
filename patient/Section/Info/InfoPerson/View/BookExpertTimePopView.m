//
//  BookExpertTimePopView.m
//  patient
//
//  Created by ChaosLiu on 16/7/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BookExpertTimePopView.h"
#import "BookExpertTimeTableCell.h"

@interface BookExpertTimePopView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BookExpertTimePopView

-(void)initViewWithTimeUnformatArray:(NSMutableArray *)timeUnformatArray timeFormatArray:(NSMutableArray *)timeFormatArray timePeriodArray:(NSMutableArray *)timePeriodArray timeFullFlagArray:(NSMutableArray *)timeFullFlagArray{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.topFixView = [[UIView alloc] init];
    [self addSubview:self.topFixView];
    
    self.bottomFixView = [[UIView alloc] init];
    [self addSubview:self.bottomFixView];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = kWHITE_COLOR;
    self.tableView.layer.cornerRadius = 5;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    [self.topFixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.top.equalTo(self).offset(80);
        make.height.mas_equalTo(120);
    }];
    
    [self.bottomFixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.top.equalTo(self.tableView.mas_bottom).offset(0);
        make.bottom.equalTo(self).offset(0);
    }];
    
    self.timeUnformatArray = timeUnformatArray;
    self.timeFormatArray = timeFormatArray;
    self.timePeriodArray = timePeriodArray;
    self.timeFullFlagArray = timeFullFlagArray;
    
    self.topFixView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadowViewClicked)];
    [self.topFixView addGestureRecognizer:tap1];
    
    self.bottomFixView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadowViewClicked)];
    [self.bottomFixView addGestureRecognizer:tap2];
}

#pragma mark Target Action
-(void)shadowViewClicked{
    DLog(@"shadowViewClicked");
    if (self.clinicTimeFixDelegate && [self.clinicTimeFixDelegate respondsToSelector:@selector(removeClinicTimePopView)]) {
        [self.clinicTimeFixDelegate removeClinicTimePopView];
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.timeUnformatArray.count==0 ? 0 : self.timeUnformatArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"BookExpertTimeTableCell";
    BookExpertTimeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[BookExpertTimeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.timeLabel1.text = self.timeFormatArray[indexPath.row];
    if ([self.timeFullFlagArray[indexPath.row] intValue] == 1) {
        cell.timeLabel2.hidden = NO;
        cell.timeLabel2.text = @"（已满）";
    }else{
        cell.timeLabel2.hidden = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.clinicTimeDelegate && [self.clinicTimeDelegate respondsToSelector:@selector(clinicTimeSelected:formatTime:)]) {
        [self.clinicTimeDelegate clinicTimeSelected:self.timeUnformatArray[indexPath.row] formatTime:self.timeFormatArray[indexPath.row]];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
