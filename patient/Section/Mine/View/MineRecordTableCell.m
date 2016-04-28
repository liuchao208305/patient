//
//  MineRecordTabelCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineRecordTableCell.h"

@interface MineRecordTableCell ()

@property (strong,nonatomic)UIScrollView *scrollView;

@end

@implementation MineRecordTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark Init Section
-(void)initView:(NSInteger)number Withid:(NSMutableArray *)recordIdArray image:(NSMutableArray *)recordImageArray name:(NSMutableArray *)recordNameArray patientName:(NSMutableArray *)recordPatientNameArray{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    
    self.scrollView.contentSize = CGSizeMake(2*SCREEN_WIDTH, 0);
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.contentView addSubview:self.scrollView];
    
    [self initSubView:number Withid:recordIdArray image:recordImageArray name:recordPatientNameArray patientName:recordPatientNameArray];
}

-(void)initSubView:(NSInteger)number Withid:(NSMutableArray *)recordIdArray image:(NSMutableArray *)recordImageArray name:(NSMutableArray *)recordNameArray patientName:(NSMutableArray *)recordPatientNameArray{
    for (int i = 0; i<number; i++) {
        self.recordView = [[RecordView alloc] init];
        self.recordView.tag = i;
        self.recordView.frame = CGRectMake((i+1)*(SCREEN_WIDTH-46*4)/5+i*46, 15, 46, 55);
        
        self.recordView.recordId = recordIdArray[i];
        [self.recordView.recordImage sd_setImageWithURL:[NSURL URLWithString:recordNameArray[i]] placeholderImage:[UIImage imageNamed:@"mine_default_medical_record"]];
        self.recordView.recordName.text = recordNameArray[i];
        self.recordView.recordPatientName = recordPatientNameArray[i];
        
        [self.scrollView addSubview:self.recordView];
        
        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recordViewClicked:)];
        [self.recordView addGestureRecognizer:recognizer];
    }
    
    self.scrollView.contentSize = CGSizeMake(number*((SCREEN_WIDTH-46*4)/5+46)+21, 0);
}

#pragma mark Target Action
-(void)recordViewClicked:(UIGestureRecognizer *)sender{
    DLog(@"%ld",sender.view.tag);
    
    if (self.recordViewDelegate && [self.recordViewDelegate respondsToSelector:@selector(recordViewClicked:)]) {
        [self.recordViewDelegate recordViewClicked:sender.view.tag];
    }
}

@end
