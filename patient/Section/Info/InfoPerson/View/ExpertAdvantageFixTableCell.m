//
//  ExpertAdvantageFixTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertAdvantageFixTableCell.h"

@interface ExpertAdvantageFixTableCell (){
    UIImageView *_titleImage;
    UILabel      *_textTitle;
    UILabel      *_textContent;
    UIButton     *_moreTextBtn;
    UIButton *_moreTextBtn2;
}

@end

@implementation ExpertAdvantageFixTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.mainView = [[UIView alloc] init];
    [self initMainView];
    [self.contentView addSubview:self.mainView];
    
    self.lineView = [[UIView alloc] init];
    [self initLineView];
    [self.contentView addSubview:self.lineView];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.lineView).offset(-1);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)initMainView{
    _titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 16, 15, 15)];
    [_titleImage setImage:[UIImage imageNamed:@"info_expert_jingli_image"]];
    [self.mainView addSubview:_titleImage];
    
    _textTitle = [[UILabel alloc]initWithFrame:CGRectMake(12+15+10, 16, 140, 15)];
//    _textTitle.textColor = [UIColor blackColor];
    _textTitle.textColor = ColorWithHexRGB(0x646464);
    _textTitle.font = [UIFont systemFontOfSize:16];
    [self.mainView addSubview:_textTitle];
    
    _textContent = [[UILabel alloc]initWithFrame:CGRectMake(12, 16+15+5,SCREEN_WIDTH - 24 , 20)];
//    _textContent.textColor = [UIColor blackColor];
    _textContent.textColor = ColorWithHexRGB(0x646464);
    _textContent.font = [UIFont systemFontOfSize:14];
    _textContent.numberOfLines = 0;
    [self.mainView addSubview:_textContent];
    
//    _moreTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_moreTextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    _moreTextBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 5, 40, 16);
//    [self.mainView addSubview:_moreTextBtn];
//    [_moreTextBtn addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
    
    _moreTextBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreTextBtn2.frame = CGRectMake(SCREEN_WIDTH/2, 16+15+5+20+15, 15, 15);
    [_moreTextBtn2 setImage:[UIImage imageNamed:@"info_expert_xiangxia_image"] forState:UIControlStateNormal];
    [self.mainView addSubview:_moreTextBtn2];
    [_moreTextBtn2 addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initLineView{
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
}

+ (CGFloat)cellDefaultHeight:(TextEntity *)entity
{
    //默认cell高度
//    return 85.0;
    return 90;
}

+ (CGFloat)cellMoreHeight:(TextEntity *)entity
{
    //展开后得高度(计算出文本内容的高度+固定控件的高度)
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [entity.textContent boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30, 100000) options:option attributes:attribute context:nil].size;;
    return size.height + 50;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textTitle.text = self.entity.textName;
    
    _textContent.text = self.entity.textContent;
    if (self.entity.isShowMoreText)
    {
        ///计算文本高度
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
        CGSize size = [self.entity.textContent boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30, 100000) options:option attributes:attribute context:nil].size;
        [_textContent setFrame:CGRectMake(12, 16+15+5, SCREEN_WIDTH - 24, size.height)];
        
        [_moreTextBtn2 setFrame:CGRectMake(SCREEN_WIDTH/2, 16+15+size.height, 15, 15)];
        [_moreTextBtn2 setImage:[UIImage imageNamed:@"info_expert_xiangshang_image"] forState:UIControlStateNormal];
        
        [_moreTextBtn setTitle:@"收起" forState:UIControlStateNormal];
        _moreTextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    else
    {
        [_moreTextBtn setTitle:@"展开" forState:UIControlStateNormal];
        _moreTextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_textContent setFrame:CGRectMake(12, 16+15+5, SCREEN_WIDTH - 24, 35)];
        
        [_moreTextBtn2 setFrame:CGRectMake(SCREEN_WIDTH/2, 16+15+5+20+15, 15, 15)];
    }
    
}

- (void)showMoreText
{
    DLog(@"showMoreText");
    //将当前对象的isShowMoreText属性设为相反值
    self.entity.isShowMoreText = !self.entity.isShowMoreText;
    if (self.showMoreTextBlock)
    {
        self.showMoreTextBlock(self);
    }
}

@end
