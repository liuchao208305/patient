//
//  TestFixViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface TestFixViewController : BaseViewController

@property (strong,nonatomic)UIView *topFixedView;
@property (strong,nonatomic)UILabel *presentationLabel1;
@property (strong,nonatomic)UILabel *presentationLabel2;
@property (strong,nonatomic)UILabel *quantityLabel;

@property (strong,nonatomic)UIScrollView *scrollView;
/*====================================================*/
@property (strong,nonatomic)UIView *backView1;
@property (strong,nonatomic)UIView *subTopView1;
@property (strong,nonatomic)UILabel *questionLabel1;
@property (strong,nonatomic)UIView *subLineView1;
@property (strong,nonatomic)UIView *subDownView1;
@property (strong,nonatomic)UIButton *button1_1;
@property (strong,nonatomic)UIButton *button1_2;
@property (strong,nonatomic)UIButton *button1_3;
@property (strong,nonatomic)UIButton *button1_3Fix;
@property (strong,nonatomic)UIButton *button1_4;

@property (assign,nonatomic)BOOL isQuestion1Answered;
@property (assign,nonatomic)BOOL isButton1_1Clicked;
@property (assign,nonatomic)BOOL isButton1_2Clicked;
@property (assign,nonatomic)BOOL isButton1_3Clicked;
@property (assign,nonatomic)BOOL isButton1_3FixClicked;
@property (assign,nonatomic)BOOL isButton1_4Clicked;

@property (strong,nonatomic)NSString *answer1;
/*====================================================*/
@property (strong,nonatomic)UIView *backView2;
@property (strong,nonatomic)UIView *subTopView2;
@property (strong,nonatomic)UILabel *questionLabel2;
@property (strong,nonatomic)UIView *subLineView2;
@property (strong,nonatomic)UIView *subDownView2;
@property (strong,nonatomic)UIButton *button2_1;
@property (strong,nonatomic)UIButton *button2_2;
@property (strong,nonatomic)UIButton *button2_3;
@property (strong,nonatomic)UIButton *button2_3Fix;
@property (strong,nonatomic)UIButton *button2_4;

@property (assign,nonatomic)BOOL isQuestion2Answered;
@property (assign,nonatomic)BOOL isButton2_1Clicked;
@property (assign,nonatomic)BOOL isButton2_2Clicked;
@property (assign,nonatomic)BOOL isButton2_3Clicked;
@property (assign,nonatomic)BOOL isButton2_3FixClicked;
@property (assign,nonatomic)BOOL isButton2_4Clicked;

@property (strong,nonatomic)NSString *answer2;
/*====================================================*/
@property (strong,nonatomic)UIView *backView3;
@property (strong,nonatomic)UIView *subTopView3;
@property (strong,nonatomic)UILabel *questionLabel3;
@property (strong,nonatomic)UIView *subLineView3;
@property (strong,nonatomic)UIView *subDownView3;
@property (strong,nonatomic)UIButton *button3_1;
@property (strong,nonatomic)UIButton *button3_2;
@property (strong,nonatomic)UIButton *button3_3;
@property (strong,nonatomic)UIButton *button3_3Fix;
@property (strong,nonatomic)UIButton *button3_4;

@property (assign,nonatomic)BOOL isQuestion3Answered;
@property (assign,nonatomic)BOOL isButton3_1Clicked;
@property (assign,nonatomic)BOOL isButton3_2Clicked;
@property (assign,nonatomic)BOOL isButton3_3Clicked;
@property (assign,nonatomic)BOOL isButton3_3FixClicked;
@property (assign,nonatomic)BOOL isButton3_4Clicked;

@property (strong,nonatomic)NSString *answer3;
/*====================================================*/
@property (strong,nonatomic)UIView *backView4;
@property (strong,nonatomic)UIView *subTopView4;
@property (strong,nonatomic)UILabel *questionLabel4;
@property (strong,nonatomic)UIView *subLineView4;
@property (strong,nonatomic)UIView *subDownView4;
@property (strong,nonatomic)UIButton *button4_1;
@property (strong,nonatomic)UIButton *button4_2;
@property (strong,nonatomic)UIButton *button4_3;
@property (strong,nonatomic)UIButton *button4_3Fix;
@property (strong,nonatomic)UIButton *button4_4;

@property (assign,nonatomic)BOOL isQuestion4Answered;
@property (assign,nonatomic)BOOL isButton4_1Clicked;
@property (assign,nonatomic)BOOL isButton4_2Clicked;
@property (assign,nonatomic)BOOL isButton4_3Clicked;
@property (assign,nonatomic)BOOL isButton4_3FixClicked;
@property (assign,nonatomic)BOOL isButton4_4Clicked;

@property (strong,nonatomic)NSString *answer4;
/*====================================================*/
@property (strong,nonatomic)UIView *backView5;
@property (strong,nonatomic)UIView *subTopView5;
@property (strong,nonatomic)UILabel *questionLabel5;
@property (strong,nonatomic)UIView *subLineView5;
@property (strong,nonatomic)UIView *subDownView5;
@property (strong,nonatomic)UIButton *button5_1;
@property (strong,nonatomic)UIButton *button5_2;
@property (strong,nonatomic)UIButton *button5_3;
@property (strong,nonatomic)UIButton *button5_3Fix;
@property (strong,nonatomic)UIButton *button5_4;

@property (assign,nonatomic)BOOL isQuestion5Answered;
@property (assign,nonatomic)BOOL isButton5_1Clicked;
@property (assign,nonatomic)BOOL isButton5_2Clicked;
@property (assign,nonatomic)BOOL isButton5_3Clicked;
@property (assign,nonatomic)BOOL isButton5_3FixClicked;
@property (assign,nonatomic)BOOL isButton5_4Clicked;

@property (strong,nonatomic)NSString *answer5;
/*====================================================*/
@property (strong,nonatomic)UIView *backView6;
@property (strong,nonatomic)UIView *subTopView6;
@property (strong,nonatomic)UILabel *questionLabel6;
@property (strong,nonatomic)UIView *subLineView6;
@property (strong,nonatomic)UIView *subDownView6;
@property (strong,nonatomic)UIButton *button6_1;
@property (strong,nonatomic)UIButton *button6_2;
@property (strong,nonatomic)UIButton *button6_3;
@property (strong,nonatomic)UIButton *button6_3Fix;
@property (strong,nonatomic)UIButton *button6_4;

@property (assign,nonatomic)BOOL isQuestion6Answered;
@property (assign,nonatomic)BOOL isButton6_1Clicked;
@property (assign,nonatomic)BOOL isButton6_2Clicked;
@property (assign,nonatomic)BOOL isButton6_3Clicked;
@property (assign,nonatomic)BOOL isButton6_3FixClicked;
@property (assign,nonatomic)BOOL isButton6_4Clicked;

@property (strong,nonatomic)NSString *answer6;
/*====================================================*/
@property (strong,nonatomic)UIView *backView7;
@property (strong,nonatomic)UIView *subTopView7;
@property (strong,nonatomic)UILabel *questionLabel7;
@property (strong,nonatomic)UIView *subLineView7;
@property (strong,nonatomic)UIView *subDownView7;
@property (strong,nonatomic)UIButton *button7_1;
@property (strong,nonatomic)UIButton *button7_2;
@property (strong,nonatomic)UIButton *button7_3;
@property (strong,nonatomic)UIButton *button7_3Fix;
@property (strong,nonatomic)UIButton *button7_4;

@property (assign,nonatomic)BOOL isQuestion7Answered;
@property (assign,nonatomic)BOOL isButton7_1Clicked;
@property (assign,nonatomic)BOOL isButton7_2Clicked;
@property (assign,nonatomic)BOOL isButton7_3Clicked;
@property (assign,nonatomic)BOOL isButton7_3FixClicked;
@property (assign,nonatomic)BOOL isButton7_4Clicked;

