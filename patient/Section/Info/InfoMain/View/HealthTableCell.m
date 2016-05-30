//
//  HealthTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthTableCell.h"

@implementation HealthTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark Init Section
-(void)initViewWithArray:(NSMutableArray *)Array{
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 118) imageURLStringsGroup:Array];
    self.scrollView.currentPageDotColor = [UIColor colorWithRed:82/255.0 green:205/255.0 blue:175/255.0 alpha:1];
    self.scrollView.autoScrollTimeInterval = 5;
    self.scrollView.delegate = self;
    [self.contentView addSubview:self.scrollView];
}

#pragma mark SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DLog(@"点击了第%ld张图片", index);
    
    if (self.healthViewDelegate && [self.healthViewDelegate respondsToSelector:@selector(healthViewClicked:)]) {
        [self.healthViewDelegate healthViewClicked:index];
    }
}

@end
