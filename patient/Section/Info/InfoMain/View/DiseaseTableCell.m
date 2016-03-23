//
//  DiseaseTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "DiseaseTableCell.h"
#import "AdaptionUtil.h"

@implementation DiseaseTableCell

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
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    if ([AdaptionUtil isIphoneFour]) {
        self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 154)];
        [self initBackView1];
        [self.contentView addSubview:self.backView1];
        
        self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 1,154)];
        self.lineView1.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.lineView1];
        
        self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(111, 0, SCREEN_WIDTH-110-1, 67)];
        [self initBackView2];
        [self.contentView addSubview:self.backView2];
        
        self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(111, 68, SCREEN_WIDTH-111, 1)];
        self.lineView2.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.lineView2];
        
        self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(111, 69, SCREEN_WIDTH-111, 154-67)];
        [self initBackView3];
        [self.contentView addSubview:self.backView3];
    }else if ([AdaptionUtil isIphoneFive]){
        self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 154)];
        [self initBackView1];
        [self.contentView addSubview:self.backView1];
        
        self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 1,154)];
        self.lineView1.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.lineView1];
        
        self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(111, 0, SCREEN_WIDTH-110-1, 67)];
        [self initBackView2];
        [self.contentView addSubview:self.backView2];
        
        self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(111, 68, SCREEN_WIDTH-111, 1)];
        self.lineView2.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.lineView2];
        
        self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(111, 69, SCREEN_WIDTH-111, 154-67)];
        [self initBackView3];
        [self.contentView addSubview:self.backView3];
    }else if ([AdaptionUtil isIphoneSix]){
        self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 154)];
        [self initBackView1];
        [self.contentView addSubview:self.backView1];
        
        self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 1,154)];
        self.lineView1.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.lineView1];
        
        self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(111, 0, SCREEN_WIDTH-110-1, 67)];
        [self initBackView2];
        [self.contentView addSubview:self.backView2];
        
        self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(111, 68, SCREEN_WIDTH-111, 1)];
        self.lineView2.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.lineView2];
        
        self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(111, 69, SCREEN_WIDTH-111, 154-67)];
        [self initBackView3];
        [self.contentView addSubview:self.backView3];
    }else if ([AdaptionUtil isIphoneSixPlus]){
        self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 154)];
        [self initBackView1];
        [self.contentView addSubview:self.backView1];
        
        self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(150, 0, 1,154)];
        self.lineView1.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.lineView1];
        
        self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(151, 0, SCREEN_WIDTH-150-1, 67)];
        [self initBackView2];
        [self.contentView addSubview:self.backView2];
        
        self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(151, 68, SCREEN_WIDTH-151, 1)];
        self.lineView2.backgroundColor = kBACKGROUND_COLOR;
        [self.contentView addSubview:self.lineView2];
        
        self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(151, 69, SCREEN_WIDTH-151, 154-67)];
        [self initBackView3];
        [self.contentView addSubview:self.backView3];
    }
}

-(void)initBackView1{
    self.guominImageView = [[UIImageView alloc] init];
    [self.backView1 addSubview:self.guominImageView];
    
    self.guominLabel1 = [[UILabel alloc] init];
    self.guominLabel1.font = [UIFont systemFontOfSize:15];
    [self.backView1 addSubview:self.guominLabel1];
    
    self.guominLabel2 = [[UILabel alloc] init];
    self.guominLabel2.font = [UIFont systemFontOfSize:15];
    [self.backView1 addSubview:self.guominLabel2];
    
    self.guominLabel3 = [[UILabel alloc] init];
    self.guominLabel3.font = [UIFont systemFontOfSize:12];
    [self.backView1 addSubview:self.guominLabel3];
    
    [self.guominImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView1).offset(0);
        make.top.equalTo(self.backView1).offset(23);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(56);
    }];
    
    [self.guominLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.guominImageView).offset(-10);
        make.top.equalTo(self.guominImageView).offset(70);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.guominLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.guominImageView).offset(30);
        make.centerY.equalTo(self.guominLabel1).offset(0);
        make.width.equalTo(self.guominLabel1);
        make.height.equalTo(self.guominLabel1);
    }];
    
    [self.guominLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView1).offset(0);
        make.bottom.equalTo(self.backView1).offset(-23);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
}

