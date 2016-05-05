//
//  xPhotoViewController.m
//  ImagePicker
//
//  Created by xuxuxuxu on 14-5-25.
//  Copyright (c) 2014年 Seungbo Cho. All rights reserved.
//

#import "xPhotoViewController.h"

//#import "AECMacro.h"
//#import "UIView+StringTag.h"

#define spacing  10
#define kSelectionLabKey        @"selectionLabKey"
#define kSelectionImageKey      @"selectionOImageKey"

@interface xPhotoView: UIScrollView <UIScrollViewDelegate>
@property (nonatomic, strong) UIImage                 *img;
@property (nonatomic, strong) UIImageView             *imgV;
@property (nonatomic, weak)   UINavigationController  *superView;
@property (nonatomic, strong) UIImageView *assetSingleImageView;
@property (nonatomic, strong) UILabel *indexNumLab;
@property (nonatomic, strong) UIButton *Indicator;
@property (nonatomic, copy)  void(^sigleTapReturn_block)(void);
@end

@interface xPhotoViewController () <UIScrollViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) UIScrollView        *srcollView;
@property (nonatomic, assign) NSInteger           curIndex;
@property (nonatomic, strong) NSMutableArray      *arr;
@property (nonatomic, strong) UIPageControl       *page;
@property (nonatomic, assign) BOOL                haveEdit;
@end


@implementation xPhotoVCTransitionPushAnimator
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;{
    return .5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    id<xPhotoViewTransitionProtcol> from = (id<xPhotoViewTransitionProtcol>)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIImage *image = from.animationBeginImage;
 
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectFromString(from.animationImageViewFramesFromWindow[from.imageIndex])];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [transitionContext.containerView addSubview:imageView];
    
    [UIView animateKeyframesWithDuration:.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        imageView.frame = [self getImgVFrame:image];
    } completion:^(BOOL finished) {
        [transitionContext.containerView addSubview:to.view];
        [imageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (CGRect)getImgVFrame:(UIImage *)img{
    CGRect rect;
    CGFloat width,height;
    if(MAX(img.size.width/img.size.height, [UIScreen mainScreen].applicationFrame.size.width/[UIScreen mainScreen].applicationFrame.size.height) == img.size.width/img.size.height){
        width = [UIScreen mainScreen].applicationFrame.size.width;
        height = width/img.size.width*img.size.height;
        rect = CGRectMake(0, ([UIScreen mainScreen].applicationFrame.size.height-height)*.5, width, height);
    }
    else{
        height = [UIScreen mainScreen].applicationFrame.size.height;
        width = img.size.width*height/img.size.height;
        rect = CGRectMake(([UIScreen mainScreen].applicationFrame.size.width-width)*.5, 0, width, height);
    }
    return rect;
}
@end

@implementation xPhotoVCTransitionPopAnimator
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;{
    return .5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    xPhotoViewController *from = (xPhotoViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    id<xPhotoViewTransitionProtcol> to = (id<xPhotoViewTransitionProtcol>)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    xPhotoView *pView = from.arr[from.curIndex];
    
    [transitionContext.containerView addSubview:((UIViewController *)to).view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointZero,pView.frame.size}];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = pView.img;
    [transitionContext.containerView addSubview:imageView];
    
    [UIView animateKeyframesWithDuration:.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        imageView.frame = CGRectFromString(to.animationImageViewFramesFromWindow[from.curIndex]);
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [transitionContext completeTransition:YES];
        ((UIViewController *)to).navigationController.delegate = nil;
    }];
}
@end

@implementation xPhotoView
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.minimumZoomScale = 1.;
        self.maximumZoomScale = 2.;
        self.multipleTouchEnabled = YES;
        self.delegate = self;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.bounces = YES;
        
        self.imgV = [[UIImageView alloc] init];
        self.imgV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgV];
        
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleTap.numberOfTapsRequired = 1;
        
        [self addGestureRecognizer:singleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
        self.assetSingleImageView= [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 26, 26)];
        //        self.assetSingleImageView.backgroundColor = COLOR_0;
