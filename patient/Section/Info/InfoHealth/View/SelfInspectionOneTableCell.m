//
//  SelfInspectionOneTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SelfInspectionOneTableCell.h"

@implementation SelfInspectionOneTableCell

-(void)initViewWithTextField{
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = @"请输入患者主诉";
    self.textField.layer.borderWidth = 1;
    self.textField.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    [self.contentView addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
}



@end
