//
//  SelfInspectionOneTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SelfInspectionOneTableCell.h"
#import "HudUtil.h"

@interface SelfInspectionOneTableCell ()<UITextFieldDelegate,UITextViewDelegate>

@end

@implementation SelfInspectionOneTableCell
-(void)initViewWithLabel:(NSString *)text{
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:13];
    if ([text isEqualToString:@""]) {
        self.label.text = @"暂无";
    }else{
        self.label.text = text;
    }
    
    self.label.textColor = ColorWithHexRGB(0xb2b2b2);
    self.label.numberOfLines = 0;
    [self.contentView addSubview:self.label];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(10);
    }];
}

-(void)initViewWithTextField:(NSString *)placeholder text:(NSString *)text{
//    self.textField = [[UITextField alloc] init];
//    if ([text isEqualToString:@""]) {
//        self.textField.placeholder = placeholder;
//    }else{
//        self.textField.text = text;
//    }
//    self.textField.layer.borderWidth = 1;
//    self.textField.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
//    self.textField.delegate = self;
//    self.textField.returnKeyType = UIReturnKeyDone;
//    [self.contentView addSubview:self.textField];
//    
//    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.contentView).offset(12);
//        make.trailing.equalTo(self.contentView).offset(-12);
//        make.top.equalTo(self.contentView).offset(10);
//        make.bottom.equalTo(self.contentView).offset(-15);
//    }];
    
    self.textView = [[UITextView alloc] init];
    if ([text isEqualToString:@""]) {
        self.textView.text = placeholder;
        self.textView.textColor = ColorWithHexRGB(0xcccccc);
        self.textView.delegate = self;
    }else{
        self.textView.text = text;
    }
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
//    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.returnKeyType = UIReturnKeyDefault;
    [self.contentView addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-12);
    }];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    doneButton.tintColor = kMAIN_COLOR;
    NSArray * buttonsArray = [NSArray arrayWithObjects:helloButton,btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    [self.textView setInputAccessoryView:topView];
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

#pragma mark UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    DLog(@"textViewDidBeginEditing");
    self.textView.text = @"";
    self.textView.textColor = ColorWithHexRGB(0x323232);
}

-(void)dismissKeyBoard{
    if (!(self.textView.text.length <= 200)) {
        NSString *string = [NSString stringWithFormat:@"当前字数为%lu，字数不能超过200！",(unsigned long)self.textView.text.length];
        [HudUtil showSimpleTextOnlyHUD:string withDelaySeconds:kHud_DelayTime];
    }else{
        [self.textView resignFirstResponder];
        
        if (self.symtomDelegate && [self.symtomDelegate respondsToSelector:@selector(sendTextFieldValue:)]) {
            [self.symtomDelegate sendTextFieldValue:self.textView.text];
        }
        
        if (self.jiwangshiDelegate && [self.jiwangshiDelegate respondsToSelector:@selector(sendTextField1Value:)]) {
            [self.jiwangshiDelegate sendTextField1Value:self.textView.text];
        }
        if (self.shoushushiDelegate && [self.shoushushiDelegate respondsToSelector:@selector(sendTextField2Value:)]) {
            [self.shoushushiDelegate sendTextField2Value:self.textView.text];
        }
        if (self.guominshiDelegate && [self.guominshiDelegate respondsToSelector:@selector(sendTextField3Value:)]) {
            [self.guominshiDelegate sendTextField3Value:self.textView.text];
        }
        if (self.jiazushiDelegate && [self.jiazushiDelegate respondsToSelector:@selector(sendTextField4Value:)]) {
            [self.jiazushiDelegate sendTextField4Value:self.textView.text];
        }
        
        if (self.yuejingbijingDelegate && [self.yuejingbijingDelegate respondsToSelector:@selector(sendYuejingbijingValue:)]) {
            [self.yuejingbijingDelegate sendYuejingbijingValue:self.textView.text];
        }
        if (self.yuejingqitaDelegate && [self.yuejingqitaDelegate respondsToSelector:@selector(sendYuejingqitaValue:)]) {
            [self.yuejingqitaDelegate sendYuejingqitaValue:self.textView.text];
        }
    }
}

@end