//        self.assetSingleImageView.stringTag = kSelectionImageKey;
        //self.assetSingleImageView.image = [UIImage imageNamed:@"singleSelect"];
        self.indexNumLab = [[UILabel alloc] init];
        self.indexNumLab.frame = CGRectMake(10, 10, 24, 24);
//        self.indexNumLab.stringTag = kSelectionLabKey;
        self.indexNumLab.textAlignment = NSTextAlignmentCenter;
        self.indexNumLab.textColor = [UIColor whiteColor];
        self.Indicator= [UIButton buttonWithType:UIButtonTypeCustom];
        self.Indicator.frame = CGRectMake((2*self.frame.size.width)-50, 20, 44, 44);
        self.Indicator.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        [self.Indicator addSubview:self.assetSingleImageView];
        [self.Indicator addSubview:self.indexNumLab];
    }
    return self;
}

- (void)setImg:(UIImage *)img{
    _img = img;
    if(img){
        _imgV.frame = [self getImgVFrame:img];
    }
    _imgV.image = _img;
    _imgV.contentMode = UIViewContentModeScaleToFill;
}

- (void)doubleTap:(UITapGestureRecognizer *)tap{
    if(2. == self.zoomScale ){
        [self setZoomScale:1. animated:YES];
    }
    else{
        CGPoint point = [tap locationInView:self];
        [self zoomToRect:CGRectMake(point.x, point.y, 1, 1) animated:YES];
    }
}

- (void)singleTap:(id)sender
{
    [_superView setNavigationBarHidden:!_superView.navigationBar.hidden animated:NO];
    if(self.sigleTapReturn_block){
        self.sigleTapReturn_block();
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _imgV.frame;
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    }
    else{
        frameToCenter.origin.x = 0;
    }
    if(frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    }
    else{
        frameToCenter.origin.y = 0;
    }
    if (!CGRectEqualToRect(_imgV.frame, frameToCenter)){
        _imgV.frame = frameToCenter;
    }
}

- (CGRect)getImgVFrame:(UIImage *)img{
    CGRect rect;
    CGFloat width,height;
    if(img.size.width/img.size.height==MAX(img.size.width/img.size.height, self.frame.size.width/self.frame.size.height)){
        width = self.frame.size.width;
        height = width/img.size.width*img.size.height;
        rect = CGRectMake(0, (self.frame.size.height-height)*.5, width, height);
    }
    else{
        height = self.frame.size.height;
        width = img.size.width*height/img.size.height;
        rect = CGRectMake((self.frame.size.width-width)*.5, 0, width, height);
    }
    return rect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imgV;
}
@end