@property (strong,nonatomic)NSString *answer7;
/*====================================================*/
@property (strong,nonatomic)UIView *backView8;
@property (strong,nonatomic)UIView *subTopView8;
@property (strong,nonatomic)UILabel *questionLabel8;
@property (strong,nonatomic)UIView *subLineView8;
@property (strong,nonatomic)UIView *subDownView8;
@property (strong,nonatomic)UIButton *button8_1;
@property (strong,nonatomic)UIButton *button8_2;
@property (strong,nonatomic)UIButton *button8_3;
@property (strong,nonatomic)UIButton *button8_3Fix;
@property (strong,nonatomic)UIButton *button8_4;

@property (assign,nonatomic)BOOL isQuestion8Answered;
@property (assign,nonatomic)BOOL isButton8_1Clicked;
@property (assign,nonatomic)BOOL isButton8_2Clicked;
@property (assign,nonatomic)BOOL isButton8_3Clicked;
@property (assign,nonatomic)BOOL isButton8_3FixClicked;
@property (assign,nonatomic)BOOL isButton8_4Clicked;

@property (strong,nonatomic)NSString *answer8;
/*====================================================*/
@property (strong,nonatomic)UIView *backView9;
@property (strong,nonatomic)UIView *subTopView9;
@property (strong,nonatomic)UILabel *questionLabel9;
@property (strong,nonatomic)UIView *subLineView9;
@property (strong,nonatomic)UIView *subDownView9;
@property (strong,nonatomic)UIButton *button9_1;
@property (strong,nonatomic)UIButton *button9_2;
@property (strong,nonatomic)UIButton *button9_3;
@property (strong,nonatomic)UIButton *button9_3Fix;
@property (strong,nonatomic)UIButton *button9_4;

@property (assign,nonatomic)BOOL isQuestion9Answered;
@property (assign,nonatomic)BOOL isButton9_1Clicked;
@property (assign,nonatomic)BOOL isButton9_2Clicked;
@property (assign,nonatomic)BOOL isButton9_3Clicked;
@property (assign,nonatomic)BOOL isButton9_3FixClicked;
@property (assign,nonatomic)BOOL isButton9_4Clicked;

@property (strong,nonatomic)NSString *answer9;
/*====================================================*/
@property (strong,nonatomic)UIView *backView10;
@property (strong,nonatomic)UIView *subTopView10;
@property (strong,nonatomic)UILabel *questionLabel10;
@property (strong,nonatomic)UIView *subLineView10;
@property (strong,nonatomic)UIView *subDownView10;
@property (strong,nonatomic)UIButton *button10_1;
@property (strong,nonatomic)UIButton *button10_2;
@property (strong,nonatomic)UIButton *button10_3;
@property (strong,nonatomic)UIButton *button10_3Fix;
@property (strong,nonatomic)UIButton *button10_4;

@property (assign,nonatomic)BOOL isQuestion10Answered;
@property (assign,nonatomic)BOOL isButton10_1Clicked;
@property (assign,nonatomic)BOOL isButton10_2Clicked;
@property (assign,nonatomic)BOOL isButton10_3Clicked;
@property (assign,nonatomic)BOOL isButton10_3FixClicked;
@property (assign,nonatomic)BOOL isButton10_4Clicked;

@property (strong,nonatomic)NSString *answer10;
/*====================================================*/
@property (strong,nonatomic)UIView *backView11;
@property (strong,nonatomic)UIView *subTopView11;
@property (strong,nonatomic)UILabel *questionLabel11;
@property (strong,nonatomic)UIView *subLineView11;
@property (strong,nonatomic)UIView *subDownView11;
@property (strong,nonatomic)UIButton *button11_1;
@property (strong,nonatomic)UIButton *button11_2;
@property (strong,nonatomic)UIButton *button11_3;
@property (strong,nonatomic)UIButton *button11_3Fix;
@property (strong,nonatomic)UIButton *button11_4;

@property (assign,nonatomic)BOOL isQuestion11Answered;
@property (assign,nonatomic)BOOL isButton11_1Clicked;
@property (assign,nonatomic)BOOL isButton11_2Clicked;
@property (assign,nonatomic)BOOL isButton11_3Clicked;
@property (assign,nonatomic)BOOL isButton11_3FixClicked;
@property (assign,nonatomic)BOOL isButton11_4Clicked;

@property (strong,nonatomic)NSString *answer11;
/*====================================================*/
@property (strong,nonatomic)UIView *backView12;
@property (strong,nonatomic)UIView *subTopView12;
@property (strong,nonatomic)UILabel *questionLabel12;
@property (strong,nonatomic)UIView *subLineView12;
@property (strong,nonatomic)UIView *subDownView12;
@property (strong,nonatomic)UIButton *button12_1;
@property (strong,nonatomic)UIButton *button12_2;
@property (strong,nonatomic)UIButton *button12_3;
@property (strong,nonatomic)UIButton *button12_3Fix;
@property (strong,nonatomic)UIButton *button12_4;

@property (assign,nonatomic)BOOL isQuestion12Answered;
@property (assign,nonatomic)BOOL isButton12_1Clicked;
@property (assign,nonatomic)BOOL isButton12_2Clicked;
@property (assign,nonatomic)BOOL isButton12_3Clicked;
@property (assign,nonatomic)BOOL isButton12_3FixClicked;
@property (assign,nonatomic)BOOL isButton12_4Clicked;

@property (strong,nonatomic)NSString *answer12;
/*====================================================*/
@property (strong,nonatomic)UIView *backView13;
@property (strong,nonatomic)UIView *subTopView13;
@property (strong,nonatomic)UILabel *questionLabel13;
@property (strong,nonatomic)UIView *subLineView13;
@property (strong,nonatomic)UIView *subDownView13;
@property (strong,nonatomic)UIButton *button13_1;
@property (strong,nonatomic)UIButton *button13_2;
@property (strong,nonatomic)UIButton *button13_3;
@property (strong,nonatomic)UIButton *button13_3Fix;
@property (strong,nonatomic)UIButton *button13_4;

@property (assign,nonatomic)BOOL isQuestion13Answered;
@property (assign,nonatomic)BOOL isButton13_1Clicked;
@property (assign,nonatomic)BOOL isButton13_2Clicked;
@property (assign,nonatomic)BOOL isButton13_3Clicked;
@property (assign,nonatomic)BOOL isButton13_3FixClicked;
@property (assign,nonatomic)BOOL isButton13_4Clicked;

@property (strong,nonatomic)NSString *answer13;
/*====================================================*/
@property (strong,nonatomic)UIView *backView14;
@property (strong,nonatomic)UIView *subTopView14;
@property (strong,nonatomic)UILabel *questionLabel14;
@property (strong,nonatomic)UIView *subLineView14;
@property (strong,nonatomic)UIView *subDownView14;
@property (strong,nonatomic)UIButton *button14_1;
@property (strong,nonatomic)UIButton *button14_2;
@property (strong,nonatomic)UIButton *button14_3;
@property (strong,nonatomic)UIButton *button14_3Fix;
@property (strong,nonatomic)UIButton *button14_4;

@property (assign,nonatomic)BOOL isQuestion14Answered;
@property (assign,nonatomic)BOOL isButton14_1Clicked;
@property (assign,nonatomic)BOOL isButton14_2Clicked;
@property (assign,nonatomic)BOOL isButton14_3Clicked;
@property (assign,nonatomic)BOOL isButton14_3FixClicked;
@property (assign,nonatomic)BOOL isButton14_4Clicked;

@property (strong,nonatomic)NSString *answer14;
/*====================================================*/
@property (strong,nonatomic)UIView *backView15;
@property (strong,nonatomic)UIView *subTopView15;
@property (strong,nonatomic)UILabel *questionLabel15;
@property (strong,nonatomic)UIView *subLineView15;
@property (strong,nonatomic)UIView *subDownView15;
@property (strong,nonatomic)UIButton *button15_1;
@property (strong,nonatomic)UIButton *button15_2;
@property (strong,nonatomic)UIButton *button15_3;
@property (strong,nonatomic)UIButton *button15_3Fix;
@property (strong,nonatomic)UIButton *button15_4;

@property (assign,nonatomic)BOOL isQuestion15Answered;
@property (assign,nonatomic)BOOL isButton15_1Clicked;
@property (assign,nonatomic)BOOL isButton15_2Clicked;
@property (assign,nonatomic)BOOL isButton15_3Clicked;
@property (assign,nonatomic)BOOL isButton15_3FixClicked;
@property (assign,nonatomic)BOOL isButton15_4Clicked;

