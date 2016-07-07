//
//  SelfInspectionOneTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SelfInspectionOneTableCell.h"

@interface SelfInspectionOneTableCell ()<UITextFieldDelegate>

@end

@implementation SelfInspectionOneTableCell

-(void)initViewWithTextField:(NSString *)placeholder text:(NSString *)text{
    self.textField = [[UITextField alloc] init];
    if ([text isEqualToString:@""]) {
        self.textField.placeholder = placeholder;
    }else{
        self.textField.text = text;
    }
    self.textField.layer.borderWidth = 1;
    self.textField.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    self.textField.delegate = self;
    [self.contentView addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    if (self.symtomDelegate && [self.symtomDelegate respondsToSelector:@selector(sendTextFieldValue:)]) {
        [self.symtomDelegate sendTextFieldValue:self.textField.text];
    }
    
    if (self.jiwangshiDelegate && [self.jiwangshiDelegate respondsToSelector:@selector(sendTextField1Value:)]) {
        [self.jiwangshiDelegate sendTextField1Value:self.textField.text];
    }
    if (self.shoushushiDelegate && [self.shoushushiDelegate respondsToSelector:@selector(sendTextField2Value:)]) {
        [self.shoushushiDelegate sendTextField2Value:self.textField.text];
    }
    if (self.guominshiDelegate && [self.guominshiDelegate respondsToSelector:@selector(sendTextField3Value:)]) {
        [self.guominshiDelegate sendTextField3Value:self.textField.text];
    }
    if (self.jiazushiDelegate && [self.jiazushiDelegate respondsToSelector:@selector(sendTextField4Value:)]) {
        [self.jiazushiDelegate sendTextField4Value:self.textField.text];
    }
    
    if (self.yuejingbijingDelegate && [self.yuejingbijingDelegate respondsToSelector:@selector(sendYuejingbijingValue:)]) {
        [self.yuejingbijingDelegate sendYuejingbijingValue:self.textField.text];
    }
    if (self.yuejingqitaDelegate && [self.yuejingqitaDelegate respondsToSelector:@selector(sendYuejingqitaValue:)]) {
        [self.yuejingqitaDelegate sendYuejingqitaValue:self.textField.text];
    }
    return YES;
}

@end
