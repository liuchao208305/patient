//
//  ClinicDoctorTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ClinicDoctorTableCell.h"
#import "ClinicDoctorView.h"

@interface ClinicDoctorTableCell ()

@property (strong,nonatomic)UIScrollView *scrollView;

@end

@implementation ClinicDoctorTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
    
    self.scrollView.contentSize = CGSizeMake(2*SCREEN_WIDTH, 0);
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.contentView addSubview:self.scrollView];
    
    [self initSubView];
}

-(void)initSubView{
    for (int i = 0; i<10; i++) {
        ClinicDoctorView *doctorView = [[ClinicDoctorView alloc] init];
        doctorView.tag = i;
//        doctorView.frame = CGRectMake((i+1)*27+i*69, 16, 69, 150);
        doctorView.frame = CGRectMake((i+1)*(SCREEN_WIDTH-69*3)/4+i*69, 16, 69, 150);
        [doctorView.doctorImage setImage:[UIImage imageNamed:@"default_image_small"]];
        doctorView.doctorName.text = @"test";
        doctorView.doctorDomain.text = @"test";
        [self.scrollView addSubview:doctorView];
        
        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doctorViewClicked:)];
        [doctorView addGestureRecognizer:recognizer];
    }
    
    self.scrollView.contentSize = CGSizeMake(10*(27+69)+27, 0);
}


#pragma mark Target Action
-(void)doctorViewClicked:(UIGestureRecognizer *)sender{
    NSLog(@"%ld",sender.view.tag);
}

@end