-(void)initBackView2{
    if ([AdaptionUtil isIphoneFour]) {
        self.laotouLabel1 = [[UILabel alloc] init];
        self.laotouLabel1.font = [UIFont systemFontOfSize:15];
        [self.backView2 addSubview:self.laotouLabel1];
        
        self.laotouLabel2 = [[UILabel alloc] init];
        self.laotouLabel2.font = [UIFont systemFontOfSize:12];
        [self.backView2 addSubview:self.laotouLabel2];
        
        self.laotouImageView = [[UIImageView alloc] init];
        [self.backView2 addSubview:self.laotouImageView];
        
        [self.laotouLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.backView2).offset(25);
            make.top.equalTo(self.backView2).offset(15);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(15);
        }];
        
        [self.laotouLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.laotouLabel1).offset(0);
            make.bottom.equalTo(self.backView2).offset(-15);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(13);
        }];
        
        [self.laotouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backView2).offset(0);
            make.trailing.equalTo(self.backView2).offset(-39);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(50);
        }];
    }else if ([AdaptionUtil isIphoneFive]){
        self.laotouLabel1 = [[UILabel alloc] init];
        self.laotouLabel1.font = [UIFont systemFontOfSize:15];
        [self.backView2 addSubview:self.laotouLabel1];
        
        self.laotouLabel2 = [[UILabel alloc] init];
        self.laotouLabel2.font = [UIFont systemFontOfSize:12];
        [self.backView2 addSubview:self.laotouLabel2];
        
        self.laotouImageView = [[UIImageView alloc] init];
        [self.backView2 addSubview:self.laotouImageView];
        
        [self.laotouLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.backView2).offset(25);
            make.top.equalTo(self.backView2).offset(15);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(15);
        }];
        
        [self.laotouLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.laotouLabel1).offset(0);
            make.bottom.equalTo(self.backView2).offset(-15);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(13);
        }];
        
        [self.laotouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backView2).offset(0);
            make.trailing.equalTo(self.backView2).offset(-39);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(50);
        }];
    }else if ([AdaptionUtil isIphoneSix]){
        self.laotouLabel1 = [[UILabel alloc] init];
        self.laotouLabel1.font = [UIFont systemFontOfSize:15];
        [self.backView2 addSubview:self.laotouLabel1];
        
        self.laotouLabel2 = [[UILabel alloc] init];
        self.laotouLabel2.font = [UIFont systemFontOfSize:12];
        [self.backView2 addSubview:self.laotouLabel2];
        
        self.laotouImageView = [[UIImageView alloc] init];
        [self.backView2 addSubview:self.laotouImageView];
        
        [self.laotouLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.backView2).offset(40);
            make.top.equalTo(self.backView2).offset(15);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(15);
        }];
        
        [self.laotouLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.laotouLabel1).offset(0);
            make.bottom.equalTo(self.backView2).offset(-15);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(13);
        }];
        
        [self.laotouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backView2).offset(0);
            make.trailing.equalTo(self.backView2).offset(-50);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(50);
        }];
    }else if ([AdaptionUtil isIphoneSixPlus]){
        self.laotouLabel1 = [[UILabel alloc] init];
        self.laotouLabel1.font = [UIFont systemFontOfSize:15];
        [self.backView2 addSubview:self.laotouLabel1];
        
        self.laotouLabel2 = [[UILabel alloc] init];
        self.laotouLabel2.font = [UIFont systemFontOfSize:12];
        [self.backView2 addSubview:self.laotouLabel2];
        
        self.laotouImageView = [[UIImageView alloc] init];
        [self.backView2 addSubview:self.laotouImageView];
        
        [self.laotouLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.backView2).offset(45);
            make.top.equalTo(self.backView2).offset(15);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(15);
        }];
        
        [self.laotouLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.laotouLabel1).offset(0);
            make.bottom.equalTo(self.backView2).offset(-15);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(13);
        }];
        
        [self.laotouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backView2).offset(0);
            make.trailing.equalTo(self.backView2).offset(-50);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(50);
        }];
    }
}

-(void)initBackView3{
    self.keshiView1 = [[UIView alloc] init];
    [self initKeshiView1];
    [self.backView3 addSubview:self.keshiView1];
    
    self.keshiView2 = [[UIView alloc] init];
    [self initKeshiView2];
    [self.backView3 addSubview:self.keshiView2];
    
    self.keshiView3 = [[UIView alloc] init];
    [self initKeshiView3];
    [self.backView3 addSubview:self.keshiView3];
    
    self.keshiView4 = [[UIView alloc] init];
    [self initKeshiView4];
    [self.backView3 addSubview:self.keshiView4];
    
    [self.keshiView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(0);
        make.top.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-111)/2);
        make.height.mas_equalTo((154-68)/2);
    }];
    
    [self.keshiView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView3).offset(0);
        make.right.equalTo(self.backView3).offset(0);
        make.width.equalTo(self.keshiView1);
        make.height.equalTo(self.keshiView1);
    }];
    
    [self.keshiView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(0);
        make.bottom.equalTo(self.backView3).offset(0);
        make.width.equalTo(self.keshiView1);
        make.height.equalTo(self.keshiView1);
    }];
    
    [self.keshiView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView3).offset(0);
        make.bottom.equalTo(self.backView3).offset(0);
        make.width.equalTo(self.keshiView1);
        make.height.equalTo(self.keshiView1);
    }];
}

