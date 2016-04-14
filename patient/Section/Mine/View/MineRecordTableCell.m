//
//  MineRecordTabelCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineRecordTableCell.h"
#import "RecordView.h"

@interface MineRecordTableCell ()

@property (strong,nonatomic)UIScrollView *scrollView;

@end

@implementation MineRecordTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    
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
        RecordView *recordView = [[RecordView alloc] init];
        recordView.tag = i;
//        recordView.frame = CGRectMake((i+1)*21+i*46, 15, 46, 55);
        recordView.frame = CGRectMake((i+1)*(SCREEN_WIDTH-46*4)/5+i*46, 15, 46, 55);
        [recordView.recordImage setImage:[UIImage imageNamed:@"mine_default_medical_record"]];
        recordView.recordName.text = @"张小泉";
        [self.scrollView addSubview:recordView];
        
        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recordViewClicked:)];
        [recordView addGestureRecognizer:recognizer];
    }
    
    self.scrollView.contentSize = CGSizeMake(10*((SCREEN_WIDTH-46*4)/5+46)+21, 0);
}

#pragma mark Target Action
-(void)recordViewClicked:(UIGestureRecognizer *)sender{
    NSLog(@"%ld",sender.view.tag);
}

@end
