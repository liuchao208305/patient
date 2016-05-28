//
//  ScanViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AnalyticUtil.h"

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView *lineImageView;
    BOOL upOrDown;
    int num;
    NSTimer *timer;
    CGFloat lineX;
    CGFloat lineY;
    CGFloat lineWidth;
    CGFloat lineAnimationProportion;
}

@property (strong, nonatomic) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preView;

@end

@implementation ScanViewController
#pragma mark Life Circle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"ScanViewController"];
    
    [self.session startRunning];
    [self openCamera];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self initNavBar];
    [self initView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"ScanViewController"];
    
    [self.session stopRunning];
    [timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Init Section
- (void)initNavBar{
//    self.navigationItem.title = @"二维码扫描";
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = @"二维码扫描";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    
    self.title=@"二维码扫描";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

- (void)initView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCREEN_HEIGHT/2)/2, 64+40, SCREEN_HEIGHT/2, SCREEN_HEIGHT/2)];
    imageView.image = [UIImage imageNamed:@"scan_back_image.png"];
    [self.view addSubview:imageView];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(imageView.frame)+15, SCREEN_WIDTH-30, 50)];;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.text = @"请将二维码对准扫码框！";
    [self.view addSubview:label];
    
    upOrDown = NO;
    num = 0;
    
    if (SCREEN_HEIGHT == 480){
        lineX = 60;
        lineY = imageView.y + 15;
        lineWidth = imageView.width - 50;
        lineAnimationProportion = 1.5;
    }else if (SCREEN_HEIGHT == 568){
        lineX = 40;
        lineY = imageView.y + 15;
        lineWidth = imageView.width - 50;
        lineAnimationProportion = 1.7;
    }else if (SCREEN_HEIGHT == 667){
        lineX = 40;
        lineY = imageView.y + 15;
        lineWidth = imageView.width - 50;
        lineAnimationProportion = 2;
    }else{
        lineX = 45;
        lineY = imageView.y + 15;
        lineWidth = imageView.width - 50;
        lineAnimationProportion = 2.2;
    }
    
    lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(lineX, lineY, lineWidth, 2)];
    lineImageView.image = [UIImage imageNamed:@"scan_line_image.png"];
    [self.view addSubview:lineImageView];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(lineAnimation) userInfo:nil repeats:YES];
}

#pragma mark Target Action
- (void)lineAnimation{
    
    if (upOrDown == NO){
        num++;
        lineImageView.frame = CGRectMake(lineX, lineY + lineAnimationProportion * num, lineWidth, 2);
        if (2 * num == 260)
        {
            upOrDown = YES;
        }
    }else{
        num--;
        lineImageView.frame = CGRectMake(lineX, lineY + lineAnimationProportion * num, lineWidth, 2);
        if (num == 0){
            upOrDown = NO;
        }
    }
}

- (void)openCamera{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未获得授权使用摄像头" message:@"请在iOS『设置』-『隐私』-『相机』中打开" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        alert.tag = 840;
        [alert show];
        return;
    }
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]){
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]){
        [self.session addOutput:self.output];
    }
    self.output.metadataObjectTypes =  @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    self.preView = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preView.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preView.frame = CGRectMake((SCREEN_WIDTH - SCREEN_HEIGHT/2)/2, 64+40, SCREEN_HEIGHT/2, SCREEN_HEIGHT/2);
    [self.view.layer insertSublayer:self.preView atIndex:0];
    [self.session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if ([metadataObjects count] > 0){
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        NSString *string = metadataObject.stringValue;
        DLog(@"%@",string);
        //此处根据结果做出相应处理
    }
    [self.session stopRunning];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
