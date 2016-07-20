//
//  BookClinicAddressPopView.h
//  patient
//
//  Created by ChaosLiu on 16/7/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClinicAddressDelegate <NSObject>

-(void)clinicAddressSelected:(NSString *)addressId addressUnit:(NSString *)addressUnit;

@end

@protocol ClinicAddressFixDelegate <NSObject>

-(void)removeClinicAddressPopView;

@end

@interface BookClinicAddressPopView : UIView

@property (strong,nonatomic)UIView *topFixView;
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *bottomFixView;

@property (strong,nonatomic)NSMutableArray *addressIdArray;
@property (strong,nonatomic)NSMutableArray *addressUnitArray;

-(void)initViewWithIdArray:(NSMutableArray *)addressIdArray addressUnitArray:(NSMutableArray *)addressUnitArray;

@property (weak,nonatomic)id<ClinicAddressDelegate> clinicAddressDelegate;
@property (weak,nonatomic)id<ClinicAddressFixDelegate> clinicAddressFixDelegate;

@end