-(void)initKeshiView1{
    if ([AdaptionUtil isIphoneFour]) {
        self.keshiImageView1 = [[UIImageView alloc] init];
        [self.keshiView1 addSubview:self.keshiImageView1];
        
        self.keshiLabel1 = [[UILabel alloc] init];
        self.keshiLabel1.font = [UIFont systemFontOfSize:12];
        [self.keshiView1 addSubview:self.keshiLabel1];
        
        [self.keshiImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView1).offset(10);
            make.centerY.equalTo(self.keshiView1).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView1).offset(23+10);
            make.centerY.equalTo(self.keshiImageView1).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneFive]){
        self.keshiImageView1 = [[UIImageView alloc] init];
        [self.keshiView1 addSubview:self.keshiImageView1];
        
        self.keshiLabel1 = [[UILabel alloc] init];
        self.keshiLabel1.font = [UIFont systemFontOfSize:12];
        [self.keshiView1 addSubview:self.keshiLabel1];
        
        [self.keshiImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView1).offset(10);
            make.centerY.equalTo(self.keshiView1).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView1).offset(23+10);
            make.centerY.equalTo(self.keshiImageView1).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneSix]){
        self.keshiImageView1 = [[UIImageView alloc] init];
        [self.keshiView1 addSubview:self.keshiImageView1];
        
        self.keshiLabel1 = [[UILabel alloc] init];
        self.keshiLabel1.font = [UIFont systemFontOfSize:12];
        [self.keshiView1 addSubview:self.keshiLabel1];
        
        [self.keshiImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView1).offset(20);
            make.centerY.equalTo(self.keshiView1).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView1).offset(23+20);
            make.centerY.equalTo(self.keshiImageView1).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneSixPlus]){
        self.keshiImageView1 = [[UIImageView alloc] init];
        [self.keshiView1 addSubview:self.keshiImageView1];
        
        self.keshiLabel1 = [[UILabel alloc] init];
        self.keshiLabel1.font = [UIFont systemFontOfSize:12];
        [self.keshiView1 addSubview:self.keshiLabel1];
        
        [self.keshiImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView1).offset(20);
            make.centerY.equalTo(self.keshiView1).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView1).offset(23+20);
            make.centerY.equalTo(self.keshiImageView1).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }
}

-(void)initKeshiView2{
    if ([AdaptionUtil isIphoneFour]) {
        self.keshiImageView2 = [[UIImageView alloc] init];
        [self.keshiView2 addSubview:self.keshiImageView2];
        
        self.keshiLabel2 = [[UILabel alloc] init];
        self.keshiLabel2.font = [UIFont systemFontOfSize:12];
        [self.keshiView2 addSubview:self.keshiLabel2];
        
        [self.keshiImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView2).offset(10);
            make.centerY.equalTo(self.keshiView2).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView2).offset(23+10);
            make.centerY.equalTo(self.keshiImageView2).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneFive]){
        self.keshiImageView2 = [[UIImageView alloc] init];
        [self.keshiView2 addSubview:self.keshiImageView2];
        
        self.keshiLabel2 = [[UILabel alloc] init];
        self.keshiLabel2.font = [UIFont systemFontOfSize:12];
        [self.keshiView2 addSubview:self.keshiLabel2];
        
        [self.keshiImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView2).offset(10);
            make.centerY.equalTo(self.keshiView2).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView2).offset(23+10);
            make.centerY.equalTo(self.keshiImageView2).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneSix]){
        self.keshiImageView2 = [[UIImageView alloc] init];
        [self.keshiView2 addSubview:self.keshiImageView2];
        
        self.keshiLabel2 = [[UILabel alloc] init];
        self.keshiLabel2.font = [UIFont systemFontOfSize:12];
        [self.keshiView2 addSubview:self.keshiLabel2];
        
        [self.keshiImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView2).offset(20);
            make.centerY.equalTo(self.keshiView2).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView2).offset(40);
            make.centerY.equalTo(self.keshiImageView2).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneSixPlus]){
        self.keshiImageView2 = [[UIImageView alloc] init];
        [self.keshiView2 addSubview:self.keshiImageView2];
        
        self.keshiLabel2 = [[UILabel alloc] init];
        self.keshiLabel2.font = [UIFont systemFontOfSize:12];
        [self.keshiView2 addSubview:self.keshiLabel2];
        
        [self.keshiImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView2).offset(20);
            make.centerY.equalTo(self.keshiView2).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView2).offset(23+20);
            make.centerY.equalTo(self.keshiImageView2).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }
}

