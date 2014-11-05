//
//  ViewController.h
//  Clint.DrawTell
//
//  Created by Clintlin on 14/10/31.
//  Copyright (c) 2014年 JoinUs.Clint.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VoiceRecorderBase.h"

@interface ViewController : VoiceRecorderBase
<
    AVAudioRecorderDelegate,
    AVAudioPlayerDelegate
>

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;


@property (strong, nonatomic) IBOutlet UIBarButtonItem *recordButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *stopButton;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *playButton;
- (IBAction)recordStart:(id)sender;
- (IBAction)recordStop:(id)sender;
- (IBAction)recordPlay:(id)sender;

@end

