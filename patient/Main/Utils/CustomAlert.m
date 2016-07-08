//
//  CustomAlert.m
//  CustomAlertBlock
//
//  Created by student on 16/3/29.
//  Copyright © 2016年 chenShuai. All rights reserved.
//

#import "CustomAlert.h"

@implementation CustomAlert

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithTitle:(NSString *)title withMsg:(NSString *)msg withCancel:(NSString *)cancel withSure:(NSString *)sure
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.frame = [UIScreen mainScreen].bounds;
        UIView *alertView = [[UIView alloc] init];
        alertView.backgroundColor = [UIColor whiteColor];
        alertView.clipsToBounds = YES;
        alertView.layer.cornerRadius = 6;
        [self addSubview:alertView];
        [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(0);
            make.centerY.equalTo(self).offset(0);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(155);
        }];
        
        //title
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [alertView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertView).offset(0);
            make.centerX.equalTo(alertView).offset(0);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        
        //message
        UILabel *msgLabel = [[UILabel alloc] init];
        msgLabel.text = msg;
        msgLabel.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
        msgLabel.textAlignment = NSTextAlignmentCenter;
        msgLabel.numberOfLines = 0;
        msgLabel.font = [UIFont systemFontOfSize:18];
        [alertView addSubview:msgLabel];
        [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertView).offset(30);
            make.centerX.equalTo(alertView).offset(3);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(60);
        }];
        
        //line
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1];
        [alertView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertView).offset(110);
            make.centerX.equalTo(alertView).offset(0);
            make.width.mas_equalTo(alertView);
            make.height.mas_equalTo(1);
        }];
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1];
        [alertView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1).offset(0);
            make.centerX.equalTo(alertView).offset(0);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(alertView);
        }];
        
        //取消按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:245/255.0];
        [cancelBtn setTitle:cancel forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.tag = 1;
        [alertView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1).offset(1);
            make.left.equalTo(alertView).offset(0);
            make.width.mas_equalTo(125);
            make.height.mas_equalTo(44);
        }];
        
        //确定按钮
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(140, 200-50, 140, 50);
        sureBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:245/255.0];
        [sureBtn setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [sureBtn setTitle:sure forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.tag = 2;
        [alertView addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1).offset(1);
            make.left.equalTo(line2).offset(1);
            make.width.mas_equalTo(125);
            make.height.mas_equalTo(44);
        }];
        
    }
    
    return self;
}

- (void)alertViewShow
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self];
    
    
}

- (void)btnClick:(UIButton *)btn
{
    //点击btn的时候要把用户点击的那个btn的tag值传出去
    if (self.alertViewBlock)
    {
        self.alertViewBlock(btn.tag);
    }
    
    //先把这个弹出框从父视图上移除
    [self removeFromSuperview];
    
    
    
}





@end