@property (strong,nonatomic)NSString *answer15;
/*====================================================*/
@property (strong,nonatomic)UIView *backView16;
@property (strong,nonatomic)UIView *subTopView16;
@property (strong,nonatomic)UILabel *questionLabel16;
@property (strong,nonatomic)UIView *subLineView16;
@property (strong,nonatomic)UIView *subDownView16;
@property (strong,nonatomic)UIButton *button16_1;
@property (strong,nonatomic)UIButton *button16_2;
@property (strong,nonatomic)UIButton *button16_3;
@property (strong,nonatomic)UIButton *button16_3Fix;
@property (strong,nonatomic)UIButton *button16_4;

@property (assign,nonatomic)BOOL isQuestion16Answered;
@property (assign,nonatomic)BOOL isButton16_1Clicked;
@property (assign,nonatomic)BOOL isButton16_2Clicked;
@property (assign,nonatomic)BOOL isButton16_3Clicked;
@property (assign,nonatomic)BOOL isButton16_3FixClicked;
@property (assign,nonatomic)BOOL isButton16_4Clicked;

@property (strong,nonatomic)NSString *answer16;
/*====================================================*/
@property (strong,nonatomic)UIView *backView17;
@property (strong,nonatomic)UIView *subTopView17;
@property (strong,nonatomic)UILabel *questionLabel17;
@property (strong,nonatomic)UIView *subLineView17;
@property (strong,nonatomic)UIView *subDownView17;
@property (strong,nonatomic)UIButton *button17_1;
@property (strong,nonatomic)UIButton *button17_2;
@property (strong,nonatomic)UIButton *button17_3;
@property (strong,nonatomic)UIButton *button17_3Fix;
@property (strong,nonatomic)UIButton *button17_4;

@property (assign,nonatomic)BOOL isQuestion17Answered;
@property (assign,nonatomic)BOOL isButton17_1Clicked;
@property (assign,nonatomic)BOOL isButton17_2Clicked;
@property (assign,nonatomic)BOOL isButton17_3Clicked;
@property (assign,nonatomic)BOOL isButton17_3FixClicked;
@property (assign,nonatomic)BOOL isButton17_4Clicked;

@property (strong,nonatomic)NSString *answer17;
/*====================================================*/
@property (strong,nonatomic)UIView *backView18;
@property (strong,nonatomic)UIView *subTopView18;
@property (strong,nonatomic)UILabel *questionLabel18;
@property (strong,nonatomic)UIView *subLineView18;
@property (strong,nonatomic)UIView *subDownView18;
@property (strong,nonatomic)UIButton *button18_1;
@property (strong,nonatomic)UIButton *button18_2;
@property (strong,nonatomic)UIButton *button18_3;
@property (strong,nonatomic)UIButton *button18_3Fix;
@property (strong,nonatomic)UIButton *button18_4;

@property (assign,nonatomic)BOOL isQuestion18Answered;
@property (assign,nonatomic)BOOL isButton18_1Clicked;
@property (assign,nonatomic)BOOL isButton18_2Clicked;
@property (assign,nonatomic)BOOL isButton18_3Clicked;
@property (assign,nonatomic)BOOL isButton18_3FixClicked;
@property (assign,nonatomic)BOOL isButton18_4Clicked;

@property (strong,nonatomic)NSString *answer18;
/*====================================================*/
@property (strong,nonatomic)UIView *backView19;
@property (strong,nonatomic)UIView *subTopView19;
@property (strong,nonatomic)UILabel *questionLabel19;
@property (strong,nonatomic)UIView *subLineView19;
@property (strong,nonatomic)UIView *subDownView19;
@property (strong,nonatomic)UIButton *button19_1;
@property (strong,nonatomic)UIButton *button19_2;
@property (strong,nonatomic)UIButton *button19_3;
@property (strong,nonatomic)UIButton *button19_3Fix;
@property (strong,nonatomic)UIButton *button19_4;

@property (assign,nonatomic)BOOL isQuestion19Answered;
@property (assign,nonatomic)BOOL isButton19_1Clicked;
@property (assign,nonatomic)BOOL isButton19_2Clicked;
@property (assign,nonatomic)BOOL isButton19_3Clicked;
@property (assign,nonatomic)BOOL isButton19_3FixClicked;
@property (assign,nonatomic)BOOL isButton19_4Clicked;

@property (strong,nonatomic)NSString *answer19;
/*====================================================*/
@property (strong,nonatomic)UIView *backView20;
@property (strong,nonatomic)UIView *subTopView20;
@property (strong,nonatomic)UILabel *questionLabel20;
@property (strong,nonatomic)UIView *subLineView20;
@property (strong,nonatomic)UIView *subDownView20;
@property (strong,nonatomic)UIButton *button20_1;
@property (strong,nonatomic)UIButton *button20_2;
@property (strong,nonatomic)UIButton *button20_3;
@property (strong,nonatomic)UIButton *button20_3Fix;
@property (strong,nonatomic)UIButton *button20_4;

@property (assign,nonatomic)BOOL isQuestion20Answered;
@property (assign,nonatomic)BOOL isButton20_1Clicked;
@property (assign,nonatomic)BOOL isButton20_2Clicked;
@property (assign,nonatomic)BOOL isButton20_3Clicked;
@property (assign,nonatomic)BOOL isButton20_3FixClicked;
@property (assign,nonatomic)BOOL isButton20_4Clicked;

@property (strong,nonatomic)NSString *answer20;
/*====================================================*/
@property (strong,nonatomic)UIView *backView21;
@property (strong,nonatomic)UIView *subTopView21;
@property (strong,nonatomic)UILabel *questionLabel21;
@property (strong,nonatomic)UIView *subLineView21;
@property (strong,nonatomic)UIView *subDownView21;
@property (strong,nonatomic)UIButton *button21_1;
@property (strong,nonatomic)UIButton *button21_2;
@property (strong,nonatomic)UIButton *button21_3;
@property (strong,nonatomic)UIButton *button21_3Fix;
@property (strong,nonatomic)UIButton *button21_4;

@property (assign,nonatomic)BOOL isQuestion21Answered;
@property (assign,nonatomic)BOOL isButton21_1Clicked;
@property (assign,nonatomic)BOOL isButton21_2Clicked;
@property (assign,nonatomic)BOOL isButton21_3Clicked;
@property (assign,nonatomic)BOOL isButton21_3FixClicked;
@property (assign,nonatomic)BOOL isButton21_4Clicked;

@property (strong,nonatomic)NSString *answer21;
/*====================================================*/
@property (strong,nonatomic)UIView *backView22;
@property (strong,nonatomic)UIView *subTopView22;
@property (strong,nonatomic)UILabel *questionLabel22;
@property (strong,nonatomic)UIView *subLineView22;
@property (strong,nonatomic)UIView *subDownView22;
@property (strong,nonatomic)UIButton *button22_1;
@property (strong,nonatomic)UIButton *button22_2;
@property (strong,nonatomic)UIButton *button22_3;
@property (strong,nonatomic)UIButton *button22_3Fix;
@property (strong,nonatomic)UIButton *button22_4;

@property (assign,nonatomic)BOOL isQuestion22Answered;
@property (assign,nonatomic)BOOL isButton22_1Clicked;
@property (assign,nonatomic)BOOL isButton22_2Clicked;
@property (assign,nonatomic)BOOL isButton22_3Clicked;
@property (assign,nonatomic)BOOL isButton22_3FixClicked;
@property (assign,nonatomic)BOOL isButton22_4Clicked;

@property (strong,nonatomic)NSString *answer22;
/*====================================================*/
@property (strong,nonatomic)UIView *backView23;
@property (strong,nonatomic)UIView *subTopView23;
@property (strong,nonatomic)UILabel *questionLabel23;
@property (strong,nonatomic)UIView *subLineView23;
@property (strong,nonatomic)UIView *subDownView23;
@property (strong,nonatomic)UIButton *button23_1;
@property (strong,nonatomic)UIButton *button23_2;
@property (strong,nonatomic)UIButton *button23_3;
@property (strong,nonatomic)UIButton *button23_3Fix;
@property (strong,nonatomic)UIButton *button23_4;

