//
//  RDZhaopianCollectionCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "RDZhaopianCollectionCell.h"

@implementation RDZhaopianCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView.image = [UIImage imageNamed:@"default_image_small"];
        [self addSubview:self.imageView];
    }
    return self;
}

@end
