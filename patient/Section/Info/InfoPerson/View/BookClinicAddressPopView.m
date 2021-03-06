//
//  BookClinicAddressPopView.m
//  patient
//
//  Created by ChaosLiu on 16/7/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BookClinicAddressPopView.h"
#import "BookClinicAddressTableCell.h"

@interface BookClinicAddressPopView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BookClinicAddressPopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initViewWithIdArray:(NSMutableArray *)addressIdArray addressUnitArray:(NSMutableArray *)addressUnitArray{
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
        make.height.mas_equalTo(135);
    }];
    
    [self.bottomFixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.top.equalTo(self.tableView.mas_bottom).offset(0);
        make.bottom.equalTo(self).offset(0);
    }];
    
    self.addressIdArray = addressIdArray;
    self.addressUnitArray = addressUnitArray;
    
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
    if (self.clinicAddressFixDelegate && [self.clinicAddressFixDelegate respondsToSelector:@selector(removeClinicAddressPopView)]) {
        [self.clinicAddressFixDelegate removeClinicAddressPopView];
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressIdArray.count==0 ? 0 : self.addressIdArray.count;
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
    
    cell.addressLabel.text = self.addressUnitArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.clinicAddressDelegate && [self.clinicAddressDelegate respondsToSelector:@selector(clinicAddressSelected:addressUnit:)]) {
        [self.clinicAddressDelegate clinicAddressSelected:self.addressIdArray[indexPath.row] addressUnit:self.addressUnitArray[indexPath.row]];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