@property (assign,nonatomic)BOOL isQuestion23Answered;
@property (assign,nonatomic)BOOL isButton23_1Clicked;
@property (assign,nonatomic)BOOL isButton23_2Clicked;
@property (assign,nonatomic)BOOL isButton23_3Clicked;
@property (assign,nonatomic)BOOL isButton23_3FixClicked;
@property (assign,nonatomic)BOOL isButton23_4Clicked;

@property (strong,nonatomic)NSString *answer23;
/*====================================================*/
@property (strong,nonatomic)UIView *backView24;
@property (strong,nonatomic)UIView *subTopView24;
@property (strong,nonatomic)UILabel *questionLabel24;
@property (strong,nonatomic)UIView *subLineView24;
@property (strong,nonatomic)UIView *subDownView24;
@property (strong,nonatomic)UIButton *button24_1;
@property (strong,nonatomic)UIButton *button24_2;
@property (strong,nonatomic)UIButton *button24_3;
@property (strong,nonatomic)UIButton *button24_3Fix;
@property (strong,nonatomic)UIButton *button24_4;

@property (assign,nonatomic)BOOL isQuestion24Answered;
@property (assign,nonatomic)BOOL isButton24_1Clicked;
@property (assign,nonatomic)BOOL isButton24_2Clicked;
@property (assign,nonatomic)BOOL isButton24_3Clicked;
@property (assign,nonatomic)BOOL isButton24_3FixClicked;
@property (assign,nonatomic)BOOL isButton24_4Clicked;

@property (strong,nonatomic)NSString *answer24;
/*====================================================*/
@property (strong,nonatomic)UIView *backView25;
@property (strong,nonatomic)UIView *subTopView25;
@property (strong,nonatomic)UILabel *questionLabel25;
@property (strong,nonatomic)UIView *subLineView25;
@property (strong,nonatomic)UIView *subDownView25;
@property (strong,nonatomic)UIButton *button25_1;
@property (strong,nonatomic)UIButton *button25_2;
@property (strong,nonatomic)UIButton *button25_3;
@property (strong,nonatomic)UIButton *button25_3Fix;
@property (strong,nonatomic)UIButton *button25_4;

@property (assign,nonatomic)BOOL isQuestion25Answered;
@property (assign,nonatomic)BOOL isButton25_1Clicked;
@property (assign,nonatomic)BOOL isButton25_2Clicked;
@property (assign,nonatomic)BOOL isButton25_3Clicked;
@property (assign,nonatomic)BOOL isButton25_3FixClicked;
@property (assign,nonatomic)BOOL isButton25_4Clicked;

@property (strong,nonatomic)NSString *answer25;
/*====================================================*/
@property (strong,nonatomic)UIView *backView26;
@property (strong,nonatomic)UIView *subTopView26;
@property (strong,nonatomic)UILabel *questionLabel26;
@property (strong,nonatomic)UIView *subLineView26;
@property (strong,nonatomic)UIView *subDownView26;
@property (strong,nonatomic)UIButton *button26_1;
@property (strong,nonatomic)UIButton *button26_2;
@property (strong,nonatomic)UIButton *button26_3;
@property (strong,nonatomic)UIButton *button26_3Fix;
@property (strong,nonatomic)UIButton *button26_4;

@property (assign,nonatomic)BOOL isQuestion26Answered;
@property (assign,nonatomic)BOOL isButton26_1Clicked;
@property (assign,nonatomic)BOOL isButton26_2Clicked;
@property (assign,nonatomic)BOOL isButton26_3Clicked;
@property (assign,nonatomic)BOOL isButton26_3FixClicked;
@property (assign,nonatomic)BOOL isButton26_4Clicked;

@property (strong,nonatomic)NSString *answer26;
/*====================================================*/
@property (strong,nonatomic)UIView *backView27;
@property (strong,nonatomic)UIView *subTopView27;
@property (strong,nonatomic)UILabel *questionLabel27;
@property (strong,nonatomic)UIView *subLineView27;
@property (strong,nonatomic)UIView *subDownView27;
@property (strong,nonatomic)UIButton *button27_1;
@property (strong,nonatomic)UIButton *button27_2;
@property (strong,nonatomic)UIButton *button27_3;
@property (strong,nonatomic)UIButton *button27_3Fix;
@property (strong,nonatomic)UIButton *button27_4;

@property (assign,nonatomic)BOOL isQuestion27Answered;
@property (assign,nonatomic)BOOL isButton27_1Clicked;
@property (assign,nonatomic)BOOL isButton27_2Clicked;
@property (assign,nonatomic)BOOL isButton27_3Clicked;
@property (assign,nonatomic)BOOL isButton27_3FixClicked;
@property (assign,nonatomic)BOOL isButton27_4Clicked;

@property (strong,nonatomic)NSString *answer27;
/*====================================================*/
@property (strong,nonatomic)UIView *backView28;
@property (strong,nonatomic)UIView *subTopView28;
@property (strong,nonatomic)UILabel *questionLabel28;
@property (strong,nonatomic)UIView *subLineView28;
@property (strong,nonatomic)UIView *subDownView28;
@property (strong,nonatomic)UIButton *button28_1;
@property (strong,nonatomic)UIButton *button28_2;
@property (strong,nonatomic)UIButton *button28_3;
@property (strong,nonatomic)UIButton *button28_3Fix;
@property (strong,nonatomic)UIButton *button28_4;

@property (assign,nonatomic)BOOL isQuestion28Answered;
@property (assign,nonatomic)BOOL isButton28_1Clicked;
@property (assign,nonatomic)BOOL isButton28_2Clicked;
@property (assign,nonatomic)BOOL isButton28_3Clicked;
@property (assign,nonatomic)BOOL isButton28_3FixClicked;
@property (assign,nonatomic)BOOL isButton28_4Clicked;

@property (strong,nonatomic)NSString *answer28;
/*====================================================*/
@property (strong,nonatomic)UIView *backView29;
@property (strong,nonatomic)UIView *subTopView29;
@property (strong,nonatomic)UILabel *questionLabel29;
@property (strong,nonatomic)UIView *subLineView29;
@property (strong,nonatomic)UIView *subDownView29;
@property (strong,nonatomic)UIButton *button29_1;
@property (strong,nonatomic)UIButton *button29_2;
@property (strong,nonatomic)UIButton *button29_3;
@property (strong,nonatomic)UIButton *button29_3Fix;
@property (strong,nonatomic)UIButton *button29_4;

@property (assign,nonatomic)BOOL isQuestion29Answered;
@property (assign,nonatomic)BOOL isButton29_1Clicked;
@property (assign,nonatomic)BOOL isButton29_2Clicked;
@property (assign,nonatomic)BOOL isButton29_3Clicked;
@property (assign,nonatomic)BOOL isButton29_3FixClicked;
@property (assign,nonatomic)BOOL isButton29_4Clicked;

@property (strong,nonatomic)NSString *answer29;
/*====================================================*/
@property (strong,nonatomic)UIView *backView30;
@property (strong,nonatomic)UIView *subTopView30;
@property (strong,nonatomic)UILabel *questionLabel30;
@property (strong,nonatomic)UIView *subLineView30;
@property (strong,nonatomic)UIView *subDownView30;
@property (strong,nonatomic)UIButton *button30_1;
@property (strong,nonatomic)UIButton *button30_2;
@property (strong,nonatomic)UIButton *button30_3;
@property (strong,nonatomic)UIButton *button30_3Fix;
@property (strong,nonatomic)UIButton *button30_4;

@property (assign,nonatomic)BOOL isQuestion30Answered;
@property (assign,nonatomic)BOOL isButton30_1Clicked;
@property (assign,nonatomic)BOOL isButton30_2Clicked;
@property (assign,nonatomic)BOOL isButton30_3Clicked;
@property (assign,nonatomic)BOOL isButton30_3FixClicked;
@property (assign,nonatomic)BOOL isButton30_4Clicked;

