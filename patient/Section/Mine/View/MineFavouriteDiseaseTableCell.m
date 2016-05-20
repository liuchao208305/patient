//
//  MineFavouriteDiseaseTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/19.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineFavouriteDiseaseTableCell.h"

@implementation MineFavouriteDiseaseTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initView:0];
    }
    return self;
}

#pragma mark Init Section
-(void)initView:(NSInteger)number detail:(NSMutableArray *)detailArray symptom:(NSMutableArray *)symtomArray cause:(NSMutableArray *)causeArray{
    self.detailArray = [detailArray copy];
    self.symtomArray = [symtomArray copy];
    self.causeArray = [causeArray copy];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [self.contentView addSubview:self.titleView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView).offset(0);
        make.leading.equalTo(self.titleView).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(15);
    }];
    
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:@"简介", @"症状", @"病因",nil];
    self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 45, SCREEN_WIDTH, 42) titleDataSource:segmentedArray backgroundColor:kBACKGROUND_COLOR titleColor:kLIGHT_GRAY_COLOR titleFont:[UIFont systemFontOfSize:14] selectColor:kMAIN_COLOR buttonDownColor:kMAIN_COLOR Delegate:self selectSeugment:number];
    
    [self.contentView addSubview:self.segmentControl];
    
    self.bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, 45+42, SCREEN_WIDTH, 200-45-42)];
    [self.contentView addSubview:self.bodyView];
    
    self.bodyLabel = [[UILabel alloc] init];
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.text = detailArray[0];
    [self.bodyView addSubview:self.bodyLabel];
    
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodyView).offset(12);
        make.bottom.equalTo(self.bodyView).offset(-12);
        make.leading.equalTo(self.bodyView).offset(12);
        make.trailing.equalTo(self.bodyView).offset(-12);
    }];
}

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    DLog(@"selection-->%ld",(long)selection);
    if (selection == 0) {
//        if (self.favouriteDiseaseDelegate && [self.favouriteDiseaseDelegate respondsToSelector:@selector(diseaseDetailClicked)]) {
//            [self.favouriteDiseaseDelegate diseaseDetailClicked];
//        }
        self.bodyLabel.text = self.detailArray[0];
    }else if (selection == 1){
//        if (self.favouriteDiseaseDelegate && [self.favouriteDiseaseDelegate respondsToSelector:@selector(diseaseSymptomClicked)]) {
//            [self.favouriteDiseaseDelegate diseaseSymptomClicked];
//        }
        self.bodyLabel.text = self.symtomArray[0];
    }else if (selection == 2){
//        if (self.favouriteDiseaseDelegate && [self.favouriteDiseaseDelegate respondsToSelector:@selector(diseaseCauseClicked)]) {
//            [self.favouriteDiseaseDelegate diseaseCauseClicked];
//        }
        self.bodyLabel.text = self.causeArray[0];
    }
}

@end
