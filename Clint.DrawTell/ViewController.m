//
//  ViewController.m
//  Clint.DrawTell
//
//  Created by Clintlin on 14/10/31.
//  Copyright (c) 2014年 JoinUs.Clint.Lin. All rights reserved.
//

#import "ViewController.h"
#import "RecorderManager.h"
#import "PlayerManager.h"

    @interface ViewController ()<RecordingDelegate, PlayingDelegate>

    @property (nonatomic, weak) IBOutlet UILabel *consoleLabel;
    @property (nonatomic, weak) IBOutlet UILabel *fileSize;
    @property (nonatomic, weak) IBOutlet UILabel *recordDuration;
    @property (nonatomic, assign) BOOL isRecording;
    @property (nonatomic, assign) BOOL isPlaying;

    @property (nonatomic, copy) NSString *filename;

@end

@implementation ViewController{
    CGFloat                 curCount;           //当前计数,初始为0
    //ChatRecorderView        *recorderView;      //录音界面
    CGPoint                 curTouchPoint;      //触摸点
    BOOL                    canNotSend;         //不能发送
    NSTimer                 *timer;
    float                   kDuration;
    
    NSString                *fileType;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 界面调整
    self.playButton.enabled = NO;
    self.stopButton.enabled = NO;
    
    self.isPlaying = NO;
    self.isRecording = NO;
    
    self.consoleLabel.numberOfLines = 0;
    self.consoleLabel.text = @"录音测试Demo";
    
}

- (void)dealloc {
//    [self removeObserver:self forKeyPath:@"isRecording"];
//    [self removeObserver:self forKeyPath:@"isPlaying"];
}


#pragma marker 按钮响应区
- (IBAction)recordStart:(id)sender {
    
    if (! self.isRecording)
    {
        
        self.isRecording = YES;
        
        self.playButton.enabled = NO;
        self.stopButton.enabled = YES;
        //[self.audioRecorder record];

        [RecorderManager sharedManager].delegate = self;
        [[RecorderManager sharedManager] startRecording];
        
        //启动计时器
        [self startTimer];
    }
    else {
        self.isRecording = NO;
        [[RecorderManager sharedManager] stopRecording];
    }
}

- (IBAction)recordStop:(id)sender {
    self.stopButton.enabled = NO;
    self.playButton.enabled = YES;
    self.recordButton.enabled = YES;
    
    
    
    if (self.isRecording) {
        self.isRecording = NO;
        [[RecorderManager sharedManager] stopRecording];
        
        //停止计时器
        [self stopTimer];
        
        

    }else if(self.isPlaying){
        self.isPlaying = NO;
        [[PlayerManager sharedManager] stopPlaying];
    }

}

- (IBAction)recordPlay:(id)sender {

    if ( ! self.isRecording) {
        
        self.stopButton.enabled = YES;
        self.recordButton.enabled = NO;
        
        [PlayerManager sharedManager].delegate = nil;
        
        self.isPlaying = YES;
        self.consoleLabel.text = [NSString stringWithFormat:@"正在播放: %@", [self.filename substringFromIndex:[self.filename rangeOfString:@"Documents"].location]];
        [[PlayerManager sharedManager] playAudioWithFileName:self.filename delegate:self];
    }
    
}

- (IBAction)showFileSize:(id)sender {
     self.fileSize.text = [NSString stringWithFormat:@"上一次录音文件大小：%ldkb",(long)[VoiceRecorderBase getFileSize:self.filename]/1024];
}

#pragma mark - Recording & Playing Delegate

- (void)recordingFinishedWithFileName:(NSString *)filePath time:(NSTimeInterval)interval {
    self.isRecording = NO;

    self.filename = filePath;
    
    
    [self.consoleLabel performSelectorOnMainThread:@selector(setText:)
                                        withObject:[NSString stringWithFormat:@"录音完成: %@", [self.filename substringFromIndex:[self.filename rangeOfString:@"Documents"].location]]
                                     waitUntilDone:NO];

}

- (void)recordingTimeout {
    self.isRecording = NO;
    self.consoleLabel.text = @"录音超时";
}

- (void)recordingStopped {
    self.isRecording = NO;
}

- (void)recordingFailed:(NSString *)failureInfoString {
    self.isRecording = NO;
    self.consoleLabel.text = @"录音失败";
}



#pragma mark - 启动定时器
- (void)startTimer{
    kDuration = 0;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(emptyFunction) userInfo:nil repeats:YES];
}

#pragma mark - 停止定时器
- (void)stopTimer{
    if (timer && timer.isValid){
        [timer invalidate];
        ///NSLog(@"%@",timer);
        timer = nil;
    }
}

- (void)playingStoped {
    self.isPlaying = NO;
    self.consoleLabel.text = [NSString stringWithFormat:@"播放完成: %@", [self.filename substringFromIndex:[self.filename rangeOfString:@"Documents"].location]];
}


-(void)emptyFunction{
    
    
    kDuration += 0.1f;
    NSLog(@"%f",kDuration);
    
    //更新一下页面的标签
    self.recordDuration.text = [NSString stringWithFormat:@"录音时长：%f 秒",kDuration];
    
    
}


#pragma mark - AVAudioRecorder Delegate Methods
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"录音停止");
    
    [self stopTimer];
    curCount = 0;
}
- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder{
    NSLog(@"录音开始");
    [self stopTimer];
    curCount = 0;
}
- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags{
    NSLog(@"录音中断");
    [self stopTimer];
    curCount = 0;
}
@end