@property (strong,nonatomic)NSString *answer30;
/*====================================================*/
@property (strong,nonatomic)UIView *backView31;
@property (strong,nonatomic)UIView *subTopView31;
@property (strong,nonatomic)UILabel *questionLabel31;
@property (strong,nonatomic)UIView *subLineView31;
@property (strong,nonatomic)UIView *subDownView31;
@property (strong,nonatomic)UIButton *button31_1;
@property (strong,nonatomic)UIButton *button31_2;
@property (strong,nonatomic)UIButton *button31_3;
@property (strong,nonatomic)UIButton *button31_3Fix;
@property (strong,nonatomic)UIButton *button31_4;

@property (assign,nonatomic)BOOL isQuestion31Answered;
@property (assign,nonatomic)BOOL isButton31_1Clicked;
@property (assign,nonatomic)BOOL isButton31_2Clicked;
@property (assign,nonatomic)BOOL isButton31_3Clicked;
@property (assign,nonatomic)BOOL isButton31_3FixClicked;
@property (assign,nonatomic)BOOL isButton31_4Clicked;

@property (strong,nonatomic)NSString *answer31;
/*====================================================*/
@property (strong,nonatomic)UIView *backView32;
@property (strong,nonatomic)UIView *subTopView32;
@property (strong,nonatomic)UILabel *questionLabel32;
@property (strong,nonatomic)UIView *subLineView32;
@property (strong,nonatomic)UIView *subDownView32;
@property (strong,nonatomic)UIButton *button32_1;
@property (strong,nonatomic)UIButton *button32_2;
@property (strong,nonatomic)UIButton *button32_3;
@property (strong,nonatomic)UIButton *button32_3Fix;
@property (strong,nonatomic)UIButton *button32_4;

@property (assign,nonatomic)BOOL isQuestion32Answered;
@property (assign,nonatomic)BOOL isButton32_1Clicked;
@property (assign,nonatomic)BOOL isButton32_2Clicked;
@property (assign,nonatomic)BOOL isButton32_3Clicked;
@property (assign,nonatomic)BOOL isButton32_3FixClicked;
@property (assign,nonatomic)BOOL isButton32_4Clicked;

@property (strong,nonatomic)NSString *answer32;
/*====================================================*/
@property (strong,nonatomic)UIView *backView33;
@property (strong,nonatomic)UIView *subTopView33;
@property (strong,nonatomic)UILabel *questionLabel33;
@property (strong,nonatomic)UIView *subLineView33;
@property (strong,nonatomic)UIView *subDownView33;
@property (strong,nonatomic)UIButton *button33_1;
@property (strong,nonatomic)UIButton *button33_2;
@property (strong,nonatomic)UIButton *button33_3;
@property (strong,nonatomic)UIButton *button33_3Fix;
@property (strong,nonatomic)UIButton *button33_4;

@property (assign,nonatomic)BOOL isQuestion33Answered;
@property (assign,nonatomic)BOOL isButton33_1Clicked;
@property (assign,nonatomic)BOOL isButton33_2Clicked;
@property (assign,nonatomic)BOOL isButton33_3Clicked;
@property (assign,nonatomic)BOOL isButton33_3FixClicked;
@property (assign,nonatomic)BOOL isButton33_4Clicked;

@property (strong,nonatomic)NSString *answer33;
/*====================================================*/
@property (strong,nonatomic)UIView *backView34;
@property (strong,nonatomic)UIView *subTopView34;
@property (strong,nonatomic)UILabel *questionLabel34;
@property (strong,nonatomic)UIView *subLineView34;
@property (strong,nonatomic)UIView *subDownView34;
@property (strong,nonatomic)UIButton *button34_1;
@property (strong,nonatomic)UIButton *button34_2;
@property (strong,nonatomic)UIButton *button34_3;
@property (strong,nonatomic)UIButton *button34_3Fix;
@property (strong,nonatomic)UIButton *button34_4;

@property (assign,nonatomic)BOOL isQuestion34Answered;
@property (assign,nonatomic)BOOL isButton34_1Clicked;
@property (assign,nonatomic)BOOL isButton34_2Clicked;
@property (assign,nonatomic)BOOL isButton34_3Clicked;
@property (assign,nonatomic)BOOL isButton34_3FixClicked;
@property (assign,nonatomic)BOOL isButton34_4Clicked;

@property (strong,nonatomic)NSString *answer34;
/*====================================================*/
@property (strong,nonatomic)UIView *backView35;
@property (strong,nonatomic)UIView *subTopView35;
@property (strong,nonatomic)UILabel *questionLabel35;
@property (strong,nonatomic)UIView *subLineView35;
@property (strong,nonatomic)UIView *subDownView35;
@property (strong,nonatomic)UIButton *button35_1;
@property (strong,nonatomic)UIButton *button35_2;
@property (strong,nonatomic)UIButton *button35_3;
@property (strong,nonatomic)UIButton *button35_3Fix;
@property (strong,nonatomic)UIButton *button35_4;

@property (assign,nonatomic)BOOL isQuestion35Answered;
@property (assign,nonatomic)BOOL isButton35_1Clicked;
@property (assign,nonatomic)BOOL isButton35_2Clicked;
@property (assign,nonatomic)BOOL isButton35_3Clicked;
@property (assign,nonatomic)BOOL isButton35_3FixClicked;
@property (assign,nonatomic)BOOL isButton35_4Clicked;

@property (strong,nonatomic)NSString *answer35;
/*====================================================*/
@property (strong,nonatomic)UIView *backView36;
@property (strong,nonatomic)UIView *subTopView36;
@property (strong,nonatomic)UILabel *questionLabel36;
@property (strong,nonatomic)UIView *subLineView36;
@property (strong,nonatomic)UIView *subDownView36;
@property (strong,nonatomic)UIButton *button36_1;
@property (strong,nonatomic)UIButton *button36_2;
@property (strong,nonatomic)UIButton *button36_3;
@property (strong,nonatomic)UIButton *button36_3Fix;
@property (strong,nonatomic)UIButton *button36_4;

@property (assign,nonatomic)BOOL isQuestion36Answered;
@property (assign,nonatomic)BOOL isButton36_1Clicked;
@property (assign,nonatomic)BOOL isButton36_2Clicked;
@property (assign,nonatomic)BOOL isButton36_3Clicked;
@property (assign,nonatomic)BOOL isButton36_3FixClicked;
@property (assign,nonatomic)BOOL isButton36_4Clicked;

@property (strong,nonatomic)NSString *answer36;
/*====================================================*/
@property (strong,nonatomic)UIView *backView37;
@property (strong,nonatomic)UIView *subTopView37;
@property (strong,nonatomic)UILabel *questionLabel37;
@property (strong,nonatomic)UIView *subLineView37;
@property (strong,nonatomic)UIView *subDownView37;
@property (strong,nonatomic)UIButton *button37_1;
@property (strong,nonatomic)UIButton *button37_2;
@property (strong,nonatomic)UIButton *button37_3;
@property (strong,nonatomic)UIButton *button37_3Fix;
@property (strong,nonatomic)UIButton *button37_4;

@property (assign,nonatomic)BOOL isQuestion37Answered;
@property (assign,nonatomic)BOOL isButton37_1Clicked;
@property (assign,nonatomic)BOOL isButton37_2Clicked;
@property (assign,nonatomic)BOOL isButton37_3Clicked;
@property (assign,nonatomic)BOOL isButton37_3FixClicked;
@property (assign,nonatomic)BOOL isButton37_4Clicked;

@property (strong,nonatomic)NSString *answer37;
/*====================================================*/
@property (strong,nonatomic)UIView *backView38;
@property (strong,nonatomic)UIView *subTopView38;
@property (strong,nonatomic)UILabel *questionLabel38;
@property (strong,nonatomic)UIView *subLineView38;
@property (strong,nonatomic)UIView *subDownView38;
@property (strong,nonatomic)UIButton *button38_1;
@property (strong,nonatomic)UIButton *button38_2;
@property (strong,nonatomic)UIButton *button38_3;
@property (strong,nonatomic)UIButton *button38_3Fix;
@property (strong,nonatomic)UIButton *button38_4;

