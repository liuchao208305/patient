//
//  BookInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/5.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "PlaceholderTextView.h"
#import "BookClinicAddressPopView.h"
#import "BookExpertTimePopView.h"

@interface BookInfoViewController : BaseViewController

@property (strong,nonatomic)NSString *expertId;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *expertBackView;
@property (strong,nonatomic)UIImageView *expertImageView;
@property (strong,nonatomic)UILabel *expertNameLabel;
@property (strong,nonatomic)UILabel *expertTitleLabel;
@property (strong,nonatomic)UILabel *expertMoneyLabel;
@property (strong,nonatomic)UILabel *expertIntroductionLabel;

@property (strong,nonatomic)UIView *clinicBackView;
@property (strong,nonatomic)UILabel *clinicAddressLabel;
@property (strong,nonatomic)UIButton *clinicAddressButton;
@property (strong,nonatomic)UIView *clinicLineView;
@property (strong,nonatomic)UILabel *clinicTimeLabel;
@property (strong,nonatomic)UIButton *clinicTimeButton;

@property (strong,nonatomic)UIView *patientBackView;
@property (strong,nonatomic)UILabel *patientNameLabel;
@property (strong,nonatomic)UITextField *patientNameTextField;
@property (strong,nonatomic)UIButton *patientSexButton;
@property (strong,nonatomic)UILabel *patientAgeLabel;
@property (strong,nonatomic)UIView *patientLineView1;
@property (strong,nonatomic)UILabel *patientIdLabel;
@property (strong,nonatomic)UITextField *patientIdTextField;
@property (strong,nonatomic)UIView *patientLineView2;
@property (strong,nonatomic)UILabel *patientPhoneLabel;
@property (strong,nonatomic)UITextField *patientPhoneTextField;

@property (strong,nonatomic)UIView *inquiryBackView;
@property (strong,nonatomic)PlaceholderTextView * inquiryTextView;
@property (strong,nonatomic)UILabel *inquiryCountLabel;
//@property (strong,nonatomic)UITableView *inquiryTableView;
@property (strong,nonatomic)UIImageView *diseaseImageView;
@property (strong,nonatomic)UILabel *jiwangshiLabel1;
@property (strong,nonatomic)UILabel *jiwangshiLabel2;
@property (strong,nonatomic)UILabel *shoushushiLabel1;
@property (strong,nonatomic)UILabel *shoushushiLabel2;
@property (strong,nonatomic)UILabel *guomingshiLabel1;
@property (strong,nonatomic)UILabel *guomingshiLabel2;
@property (strong,nonatomic)UILabel *jiazushiLabel1;
@property (strong,nonatomic)UILabel *jiazushiLabel2;
@property (strong,nonatomic)UILabel *diseaseLabel1;
@property (strong,nonatomic)UILabel *diseaseLabel2;
@property (strong,nonatomic)UIButton *diseaseButton;
@property (strong,nonatomic)UIImageView *healthImageView;
@property (strong,nonatomic)UILabel *healthLabel1;
@property (strong,nonatomic)UILabel *healthLabel2;
@property (strong,nonatomic)UIButton *healthButton;
@property (strong,nonatomic)UIImageView *testImageView;
@property (strong,nonatomic)UILabel *testLabel1;
@property (strong,nonatomic)UILabel *testLabel2;
@property (strong,nonatomic)UIButton *testButton;
@property (strong,nonatomic)UIButton *inquiryAddButton;
@property (strong,nonatomic)UIButton *bookButton;


@property (strong,nonatomic)BookClinicAddressPopView *bookClinicAddressPopView;

@property (strong,nonatomic)NSMutableArray *addressArray;
@property (strong,nonatomic)NSMutableArray *addressIdArray;
@property (strong,nonatomic)NSMutableArray *addressUnitArray;

@property (strong,nonatomic)BookExpertTimePopView *bookExpertTimePopView;

@property (strong,nonatomic)NSMutableArray *timeArray;
@property (strong,nonatomic)NSMutableArray *timeUnformatArray;
@property (strong,nonatomic)NSMutableArray *timeFormatArray;
@property (strong,nonatomic)NSMutableArray *timePeriodArray;
@property (strong,nonatomic)NSMutableArray *timeFullFlagArray;

@end
