//
//  MineRecordTabelCell.h
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordView.h"

@protocol RecordViewDelegate <NSObject>

-(void)recordViewClicked:(NSInteger)tag;

@end

@interface MineRecordTableCell : UITableViewCell

@property (strong,nonatomic)RecordView *recordView;

-(void)initView:(NSInteger)number Withid:(NSMutableArray *)recordIdArray image:(NSMutableArray *)recordImageArray name:(NSMutableArray *)recordNameArray patientName:(NSMutableArray *)recordPatientNameArray;

@property (weak,nonatomic)id<RecordViewDelegate> recordViewDelegate;

@end