@property (assign,nonatomic)BOOL isQuestion38Answered;
@property (assign,nonatomic)BOOL isButton38_1Clicked;
@property (assign,nonatomic)BOOL isButton38_2Clicked;
@property (assign,nonatomic)BOOL isButton38_3Clicked;
@property (assign,nonatomic)BOOL isButton38_3FixClicked;
@property (assign,nonatomic)BOOL isButton38_4Clicked;

@property (strong,nonatomic)NSString *answer38;
/*====================================================*/
@property (strong,nonatomic)UIView *backView39;
@property (strong,nonatomic)UIView *subTopView39;
@property (strong,nonatomic)UILabel *questionLabel39;
@property (strong,nonatomic)UIView *subLineView39;
@property (strong,nonatomic)UIView *subDownView39;
@property (strong,nonatomic)UIButton *button39_1;
@property (strong,nonatomic)UIButton *button39_2;
@property (strong,nonatomic)UIButton *button39_3;
@property (strong,nonatomic)UIButton *button39_3Fix;
@property (strong,nonatomic)UIButton *button39_4;

@property (assign,nonatomic)BOOL isQuestion39Answered;
@property (assign,nonatomic)BOOL isButton39_1Clicked;
@property (assign,nonatomic)BOOL isButton39_2Clicked;
@property (assign,nonatomic)BOOL isButton39_3Clicked;
@property (assign,nonatomic)BOOL isButton39_3FixClicked;
@property (assign,nonatomic)BOOL isButton39_4Clicked;

@property (strong,nonatomic)NSString *answer39;
/*====================================================*/
@property (strong,nonatomic)UIView *backView40;
@property (strong,nonatomic)UIView *subTopView40;
@property (strong,nonatomic)UILabel *questionLabel40;
@property (strong,nonatomic)UIView *subLineView40;
@property (strong,nonatomic)UIView *subDownView40;
@property (strong,nonatomic)UIButton *button40_1;
@property (strong,nonatomic)UIButton *button40_2;
@property (strong,nonatomic)UIButton *button40_3;
@property (strong,nonatomic)UIButton *button40_3Fix;
@property (strong,nonatomic)UIButton *button40_4;

@property (assign,nonatomic)BOOL isQuestion40Answered;
@property (assign,nonatomic)BOOL isButton40_1Clicked;
@property (assign,nonatomic)BOOL isButton40_2Clicked;
@property (assign,nonatomic)BOOL isButton40_3Clicked;
@property (assign,nonatomic)BOOL isButton40_3FixClicked;
@property (assign,nonatomic)BOOL isButton40_4Clicked;

@property (strong,nonatomic)NSString *answer40;
/*====================================================*/
@property (strong,nonatomic)UIView *backView41;
@property (strong,nonatomic)UIView *subTopView41;
@property (strong,nonatomic)UILabel *questionLabel41;
@property (strong,nonatomic)UIView *subLineView41;
@property (strong,nonatomic)UIView *subDownView41;
@property (strong,nonatomic)UIButton *button41_1;
@property (strong,nonatomic)UIButton *button41_2;
@property (strong,nonatomic)UIButton *button41_3;
@property (strong,nonatomic)UIButton *button41_3Fix;
@property (strong,nonatomic)UIButton *button41_4;

@property (assign,nonatomic)BOOL isQuestion41Answered;
@property (assign,nonatomic)BOOL isButton41_1Clicked;
@property (assign,nonatomic)BOOL isButton41_2Clicked;
@property (assign,nonatomic)BOOL isButton41_3Clicked;
@property (assign,nonatomic)BOOL isButton41_3FixClicked;
@property (assign,nonatomic)BOOL isButton41_4Clicked;

@property (strong,nonatomic)NSString *answer41;
/*====================================================*/
@property (strong,nonatomic)UIView *backView42;
@property (strong,nonatomic)UIView *subTopView42;
@property (strong,nonatomic)UILabel *questionLabel42;
@property (strong,nonatomic)UIView *subLineView42;
@property (strong,nonatomic)UIView *subDownView42;
@property (strong,nonatomic)UIButton *button42_1;
@property (strong,nonatomic)UIButton *button42_2;
@property (strong,nonatomic)UIButton *button42_3;
@property (strong,nonatomic)UIButton *button42_3Fix;
@property (strong,nonatomic)UIButton *button42_4;

@property (assign,nonatomic)BOOL isQuestion42Answered;
@property (assign,nonatomic)BOOL isButton42_1Clicked;
@property (assign,nonatomic)BOOL isButton42_2Clicked;
@property (assign,nonatomic)BOOL isButton42_3Clicked;
@property (assign,nonatomic)BOOL isButton42_3FixClicked;
@property (assign,nonatomic)BOOL isButton42_4Clicked;

@property (strong,nonatomic)NSString *answer42;
/*====================================================*/
@property (strong,nonatomic)UIView *backView43;
@property (strong,nonatomic)UIView *subTopView43;
@property (strong,nonatomic)UILabel *questionLabel43;
@property (strong,nonatomic)UIView *subLineView43;
@property (strong,nonatomic)UIView *subDownView43;
@property (strong,nonatomic)UIButton *button43_1;
@property (strong,nonatomic)UIButton *button43_2;
@property (strong,nonatomic)UIButton *button43_3;
@property (strong,nonatomic)UIButton *button43_3Fix;
@property (strong,nonatomic)UIButton *button43_4;

@property (assign,nonatomic)BOOL isQuestion43Answered;
@property (assign,nonatomic)BOOL isButton43_1Clicked;
@property (assign,nonatomic)BOOL isButton43_2Clicked;
@property (assign,nonatomic)BOOL isButton43_3Clicked;
@property (assign,nonatomic)BOOL isButton43_3FixClicked;
@property (assign,nonatomic)BOOL isButton43_4Clicked;

@property (strong,nonatomic)NSString *answer43;
/*====================================================*/
@property (strong,nonatomic)UIView *backView44;
@property (strong,nonatomic)UIView *subTopView44;
@property (strong,nonatomic)UILabel *questionLabel44;
@property (strong,nonatomic)UIView *subLineView44;
@property (strong,nonatomic)UIView *subDownView44;
@property (strong,nonatomic)UIButton *button44_1;
@property (strong,nonatomic)UIButton *button44_2;
@property (strong,nonatomic)UIButton *button44_3;
@property (strong,nonatomic)UIButton *button44_3Fix;
@property (strong,nonatomic)UIButton *button44_4;

@property (assign,nonatomic)BOOL isQuestion44Answered;
@property (assign,nonatomic)BOOL isButton44_1Clicked;
@property (assign,nonatomic)BOOL isButton44_2Clicked;
@property (assign,nonatomic)BOOL isButton44_3Clicked;
@property (assign,nonatomic)BOOL isButton44_3FixClicked;
@property (assign,nonatomic)BOOL isButton44_4Clicked;

@property (strong,nonatomic)NSString *answer44;
/*====================================================*/
@property (strong,nonatomic)UIView *backView45;
@property (strong,nonatomic)UIView *subTopView45;
@property (strong,nonatomic)UILabel *questionLabel45;
@property (strong,nonatomic)UIView *subLineView45;
@property (strong,nonatomic)UIView *subDownView45;
@property (strong,nonatomic)UIButton *button45_1;
@property (strong,nonatomic)UIButton *button45_2;
@property (strong,nonatomic)UIButton *button45_3;
@property (strong,nonatomic)UIButton *button45_3Fix;
@property (strong,nonatomic)UIButton *button45_4;

@property (assign,nonatomic)BOOL isQuestion45Answered;
@property (assign,nonatomic)BOOL isButton45_1Clicked;
@property (assign,nonatomic)BOOL isButton45_2Clicked;
@property (assign,nonatomic)BOOL isButton45_3Clicked;
@property (assign,nonatomic)BOOL isButton45_3FixClicked;
@property (assign,nonatomic)BOOL isButton45_4Clicked;

@property (strong,nonatomic)NSString *answer45;
/*====================================================*/
@property (strong,nonatomic)UIView *backView46;
@property (strong,nonatomic)UIView *subTopView46;
@property (strong,nonatomic)UILabel *questionLabel46;
@property (strong,nonatomic)UIView *subLineView46;
@property (strong,nonatomic)UIView *subDownView46;
@property (strong,nonatomic)UIButton *button46_1;
@property (strong,nonatomic)UIButton *button46_2;
@property (strong,nonatomic)UIButton *button46_3;
@property (strong,nonatomic)UIButton *button46_3Fix;
@property (strong,nonatomic)UIButton *button46_4;