@implementation xPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // by yangqin 教师版stauts bar处理
//    [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_STATUS_BAR_VIEW object:nil];
    
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 防止操作传进来的数组
    _photoPaths = [[NSMutableArray alloc] initWithArray:_photoPaths];
    
    _srcollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-spacing, 0, self.view.frame.size.width+(spacing<<1), self.view.frame.size.height)];
    _srcollView.contentSize = CGSizeMake((self.view.frame.size.width+(spacing<<1))*_photoPaths.count, self.view.frame.size.height);
    [self.view addSubview:_srcollView];
    _srcollView.pagingEnabled = YES;
    _srcollView.delegate = self;
    _srcollView.alwaysBounceVertical = NO;
    _srcollView.directionalLockEnabled = YES;
    _srcollView.showsHorizontalScrollIndicator = NO;
    _srcollView.showsVerticalScrollIndicator = NO;

    _arr = [[NSMutableArray alloc] init];
    for(int i = 0;i < _photoPaths.count;i++){
        xPhotoView *img = [[xPhotoView alloc] initWithFrame:CGRectMake(i * (self.view.frame.size.width + spacing*2) + spacing, 0, self.view.frame.size.width, _srcollView.frame.size.height)];
        __weak xPhotoView *weakImage = img;
        if ([_photoPaths[i] isKindOfClass:[UIImage class]]) {
            weakImage.img = _photoPaths[i];
        } else {
            [img.imgV sd_setImageWithURL:[NSURL URLWithString:_photoPaths[i]] placeholderImage:[UIImage imageNamed:@"default_head_portrait"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(error)
                    weakImage.img = [UIImage imageNamed:@"default_head_portrait"];
                else
                    weakImage.img = image;
            }];
        }
        img.superView = self.navigationController;
        img.contentMode = UIViewContentModeScaleAspectFit;
        _srcollView.backgroundColor = [UIColor blackColor];
        [_srcollView addSubview:img];
        [_arr addObject:img];
    }

    _curIndex = _index;
    _srcollView.contentOffset = CGPointMake((self.view.frame.size.width+(spacing<<1)) * _curIndex, 0);
    
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50., self.view.frame.size.width, 20.)];
    _page.numberOfPages = _photoPaths.count;
    _page.currentPage = _curIndex;
    _page.enabled = NO;
    _page.hidesForSinglePage = YES;
    [self.view addSubview:_page];
    
    self.navigationItem.title = _photoPaths.count > 1 ? [NSString stringWithFormat:@"%ld/%lu",(long)_curIndex+1,(unsigned long)_photoPaths.count]:@"预览";
    
    //    [self.navigationController addCustemRightBtnWithTitle:@"编辑" target:self action:@selector(editPhoto:)];
    if (self.canEdit) {
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete_photo"]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(editImage:)];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
}

// by yangqin 教师版stauts bar处理
- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_STATUS_BAR_VIEW object:nil];
}

- (void)editImage:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"要删除这张照片吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(0 == buttonIndex) {
        [self reloadPhotoPaths:_curIndex];
    }
}

- (void)reloadPhotoPaths:(NSInteger)curIndex{
    if (self.editBlock) {
        self.editBlock(_curIndex);
    }
    [_photoPaths removeObjectAtIndex:_curIndex];
    [_arr removeObjectAtIndex:_curIndex];
    if (0 == _photoPaths.count) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    _curIndex--;
    if (_curIndex < 0) {
        _curIndex = 0;
    }
    _srcollView.contentSize = CGSizeMake((self.view.frame.size.width+(spacing<<1))*_photoPaths.count, self.view.frame.size.height);
    for (UIView *view in _srcollView.subviews) {
        [view removeFromSuperview];
    }
    NSMutableArray *newXPhotoViewArray = [[NSMutableArray alloc] init];
    for(int i = 0;i < _photoPaths.count;i++){
        xPhotoView *img = [_arr objectAtIndex:i];
        img.frame = CGRectMake(i * (self.view.frame.size.width + spacing*2) + spacing, 0, self.view.frame.size.width, _srcollView.frame.size.height);
        [newXPhotoViewArray addObject:img];
        [_srcollView addSubview:img];
    }
    _arr = [[NSMutableArray alloc] initWithArray:newXPhotoViewArray];
    _page.numberOfPages = _photoPaths.count;
    _page.currentPage = _curIndex;
    self.navigationItem.title = _photoPaths.count > 1 ? [NSString stringWithFormat:@"%ld/%lu",_curIndex+1,(unsigned long)_photoPaths.count]:@"预览";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int tmp = scrollView.contentOffset.x / self.view.frame.size.width;
    if(tmp != _curIndex) {
        xPhotoView *view = _arr[_curIndex];
        [view setZoomScale:1.];
    }
    _curIndex = tmp;
    _page.currentPage = _curIndex;
    self.navigationItem.title = _photoPaths.count > 1 ? [NSString stringWithFormat:@"%ld/%lu",_curIndex+1,(unsigned long)_photoPaths.count]:@"预览";
}


@end
