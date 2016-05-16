//
//  StudioExpertTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "StudioExpertTableCell.h"
#import "StudioExpertCollectionCell.h"

@interface StudioExpertTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation StudioExpertTableCell

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
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 340) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:kWHITE_COLOR];
    [self.collectionView registerClass:[StudioExpertCollectionCell class] forCellWithReuseIdentifier:@"StudioExpertCollectionCell"];
    [self.contentView addSubview:self.collectionView];
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName = @"StudioExpertCollectionCell";
    StudioExpertCollectionCell * cell = (StudioExpertCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    //填充数据
//    NSArray *imageArray = [NSArray arrayWithObjects:@"default_image_small", @"default_image_small",@"default_image_small",@"default_image_small",@"default_image_small",@"default_image_small",nil];
//    NSArray *labelArray = [NSArray arrayWithObjects:@"张三疯",@"张三疯",@"张三疯",@"张三疯",@"张三疯",@"张三疯", nil];
//    for (int i = 0; i < 6; i++) {
//        if (indexPath.row == i) {
//            [cell.imageView setImage:[UIImage imageNamed:imageArray[i]]];
//            cell.label1.text = labelArray[i];
//            cell.label2.text = labelArray[i];
//        }
//    }
    
//    NSArray *imageArray = [NSArray arrayWithObjects:@"default_image_small", @"default_image_small",@"default_image_small",@"default_image_small",@"default_image_small",@"default_image_small",@"default_image_small",nil];
//    NSArray *labelArray = [NSArray arrayWithObjects:@"张三疯",@"张三疯",@"张三疯",@"张三疯",@"张三疯",@"张三疯",@"张三疯", nil];
//    for (int i = 0; i < 7; i++) {
//        if (indexPath.row == i) {
//            [cell.imageView setImage:[UIImage imageNamed:imageArray[i]]];
//            cell.label1.text = labelArray[i];
//            cell.label2.text = labelArray[i];
//        }
//    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3, 170);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"%ld",(long)indexPath.row);
    if (indexPath.row == 0) {
        if (self.expertDelegate && [self.expertDelegate respondsToSelector:@selector(expert1Clicked)]) {
            [self.expertDelegate expert1Clicked];
        }
    }else if (indexPath.row == 1){
        if (self.expertDelegate && [self.expertDelegate respondsToSelector:@selector(expert2Clicked)]) {
            [self.expertDelegate expert2Clicked];
        }
    }else if (indexPath.row == 2){
        if (self.expertDelegate && [self.expertDelegate respondsToSelector:@selector(expert3Clicked)]) {
            [self.expertDelegate expert3Clicked];
        }
    }else if (indexPath.row == 3){
        if (self.expertDelegate && [self.expertDelegate respondsToSelector:@selector(expert4Clicked)]) {
            [self.expertDelegate expert4Clicked];
        }
    }else if (indexPath.row == 4){
        if (self.expertDelegate && [self.expertDelegate respondsToSelector:@selector(expert4Clicked)]) {
            [self.expertDelegate expert5Clicked];
        }
    }else if (indexPath.row == 5){
        if (self.expertDelegate && [self.expertDelegate respondsToSelector:@selector(expert5Clicked)]) {
            [self.expertDelegate expert6Clicked];
        }
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

@end