@property (assign,nonatomic)BOOL isQuestion46Answered;
@property (assign,nonatomic)BOOL isButton46_1Clicked;
@property (assign,nonatomic)BOOL isButton46_2Clicked;
@property (assign,nonatomic)BOOL isButton46_3Clicked;
@property (assign,nonatomic)BOOL isButton46_3FixClicked;
@property (assign,nonatomic)BOOL isButton46_4Clicked;

@property (strong,nonatomic)NSString *answer46;
/*====================================================*/
@property (strong,nonatomic)UIView *backView47;
@property (strong,nonatomic)UIView *subTopView47;
@property (strong,nonatomic)UILabel *questionLabel47;
@property (strong,nonatomic)UIView *subLineView47;
@property (strong,nonatomic)UIView *subDownView47;
@property (strong,nonatomic)UIButton *button47_1;
@property (strong,nonatomic)UIButton *button47_2;
@property (strong,nonatomic)UIButton *button47_3;
@property (strong,nonatomic)UIButton *button47_3Fix;
@property (strong,nonatomic)UIButton *button47_4;

@property (assign,nonatomic)BOOL isQuestion47Answered;
@property (assign,nonatomic)BOOL isButton47_1Clicked;
@property (assign,nonatomic)BOOL isButton47_2Clicked;
@property (assign,nonatomic)BOOL isButton47_3Clicked;
@property (assign,nonatomic)BOOL isButton47_3FixClicked;
@property (assign,nonatomic)BOOL isButton47_4Clicked;

@property (strong,nonatomic)NSString *answer47;
/*====================================================*/
@property (strong,nonatomic)UIView *backView48;
@property (strong,nonatomic)UIView *subTopView48;
@property (strong,nonatomic)UILabel *questionLabel48;
@property (strong,nonatomic)UIView *subLineView48;
@property (strong,nonatomic)UIView *subDownView48;
@property (strong,nonatomic)UIButton *button48_1;
@property (strong,nonatomic)UIButton *button48_2;
@property (strong,nonatomic)UIButton *button48_3;
@property (strong,nonatomic)UIButton *button48_3Fix;
@property (strong,nonatomic)UIButton *button48_4;

@property (assign,nonatomic)BOOL isQuestion48Answered;
@property (assign,nonatomic)BOOL isButton48_1Clicked;
@property (assign,nonatomic)BOOL isButton48_2Clicked;
@property (assign,nonatomic)BOOL isButton48_3Clicked;
@property (assign,nonatomic)BOOL isButton48_3FixClicked;
@property (assign,nonatomic)BOOL isButton48_4Clicked;

@property (strong,nonatomic)NSString *answer48;
/*====================================================*/
@property (strong,nonatomic)UIView *backView49;
@property (strong,nonatomic)UIView *subTopView49;
@property (strong,nonatomic)UILabel *questionLabel49;
@property (strong,nonatomic)UIView *subLineView49;
@property (strong,nonatomic)UIView *subDownView49;
@property (strong,nonatomic)UIButton *button49_1;
@property (strong,nonatomic)UIButton *button49_2;
@property (strong,nonatomic)UIButton *button49_3;
@property (strong,nonatomic)UIButton *button49_3Fix;
@property (strong,nonatomic)UIButton *button49_4;

@property (assign,nonatomic)BOOL isQuestion49Answered;
@property (assign,nonatomic)BOOL isButton49_1Clicked;
@property (assign,nonatomic)BOOL isButton49_2Clicked;
@property (assign,nonatomic)BOOL isButton49_3Clicked;
@property (assign,nonatomic)BOOL isButton49_3FixClicked;
@property (assign,nonatomic)BOOL isButton49_4Clicked;

@property (strong,nonatomic)NSString *answer49;
/*====================================================*/
@property (strong,nonatomic)UIView *backView50;
@property (strong,nonatomic)UIView *subTopView50;
@property (strong,nonatomic)UILabel *questionLabel50;
@property (strong,nonatomic)UIView *subLineView50;
@property (strong,nonatomic)UIView *subDownView50;
@property (strong,nonatomic)UIButton *button50_1;
@property (strong,nonatomic)UIButton *button50_2;
@property (strong,nonatomic)UIButton *button50_3;
@property (strong,nonatomic)UIButton *button50_3Fix;
@property (strong,nonatomic)UIButton *button50_4;

@property (assign,nonatomic)BOOL isQuestion50Answered;
@property (assign,nonatomic)BOOL isButton50_1Clicked;
@property (assign,nonatomic)BOOL isButton50_2Clicked;
@property (assign,nonatomic)BOOL isButton50_3Clicked;
@property (assign,nonatomic)BOOL isButton50_3FixClicked;
@property (assign,nonatomic)BOOL isButton50_4Clicked;

@property (strong,nonatomic)NSString *answer50;
/*====================================================*/
@property (strong,nonatomic)UIView *backView51;
@property (strong,nonatomic)UIView *subTopView51;
@property (strong,nonatomic)UILabel *questionLabel51;
@property (strong,nonatomic)UIView *subLineView51;
@property (strong,nonatomic)UIView *subDownView51;
@property (strong,nonatomic)UIButton *button51_1;
@property (strong,nonatomic)UIButton *button51_2;
@property (strong,nonatomic)UIButton *button51_3;
@property (strong,nonatomic)UIButton *button51_3Fix;
@property (strong,nonatomic)UIButton *button51_4;

@property (assign,nonatomic)BOOL isQuestion51Answered;
@property (assign,nonatomic)BOOL isButton51_1Clicked;
@property (assign,nonatomic)BOOL isButton51_2Clicked;
@property (assign,nonatomic)BOOL isButton51_3Clicked;
@property (assign,nonatomic)BOOL isButton51_3FixClicked;
@property (assign,nonatomic)BOOL isButton51_4Clicked;

@property (strong,nonatomic)NSString *answer51;
/*====================================================*/
@property (strong,nonatomic)UIView *backView52;
@property (strong,nonatomic)UIView *subTopView52;
@property (strong,nonatomic)UILabel *questionLabel52;
@property (strong,nonatomic)UIView *subLineView52;
@property (strong,nonatomic)UIView *subDownView52;
@property (strong,nonatomic)UIButton *button52_1;
@property (strong,nonatomic)UIButton *button52_2;
@property (strong,nonatomic)UIButton *button52_3;
@property (strong,nonatomic)UIButton *button52_3Fix;
@property (strong,nonatomic)UIButton *button52_4;

@property (assign,nonatomic)BOOL isQuestion52Answered;
@property (assign,nonatomic)BOOL isButton52_1Clicked;
@property (assign,nonatomic)BOOL isButton52_2Clicked;
@property (assign,nonatomic)BOOL isButton52_3Clicked;
@property (assign,nonatomic)BOOL isButton52_3FixClicked;
@property (assign,nonatomic)BOOL isButton52_4Clicked;

@property (strong,nonatomic)NSString *answer52;
/*====================================================*/
@property (strong,nonatomic)UIView *backView53;
@property (strong,nonatomic)UIView *subTopView53;
@property (strong,nonatomic)UILabel *questionLabel53;
@property (strong,nonatomic)UIView *subLineView53;
@property (strong,nonatomic)UIView *subDownView53;
@property (strong,nonatomic)UIButton *button53_1;
@property (strong,nonatomic)UIButton *button53_2;
@property (strong,nonatomic)UIButton *button53_3;
@property (strong,nonatomic)UIButton *button53_3Fix;
@property (strong,nonatomic)UIButton *button53_4;

@property (assign,nonatomic)BOOL isQuestion53Answered;
@property (assign,nonatomic)BOOL isButton53_1Clicked;
@property (assign,nonatomic)BOOL isButton53_2Clicked;
@property (assign,nonatomic)BOOL isButton53_3Clicked;
@property (assign,nonatomic)BOOL isButton53_3FixClicked;
@property (assign,nonatomic)BOOL isButton53_4Clicked;

