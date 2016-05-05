//
//  LVRecordTool.m
//  RecordAndPlayVoice
//
//  Created by PBOC CS on 15/3/14.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#define LVRecordFielName @"lvRecord.caf"

#import "LVRecordTool.h"

#import "lame.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LVRecordTool () <AVAudioRecorderDelegate, AVAudioPlayerDelegate>





/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSString *fileName;

@end

@implementation LVRecordTool

static LVRecordTool *instance;
#pragma mark - 单例
+ (instancetype)sharedRecordTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
            instance.avPlayer = [[AVPlayer alloc] init];
            instance.avPlayer.volume=1;
            
        }
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
}



- (void)startRecordingWithFileName:(NSString *)fileName {
    // 录音时停止播放 删除曾经生成的文件
    [self stopPlaying];
    [self destructionRecordingFile];
    self.fileName = fileName;
    
    // 真机环境下需要的代码
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil){
        
        //NSLog(@"Error creating session: %@", [sessionError description]);
    }
    else{
        
        [session setActive:YES error:nil];
    }
    
    // 1.获取沙盒地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    
    if ([self.fileName isEqualToString:@"advice.caf"]) {
        self.recordFileUrl_Advice = [NSURL fileURLWithPath:filePath];
        
        self.advice_path = filePath;
    } else {
        self.recordFileUrl_Aanlysis = [NSURL fileURLWithPath:filePath];
        self.analysis_path = filePath;
    }
    
    //录音设置
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [settings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [settings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [settings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    //[recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [settings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    
    
    
    if ([self.fileName isEqualToString:@"advice.caf"]) {
        _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl_Advice settings:settings error:NULL];
        
    } else {
        _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl_Aanlysis settings:settings error:NULL];
       
    }
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    
    [_recorder prepareToRecord];
    
    [self.recorder record];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    self.timer = timer;
    
   
    
}


- (void)updateImage {
    
    [self.recorder updateMeters];
    double lowPassResults = pow(10, (0.05 * [self.recorder peakPowerForChannel:0]));
    float result  = 10 * (float)lowPassResults;
    int no = 0;
    if (result > 0 && result <= 1.3) {
        no = 1;
    } else if (result > 1.3 && result <= 2) {
        no = 2;
    } else if (result > 2 && result <= 3.0) {
        no = 3;
    } else if (result > 3.0 && result <= 3.0) {
        no = 4;
    } else if (result > 5.0 && result <= 10) {
        no = 5;
    } else if (result > 10 && result <= 40) {
        no = 6;
    } else if (result > 40) {
        no = 7;
    }
    
    if ([self.delegate respondsToSelector:@selector(recordTool:didstartRecoring:)]) {
        [self.delegate recordTool:self didstartRecoring: no];
    }
}

- (void)stopRecording {
    [self.recorder stop];
    [self.timer invalidate];
}

- (void)playRecordingFile {
    // 播放时停止录音
    [self.recorder stop];
    
    // 正在播放就返回
    if ([self.fileName isEqualToString:@"advice.caf"]) {
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl_Advice error:NULL];
        self.player.delegate = self;
    } else {
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl_Aanlysis error:NULL];
        self.player.delegate = self;
    }
    
    [self.player play];
}

- (void)playRecordFile:(NSURL *)url
{
    // 播放时停止录音
    [self.recorder stop];
    self.isTryPlay=NO;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.player.delegate = self;
    [self.player play];
    
    
    //------ start test -----
   
//    NSData *mydata=[[NSData alloc] initWithContentsOfURL:url];
//     self.player=[[AVAudioPlayer alloc]initWithData:mydata error:nil];
//    self.player.delegate = self;
//    [self.player play];
    // ------ end
    
    
}



// 暂时不用
- (void)avplayerWithRecordFile:(NSURL *)url
{
    AVPlayer *player = [LVRecordTool sharedRecordTool].avPlayer;
    player.volume = 1;
    // 音乐
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [player replaceCurrentItemWithPlayerItem:item];
    [player play];
    // 利用通知监听音频播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioPlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
}

- (void)audioPlayEnd:(NSNotification *)notification
{
   
}






- (void)stopPlaying {
    [self.player stop];
}

- (void)destructionRecordingFile {
    
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    if ([self.cafName isEqualToString:@"advice.caf"]) {
    //        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl_Advice error:NULL];
    //    } else {
    //        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl_Aanlysis error:NULL];
    //    }
    //    if (self.recordFileUrl) {
    //        [fileManager removeItemAtURL:self.recordFileUrl error:NULL];
    //    }
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        // NSLog(@"录音成功");
   
//        [self audio_PCMtoMP3];
    }
}





//- (void)audio_PCMtoMP3
//{
//    
//    NSString *cafFilePath = nil;
//    NSString *mp3FilePath = nil;
//    if ([self.fileName isEqualToString:@"advice.caf"]) {
//        cafFilePath = self.advice_path;
//
//        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        // 拼接要写入文件的路径
//        mp3FilePath = [documentsPath stringByAppendingPathComponent:@"MP3advice.mp3"];
//        
//    } else {
//        cafFilePath = self.analysis_path;
//        
//        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        // 拼接要写入文件的路径
//        mp3FilePath = [documentsPath stringByAppendingPathComponent:@"MP3analysis.mp3"];
//    }
//    
//    NSFileManager* fileManager=[NSFileManager defaultManager];
//    if([fileManager removeItemAtPath:mp3FilePath error:nil])
//    {
//        NSLog(@"删除");
//    }
//    
//    @try {
//        int read, write;
//        
//        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
//        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
//        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
//        
//        const int PCM_SIZE = 8192;
//        const int MP3_SIZE = 8192;
//        short int pcm_buffer[PCM_SIZE*2];
//        unsigned char mp3_buffer[MP3_SIZE];
//        
//        lame_t lame = lame_init();
//        lame_set_in_samplerate(lame, 11025.0);
//        lame_set_VBR(lame, vbr_default);
//        lame_init_params(lame);
//        
//        do {
//            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
//            if (read == 0)
//                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
//            else
//                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
//            
//            fwrite(mp3_buffer, write, 1, mp3);
//            
//        } while (read != 0);
//        
//        lame_close(lame);
//        fclose(mp3);
//        fclose(pcm);
//    }
//    @catch (NSException *exception) {
//        NSLog(@"%@",[exception description]);
//    }
//    @finally {
//        
//        if ([self.fileName isEqualToString:@"advice.caf"]) {
//            // 记录新的MP3地址
//            self.recordFileUrl_Advice = [NSURL URLWithString:mp3FilePath];
//        } else {
//            self.recordFileUrl_Aanlysis = [NSURL URLWithString:mp3FilePath];
//        }
//        
//        
//    }
//}


#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    //if (self.fileName) {
    //self.isAdvice==YES?_playStopBlock_ADVICE():_playStopBlock_ANALYSIS();
    if (_isTryPlay==YES) {
        NSLog(@"试 -- 播放完成");
    } else{
        NSLog(@"播放完成");
        _playStopBlock();
    }
    ;
    //}
}



@end
