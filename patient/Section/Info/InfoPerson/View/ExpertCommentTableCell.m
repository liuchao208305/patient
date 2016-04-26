//
//  ExpertCommentTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertCommentTableCell.h"

@interface ExpertCommentTableCell ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger page;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIView *mainView;
@property (strong,nonatomic)UIView *subView1;
@property (strong,nonatomic)UIView *subView2;
@property (strong,nonatomic)UIView *subView3;


@end

@implementation ExpertCommentTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 74*SCREEN_SCALE+10)];
    self.scrollView.contentSize = CGSizeMake(0, self.contentView.height*3);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:self.scrollView];
    
    for (int i = 0; i <3; i++) {
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, i*(74*SCREEN_SCALE+10), SCREEN_WIDTH, 74*SCREEN_SCALE+10)];
        self.mainView.tag = 100+i;
        [self.scrollView addSubview:self.mainView];
    }
    
    self.subView1 = (UIView *)[self viewWithTag:100];
    [self iniSubView1];
    self.subView1.backgroundColor = kWHITE_COLOR;
    
    self.subView2 = (UIView *)[self viewWithTag:101];
    [self initSubView2];
    self.subView2.backgroundColor = kWHITE_COLOR;
    
    self.subView3 = (UIView *)[self viewWithTag:102];
    [self initSubView3];
    self.subView3.backgroundColor = kWHITE_COLOR;
    
    [self startTimer];
}

-(void)iniSubView1{
    self.bannerImageView1 = [[UIImageView alloc] init];
    [self.bannerImageView1 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
    [self.subView1 addSubview:self.bannerImageView1];
    
    self.label1_1 = [[UILabel alloc] init];
    self.label1_1.text = @"张可可";
    [self.subView1 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
    self.label1_2.text = @"赞";
    self.label1_2.textColor = [UIColor redColor];
    [self.subView1 addSubview:self.label1_2];
    
    self.label1_3 = [[UILabel alloc] init];
    self.label1_3.text = @"尤医生";
    [self.subView1 addSubview:self.label1_3];
    
    self.label1_4 = [[UILabel alloc] init];
    self.label1_4.text = @"神丹妙药";
    self.label1_4.textColor = [UIColor redColor];
    [self.subView1 addSubview:self.label1_4];
    
    [self.bannerImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subView1).offset(10);
        make.centerY.equalTo(self.subView1).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(106-20);
    }];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bannerImageView1).offset(20+40);
        make.centerY.equalTo(self.bannerImageView1).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(60+10);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(14);
    }];
    
    [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_2).offset(20);
        make.centerY.equalTo(self.label1_2).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
    }];
    
    [self.label1_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_3).offset(60+10);
        make.centerY.equalTo(self.label1_3).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14);
    }];
}

-(void)initSubView2{
    self.bannerImageView2 = [[UIImageView alloc] init];
    [self.bannerImageView2 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
    [self.subView2 addSubview:self.bannerImageView2];
    
    self.label2_1 = [[UILabel alloc] init];
    self.label2_1.text = @"洛可可";
    [self.subView2 addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
    self.label2_2.text = @"赞";
    self.label2_2.textColor = [UIColor redColor];
    [self.subView2 addSubview:self.label2_2];
    
    self.label2_3 = [[UILabel alloc] init];
    self.label2_3.text = @"尤医生";
    [self.subView2 addSubview:self.label2_3];
    
    self.label2_4 = [[UILabel alloc] init];
    self.label2_4.text = @"妙手回春";
    self.label2_4.textColor = [UIColor redColor];
    [self.subView2 addSubview:self.label2_4];
    
    [self.bannerImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subView2).offset(10);
        make.centerY.equalTo(self.subView2).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(106-20);
    }];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bannerImageView2).offset(20+40);
        make.centerY.equalTo(self.bannerImageView2).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_1).offset(60+10);
        make.centerY.equalTo(self.label2_1).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(14);
    }];
    
    [self.label2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_2).offset(20);
        make.centerY.equalTo(self.label2_2).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
    }];
    
    [self.label2_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_3).offset(60+10);
        make.centerY.equalTo(self.label2_3).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14);
    }];
}

-(void)initSubView3{
    self.bannerImageView3 = [[UIImageView alloc] init];
    [self.bannerImageView3 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
    [self.subView3 addSubview:self.bannerImageView3];
    
    self.label3_1 = [[UILabel alloc] init];
    self.label3_1.text = @"洛可可";
    [self.subView3 addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
    self.label3_2.text = @"赞";
    self.label3_2.textColor = [UIColor redColor];
    [self.subView3 addSubview:self.label3_2];
    
    self.label3_3 = [[UILabel alloc] init];
    self.label3_3.text = @"尤医生";
    [self.subView3 addSubview:self.label3_3];
    
    self.label3_4 = [[UILabel alloc] init];
    self.label3_4.text = @"救死扶伤";
    self.label3_4.textColor = [UIColor redColor];
    [self.subView3 addSubview:self.label3_4];
    
    [self.bannerImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subView3).offset(10);
        make.centerY.equalTo(self.subView3).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(106-20);
    }];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bannerImageView3).offset(20+40);
        make.centerY.equalTo(self.bannerImageView3).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_1).offset(60+10);
        make.centerY.equalTo(self.label3_1).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(14);
    }];
    
    [self.label3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_2).offset(20);
        make.centerY.equalTo(self.label3_2).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
    }];
    
    [self.label3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_3).offset(60+10);
        make.centerY.equalTo(self.label3_3).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14);
    }];
}

#pragma mark Target Action
-(void)startTimer{
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


-(void)nextPage{
    self.page++;
    if (self.page == 3) {
        self.page = 0;
    }
    
    [UIView animateWithDuration:0.7 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, self.page * (74*SCREEN_SCALE+10))];
    }];
}

@end
