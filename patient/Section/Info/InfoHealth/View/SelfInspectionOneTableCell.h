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

@protocol JiwangshiDelegate <NSObject>

-(void)sendTextField1Value:(NSString *)string;

@end

@protocol ShoushushiDelegate <NSObject>

-(void)sendTextField2Value:(NSString *)string;

@end

@protocol GuominshiDelegate <NSObject>

-(void)sendTextField3Value:(NSString *)string;

@end

@protocol JiazushiDelegate <NSObject>

-(void)sendTextField4Value:(NSString *)string;

@end

@protocol YuejingbijingDelegate <NSObject>

-(void)sendYuejingbijingValue:(NSString *)string;

@end

@protocol YuejingqitaDelegate <NSObject>

-(void)sendYuejingqitaValue:(NSString *)string;

@end

@interface SelfInspectionOneTableCell : UITableViewCell

@property (strong,nonatomic)UITextField *textField;

-(void)initViewWithTextField:(NSString *)placeholder;

@property (weak,nonatomic)id<SymtomDelegate> symtomDelegate;

@property (weak,nonatomic)id<JiwangshiDelegate> jiwangshiDelegate;
@property (weak,nonatomic)id<ShoushushiDelegate> shoushushiDelegate;
@property (weak,nonatomic)id<GuominshiDelegate> guominshiDelegate;
@property (weak,nonatomic)id<JiazushiDelegate> jiazushiDelegate;
@property (weak,nonatomic)id<YuejingbijingDelegate> yuejingbijingDelegate;
@property (weak,nonatomic)id<YuejingqitaDelegate> yuejingqitaDelegate;

@end
