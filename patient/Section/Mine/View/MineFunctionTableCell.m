//
//  MineFunctionTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineFunctionTableCell.h"
#import "MineFunctionCollectionCell.h"

@interface MineFunctionTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation MineFunctionTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 161) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:kBACKGROUND_COLOR];
    [self.collectionView registerClass:[MineFunctionCollectionCell class] forCellWithReuseIdentifier:@"MineFunctionCollectionCell"];
    [self.contentView addSubview:self.collectionView];
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 8;
    return 6;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName = @"MineFunctionCollectionCell";
    MineFunctionCollectionCell * cell = (MineFunctionCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    //填充数据
//    NSArray *imageArray = [NSArray arrayWithObjects:@"mine_bottom_favorite", @"mine_bottom_useful",@"mine_bottom_doctor",@"mine_bottom_coupon",@"mine_bottom_body",@"mine_bottom_service",@"mine_bottom_leave",@"mine_bottom_contact",nil];
//    NSArray *labelArray = [NSArray arrayWithObjects:@"收藏夹",@"有用",@"我的医生",@"我的优惠券",@"我的体质",@"联系客服",@"例假记录",@"常用联系人", nil];
//    for (int i = 0; i < 8; i++) {
//        if (indexPath.row == i) {
//            [cell.imageView setImage:[UIImage imageNamed:imageArray[i]]];
//            cell.label.text = labelArray[i];
//        }
//    }
//    NSArray *imageArray = [NSArray arrayWithObjects:@"mine_bottom_favorite",@"mine_bottom_doctor",@"mine_bottom_coupon",@"mine_bottom_body",@"mine_bottom_service",@"mine_bottom_contact",nil];
//    NSArray *labelArray = [NSArray arrayWithObjects:@"收藏夹",@"我的专家",@"我的优惠券",@"我的体质",@"联系客服",@"常用联系人", nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"mine_bottom_body_fix",@"mine_bottom_disease_fix",@"mine_bottom_expert_fix",@"mine_bottom_inspection_fix",@"mine_bottom_marriage_fix",@"mine_bottom_wallet_fix",nil];
    NSArray *labelArray = [NSArray arrayWithObjects:@"我的体质",@"我的病史",@"我的医生",@"自查纪录",@"婚育情况",@"我的钱包", nil];
    for (int i = 0; i < 6; i++) {
        if (indexPath.row == i) {
            [cell.imageView setImage:[UIImage imageNamed:imageArray[i]]];
            cell.label.text = labelArray[i];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake((SCREEN_WIDTH-5)/4, 80);
    return CGSizeMake((SCREEN_WIDTH-4)/3, 80);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"%ld",(long)indexPath.row);
    if (indexPath.row == 0) {
        if (self.functionDelegate && [self.functionDelegate respondsToSelector:@selector(function1Clicked)]) {
            [self.functionDelegate function1Clicked];
        }
    }else if (indexPath.row == 1){
        if (self.functionDelegate && [self.functionDelegate respondsToSelector:@selector(function2Clicked)]) {
            [self.functionDelegate function2Clicked];
        }
    }else if (indexPath.row == 2){
        if (self.functionDelegate && [self.functionDelegate respondsToSelector:@selector(function3Clicked)]) {
            [self.functionDelegate function3Clicked];
        }
    }else if (indexPath.row == 3){
        if (self.functionDelegate && [self.functionDelegate respondsToSelector:@selector(function4Clicked)]) {
            [self.functionDelegate function4Clicked];
        }
    }else if (indexPath.row == 4){
        if (self.functionDelegate && [self.functionDelegate respondsToSelector:@selector(function5Clicked)]) {
            [self.functionDelegate function5Clicked];
        }
    }else if (indexPath.row == 5){
        if (self.functionDelegate && [self.functionDelegate respondsToSelector:@selector(function6Clicked)]) {
            [self.functionDelegate function6Clicked];
        }
    }
//    else if (indexPath.row == 6){
//        if (self.functionDelegate && [self.functionDelegate respondsToSelector:@selector(function7Clicked)]) {
//            [self.functionDelegate function7Clicked];
//        }
//    }else if (indexPath.row == 7){
//        if (self.functionDelegate && [self.functionDelegate respondsToSelector:@selector(function8Clicked)]) {
//            [self.functionDelegate function8Clicked];
//        }
//    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

@end