@property (strong,nonatomic)NSString *answer53;
/*====================================================*/
@property (strong,nonatomic)UIView *backView54;
@property (strong,nonatomic)UIView *subTopView54;
@property (strong,nonatomic)UILabel *questionLabel54;
@property (strong,nonatomic)UIView *subLineView54;
@property (strong,nonatomic)UIView *subDownView54;
@property (strong,nonatomic)UIButton *button54_1;
@property (strong,nonatomic)UIButton *button54_2;
@property (strong,nonatomic)UIButton *button54_3;
@property (strong,nonatomic)UIButton *button54_3Fix;
@property (strong,nonatomic)UIButton *button54_4;

@property (assign,nonatomic)BOOL isQuestion54Answered;
@property (assign,nonatomic)BOOL isButton54_1Clicked;
@property (assign,nonatomic)BOOL isButton54_2Clicked;
@property (assign,nonatomic)BOOL isButton54_3Clicked;
@property (assign,nonatomic)BOOL isButton54_3FixClicked;
@property (assign,nonatomic)BOOL isButton54_4Clicked;

@property (strong,nonatomic)NSString *answer54;
/*====================================================*/
@property (strong,nonatomic)UIView *backView55;
@property (strong,nonatomic)UIView *subTopView55;
@property (strong,nonatomic)UILabel *questionLabel55;
@property (strong,nonatomic)UIView *subLineView55;
@property (strong,nonatomic)UIView *subDownView55;
@property (strong,nonatomic)UIButton *button55_1;
@property (strong,nonatomic)UIButton *button55_2;
@property (strong,nonatomic)UIButton *button55_3;
@property (strong,nonatomic)UIButton *button55_3Fix;
@property (strong,nonatomic)UIButton *button55_4;

@property (assign,nonatomic)BOOL isQuestion55Answered;
@property (assign,nonatomic)BOOL isButton55_1Clicked;
@property (assign,nonatomic)BOOL isButton55_2Clicked;
@property (assign,nonatomic)BOOL isButton55_3Clicked;
@property (assign,nonatomic)BOOL isButton55_3FixClicked;
@property (assign,nonatomic)BOOL isButton55_4Clicked;

@property (strong,nonatomic)NSString *answer55;
/*====================================================*/
@property (strong,nonatomic)UIView *backView56;
@property (strong,nonatomic)UIView *subTopView56;
@property (strong,nonatomic)UILabel *questionLabel56;
@property (strong,nonatomic)UIView *subLineView56;
@property (strong,nonatomic)UIView *subDownView56;
@property (strong,nonatomic)UIButton *button56_1;
@property (strong,nonatomic)UIButton *button56_2;
@property (strong,nonatomic)UIButton *button56_3;
@property (strong,nonatomic)UIButton *button56_3Fix;
@property (strong,nonatomic)UIButton *button56_4;

@property (assign,nonatomic)BOOL isQuestion56Answered;
@property (assign,nonatomic)BOOL isButton56_1Clicked;
@property (assign,nonatomic)BOOL isButton56_2Clicked;
@property (assign,nonatomic)BOOL isButton56_3Clicked;
@property (assign,nonatomic)BOOL isButton56_3FixClicked;
@property (assign,nonatomic)BOOL isButton56_4Clicked;

@property (strong,nonatomic)NSString *answer56;
/*====================================================*/
@property (strong,nonatomic)UIView *backView57;
@property (strong,nonatomic)UIView *subTopView57;
@property (strong,nonatomic)UILabel *questionLabel57;
@property (strong,nonatomic)UIView *subLineView57;
@property (strong,nonatomic)UIView *subDownView57;
@property (strong,nonatomic)UIButton *button57_1;
@property (strong,nonatomic)UIButton *button57_2;
@property (strong,nonatomic)UIButton *button57_3;
@property (strong,nonatomic)UIButton *button57_3Fix;
@property (strong,nonatomic)UIButton *button57_4;

@property (assign,nonatomic)BOOL isQuestion57Answered;
@property (assign,nonatomic)BOOL isButton57_1Clicked;
@property (assign,nonatomic)BOOL isButton57_2Clicked;
@property (assign,nonatomic)BOOL isButton57_3Clicked;
@property (assign,nonatomic)BOOL isButton57_3FixClicked;
@property (assign,nonatomic)BOOL isButton57_4Clicked;

@property (strong,nonatomic)NSString *answer57;
/*====================================================*/
@property (strong,nonatomic)UIView *backView58;
@property (strong,nonatomic)UIView *subTopView58;
@property (strong,nonatomic)UILabel *questionLabel58;
@property (strong,nonatomic)UIView *subLineView58;
@property (strong,nonatomic)UIView *subDownView58;
@property (strong,nonatomic)UIButton *button58_1;
@property (strong,nonatomic)UIButton *button58_2;
@property (strong,nonatomic)UIButton *button58_3;
@property (strong,nonatomic)UIButton *button58_3Fix;
@property (strong,nonatomic)UIButton *button58_4;

@property (assign,nonatomic)BOOL isQuestion58Answered;
@property (assign,nonatomic)BOOL isButton58_1Clicked;
@property (assign,nonatomic)BOOL isButton58_2Clicked;
@property (assign,nonatomic)BOOL isButton58_3Clicked;
@property (assign,nonatomic)BOOL isButton58_3FixClicked;
@property (assign,nonatomic)BOOL isButton58_4Clicked;

@property (strong,nonatomic)NSString *answer58;
/*====================================================*/
@property (strong,nonatomic)UIView *backView59;
@property (strong,nonatomic)UIView *subTopView59;
@property (strong,nonatomic)UILabel *questionLabel59;
@property (strong,nonatomic)UIView *subLineView59;
@property (strong,nonatomic)UIView *subDownView59;
@property (strong,nonatomic)UIButton *button59_1;
@property (strong,nonatomic)UIButton *button59_2;
@property (strong,nonatomic)UIButton *button59_3;
@property (strong,nonatomic)UIButton *button59_3Fix;
@property (strong,nonatomic)UIButton *button59_4;

@property (assign,nonatomic)BOOL isQuestion59Answered;
@property (assign,nonatomic)BOOL isButton59_1Clicked;
@property (assign,nonatomic)BOOL isButton59_2Clicked;
@property (assign,nonatomic)BOOL isButton59_3Clicked;
@property (assign,nonatomic)BOOL isButton59_3FixClicked;
@property (assign,nonatomic)BOOL isButton59_4Clicked;

@property (strong,nonatomic)NSString *answer59;
/*====================================================*/
@property (strong,nonatomic)UIView *backView60;
@property (strong,nonatomic)UIView *subTopView60;
@property (strong,nonatomic)UILabel *questionLabel60;
@property (strong,nonatomic)UIView *subLineView60;
@property (strong,nonatomic)UIView *subDownView60;
@property (strong,nonatomic)UIButton *button60_1;
@property (strong,nonatomic)UIButton *button60_2;
@property (strong,nonatomic)UIButton *button60_3;
@property (strong,nonatomic)UIButton *button60_3Fix;
@property (strong,nonatomic)UIButton *button60_4;

@property (assign,nonatomic)BOOL isQuestion60Answered;
@property (assign,nonatomic)BOOL isButton60_1Clicked;
@property (assign,nonatomic)BOOL isButton60_2Clicked;
@property (assign,nonatomic)BOOL isButton60_3Clicked;
@property (assign,nonatomic)BOOL isButton60_3FixClicked;
@property (assign,nonatomic)BOOL isButton60_4Clicked;

@property (strong,nonatomic)NSString *answer60;
/*====================================================*/
@property (strong,nonatomic)UIButton *confirmButton;
/*====================================================*/
@property (strong,nonatomic)NSMutableArray *questionArray;
@property (strong,nonatomic)NSMutableArray *questionGroupIdArray;
@property (strong,nonatomic)NSMutableArray *questionItemIdArray;
@property (strong,nonatomic)NSMutableArray *questionItemNameArray;
@property (strong,nonatomic)NSMutableArray *questionItemStarArray;
@property (strong,nonatomic)NSMutableArray *questionItemRepeatArray;

@end
