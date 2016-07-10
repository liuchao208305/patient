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
        make.height.mas_equalTo(200);
    }];
    
    self.timeUnformatArray = timeUnformatArray;
    self.timeFormatArray = timeFormatArray;
    self.timePeriodArray = timePeriodArray;
    self.timeFullFlagArray = timeFullFlagArray;
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
