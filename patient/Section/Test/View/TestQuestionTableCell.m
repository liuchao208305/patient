//
//  TestQuestionTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/20.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TestQuestionTableCell.h"

@interface TestQuestionTableCell () {
    
    UIButton *selectedBtn;
}

@end

@implementation TestQuestionTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


#pragma mark Init Section

- (void)initViewWith:(CellBtnStatu)btnStatu {
    
    self.topBackView = [[UIView alloc] init];
    self.topBackView.backgroundColor = kWHITE_COLOR;
    [self initTopView];
    [self.contentView addSubview:self.topBackView];
    
    self.separateLineView = [[UIView alloc] init];
    self.separateLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.separateLineView];
    
    self.bottomBackView = [[UIView alloc] init];
    self.bottomBackView.backgroundColor = kWHITE_COLOR;
    [self initBottomViewWith:(CellBtnStatu)btnStatu];
    [self.contentView addSubview:self.bottomBackView];
    
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.separateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBackView).offset(44);
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10);
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(80);
    }];
    
}

- (void)initTopView {
    
    self.quesionLabel = [[UILabel alloc] init];
    self.quesionLabel.font = [UIFont systemFontOfSize:12];
    [self.topBackView addSubview:self.quesionLabel];
    [self.quesionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBackView).offset(10);
        make.bottom.equalTo(self.topBackView).offset(-10);
        make.leading.equalTo(self.topBackView).offset(15);
        make.trailing.equalTo(self.topBackView).offset(-15);
    }];
    
}

- (void)initBottomViewWith:(CellBtnStatu)btnStatu {
    
    self.noneButton = [[UIButton alloc] init];
    self.fewButton = [[UIButton alloc] init];
    self.occasionButton = [[UIButton alloc] init];
    self.oftenButton = [[UIButton alloc] init];
    self.alwaysButton = [[UIButton alloc] init];
    
    self.noneButton.tag = 1;
    self.fewButton.tag = 2;
    self.occasionButton.tag = 3;
    self.oftenButton.tag = 4;
    self.alwaysButton.tag = 5;
    
    [self.fewButton setBackgroundColor:[UIColor colorWithRed:202/255.0 green:245/255.0 blue:196/255.0 alpha:1]];
    [self.noneButton setBackgroundColor:[UIColor colorWithRed:202/255.0 green:245/255.0 blue:196/255.0 alpha:1]];
    [self.occasionButton setBackgroundColor:[UIColor colorWithRed:202/255.0 green:245/255.0 blue:196/255.0 alpha:1]];
    [self.oftenButton setBackgroundColor:[UIColor colorWithRed:202/255.0 green:245/255.0 blue:196/255.0 alpha:1]];
    [self.alwaysButton setBackgroundColor:[UIColor colorWithRed:202/255.0 green:245/255.0 blue:196/255.0 alpha:1]];
    
    self.noneButton.layer.cornerRadius = 25;
    [self.noneButton setTitle:@"没有" forState:UIControlStateNormal];
    [self.noneButton setTitleColor:[UIColor colorWithRed:88/255.0 green:197/255.0 blue:71/255.0 alpha:1] forState:UIControlStateNormal];
    [self.noneButton setTitleColor:kWHITE_COLOR forState:UIControlStateSelected];
    [self.bottomBackView addSubview:self.noneButton];
    [self.noneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomBackView).offset((SCREEN_WIDTH-250)/6);
        make.centerY.equalTo(self.bottomBackView).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.fewButton.layer.cornerRadius = 25;
    [self.fewButton setTitleColor:kWHITE_COLOR forState:UIControlStateSelected];
    [self.fewButton setTitle:@"很少" forState:UIControlStateNormal];
    [self.fewButton setTitleColor:[UIColor colorWithRed:88/255.0 green:197/255.0 blue:71/255.0 alpha:1] forState:UIControlStateNormal];
    [self.bottomBackView addSubview:self.fewButton];
    [self.fewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.noneButton).offset((SCREEN_WIDTH-250)/6+50);
        make.centerY.equalTo(self.bottomBackView).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.occasionButton.layer.cornerRadius = 25;
    [self.occasionButton setTitleColor:kWHITE_COLOR forState:UIControlStateSelected];
    [self.occasionButton setTitle:@"有时" forState:UIControlStateNormal];
    [self.occasionButton setTitleColor:[UIColor colorWithRed:88/255.0 green:197/255.0 blue:71/255.0 alpha:1] forState:UIControlStateNormal];
    [self.bottomBackView addSubview:self.occasionButton];
    [self.occasionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.fewButton).offset((SCREEN_WIDTH-250)/6+50);
        make.centerY.equalTo(self.bottomBackView).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.oftenButton.layer.cornerRadius = 25;
    [self.oftenButton setTitleColor:kWHITE_COLOR forState:UIControlStateSelected];
    [self.oftenButton setTitle:@"经常" forState:UIControlStateNormal];
    [self.oftenButton setTitleColor:[UIColor colorWithRed:88/255.0 green:197/255.0 blue:71/255.0 alpha:1] forState:UIControlStateNormal];
    [self.bottomBackView addSubview:self.oftenButton];
    [self.oftenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.occasionButton).offset((SCREEN_WIDTH-250)/6+50);
        make.centerY.equalTo(self.bottomBackView).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.alwaysButton.layer.cornerRadius = 25;
    [self.alwaysButton setTitleColor:kWHITE_COLOR forState:UIControlStateSelected];
    [self.alwaysButton setTitle:@"总是" forState:UIControlStateNormal];
    [self.alwaysButton setTitleColor:[UIColor colorWithRed:88/255.0 green:197/255.0 blue:71/255.0 alpha:1] forState:UIControlStateNormal];
    [self.bottomBackView addSubview:self.alwaysButton];
    [self.alwaysButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bottomBackView).offset(-(SCREEN_WIDTH-250)/6);
        make.centerY.equalTo(self.bottomBackView).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.noneButton addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.fewButton addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.occasionButton addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.oftenButton addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.alwaysButton addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (btnStatu != CellBtnStatuUnkown) {
        selectedBtn = [self.bottomBackView viewWithTag:btnStatu];
        selectedBtn.selected = YES;
        selectedBtn.backgroundColor = kMAIN_COLOR;
    }
    
}

- (void)cellBtnClick:(UIButton *)sender {
    
    if (![selectedBtn isKindOfClass:[UIButton class]]) {
        selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (selectedBtn != sender) {
        selectedBtn.backgroundColor = [UIColor colorWithRed:202/255.0 green:245/255.0 blue:196/255.0 alpha:1];
        selectedBtn.selected = NO;
        sender.selected = YES;
        selectedBtn = sender;
        selectedBtn.backgroundColor = kMAIN_COLOR;
    }
    
    [self.delegate cellBtnClick:sender cellTag:_cellTag item_name:_quesionLabel.text];
    
}

@end