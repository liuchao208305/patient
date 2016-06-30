//
//  SelfInspectionOneTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SymtomDelegate <NSObject>

-(void)sendTextFieldValue:(NSString *)string;

@end

@interface SelfInspectionOneTableCell : UITableViewCell

@property (strong,nonatomic)UITextField *textField;

-(void)initViewWithTextField;

@property (weak,nonatomic)id<SymtomDelegate> symtomDelegate;

@end
