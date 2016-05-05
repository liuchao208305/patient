//
//  LVRecordTool.h
//  RecordAndPlayVoice
//
//  Created by PBOC CS on 15/3/14.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class LVRecordTool;
@protocol LVRecordToolDelegate <NSObject>

@optional
- (void)recordTool:(LVRecordTool *)recordTool didstartRecoring:(int)no;

// 完成播放代理
- (void)avaudioPlayFinishdePlay;

@end

// 定义block 为了暂停动画
typedef void(^AVAudioPlayerStopBlock)();




@interface LVRecordTool : NSObject

// block要用copy
@property (nonatomic, copy) AVAudioPlayerStopBlock playStopBlock;
/** 播放器对象 */
@property (nonatomic, strong) AVAudioPlayer *player;
/** 录音文件地址 */
@property (nonatomic, strong) NSURL *recordFileUrl_Advice;
@property (nonatomic, strong) NSURL *recordFileUrl_Aanlysis;




@property (nonatomic, strong) NSString *advice_path;
@property (nonatomic, strong) NSString *analysis_path;


/** 录音工具的单例 */
+ (instancetype)sharedRecordTool;



/** 开始录音 */
- (void)startRecordingWithFileName:(NSString *)fileName;

/** 停止录音 */
- (void)stopRecording;

/** 播放录音文件 */
- (void)playRecordingFile;

/**
 *  根据地址播放
 *  @param url 地址
 */
- (void)playRecordFile:(NSURL *)url;


/** 停止播放录音文件 */
- (void)stopPlaying;

/** 销毁录音文件 */
- (void)destructionRecordingFile;

/** 录音对象 */
@property (nonatomic, strong) AVAudioRecorder *recorder;

/** 更新图片的代理 */
@property (nonatomic, assign) id<LVRecordToolDelegate> delegate;






/**
 *  avPlayer播放器
 *
 *  @param url
 */
- (void)avplayerWithRecordFile:(NSURL *)url;
@property (nonatomic, strong) AVPlayer *avPlayer;

/**
 *  是否试着播放
 */
@property (nonatomic, assign)  BOOL isTryPlay;



@end