-(void)initKeshiView3{
    if ([AdaptionUtil isIphoneFour]) {
        self.keshiImageView3 = [[UIImageView alloc] init];
        [self.keshiView3 addSubview:self.keshiImageView3];
        
        self.keshiLabel3 = [[UILabel alloc] init];
        self.keshiLabel3.font = [UIFont systemFontOfSize:12];
        [self.keshiView3 addSubview:self.keshiLabel3];
        
        [self.keshiImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView3).offset(10);
            make.centerY.equalTo(self.keshiView3).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView3).offset(23+10);
            make.centerY.equalTo(self.keshiImageView3).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneFive]){
        self.keshiImageView3 = [[UIImageView alloc] init];
        [self.keshiView3 addSubview:self.keshiImageView3];
        
        self.keshiLabel3 = [[UILabel alloc] init];
        self.keshiLabel3.font = [UIFont systemFontOfSize:12];
        [self.keshiView3 addSubview:self.keshiLabel3];
        
        [self.keshiImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView3).offset(10);
            make.centerY.equalTo(self.keshiView3).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView3).offset(23+10);
            make.centerY.equalTo(self.keshiImageView3).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneSix]){
        self.keshiImageView3 = [[UIImageView alloc] init];
        [self.keshiView3 addSubview:self.keshiImageView3];
        
        self.keshiLabel3 = [[UILabel alloc] init];
        self.keshiLabel3.font = [UIFont systemFontOfSize:12];
        [self.keshiView3 addSubview:self.keshiLabel3];
        
        [self.keshiImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView3).offset(20);
            make.centerY.equalTo(self.keshiView3).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView3).offset(40);
            make.centerY.equalTo(self.keshiImageView3).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneSixPlus]){
        self.keshiImageView3 = [[UIImageView alloc] init];
        [self.keshiView3 addSubview:self.keshiImageView3];
        
        self.keshiLabel3 = [[UILabel alloc] init];
        self.keshiLabel3.font = [UIFont systemFontOfSize:12];
        [self.keshiView3 addSubview:self.keshiLabel3];
        
        [self.keshiImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView3).offset(20);
            make.centerY.equalTo(self.keshiView3).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView3).offset(23+20);
            make.centerY.equalTo(self.keshiImageView3).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }
}

-(void)initKeshiView4{
    if ([AdaptionUtil isIphoneFour]) {
        self.keshiImageView4 = [[UIImageView alloc] init];
        [self.keshiView4 addSubview:self.keshiImageView4];
        
        self.keshiLabel4 = [[UILabel alloc] init];
        self.keshiLabel4.font = [UIFont systemFontOfSize:12];
        [self.keshiView4 addSubview:self.keshiLabel4];
        
        [self.keshiImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView4).offset(10);
            make.centerY.equalTo(self.keshiView4).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView4).offset(23+10);
            make.centerY.equalTo(self.keshiImageView4).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneFive]){
        self.keshiImageView4 = [[UIImageView alloc] init];
        [self.keshiView4 addSubview:self.keshiImageView4];
        
        self.keshiLabel4 = [[UILabel alloc] init];
        self.keshiLabel4.font = [UIFont systemFontOfSize:12];
        [self.keshiView4 addSubview:self.keshiLabel4];
        
        [self.keshiImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView4).offset(10);
            make.centerY.equalTo(self.keshiView4).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView4).offset(23+10);
            make.centerY.equalTo(self.keshiImageView4).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneSix]){
        self.keshiImageView4 = [[UIImageView alloc] init];
        [self.keshiView4 addSubview:self.keshiImageView4];
        
        self.keshiLabel4 = [[UILabel alloc] init];
        self.keshiLabel4.font = [UIFont systemFontOfSize:12];
        [self.keshiView4 addSubview:self.keshiLabel4];
        
        [self.keshiImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView4).offset(20);
            make.centerY.equalTo(self.keshiView4).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView4).offset(40);
            make.centerY.equalTo(self.keshiImageView4).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }else if ([AdaptionUtil isIphoneSixPlus]){
        self.keshiImageView4 = [[UIImageView alloc] init];
        [self.keshiView4 addSubview:self.keshiImageView4];
        
        self.keshiLabel4 = [[UILabel alloc] init];
        self.keshiLabel4.font = [UIFont systemFontOfSize:12];
        [self.keshiView4 addSubview:self.keshiLabel4];
        
        [self.keshiImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiView4).offset(20);
            make.centerY.equalTo(self.keshiView4).offset(0);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(23);
        }];
        
        [self.keshiLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.keshiImageView4).offset(23+20);
            make.centerY.equalTo(self.keshiImageView4).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
        }];
    }
}

@end
