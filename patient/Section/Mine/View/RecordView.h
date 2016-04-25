//
//  RecordView.h
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordView : UIView

@property (strong,nonatomic)NSString *recordId;
@property (strong,nonatomic)NSString *recordPatientName;

@property (strong,nonatomic)UIImageView *recordImage;
@property (strong,nonatomic)UILabel *recordName;

@end
