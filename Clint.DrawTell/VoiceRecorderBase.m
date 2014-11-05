//
//  voiceRecordBase.m
//  Clint.DrawTell
//
//  Created by Clintlin on 14/11/3.
//  Copyright (c) 2014年 JoinUs.Clint.Lin. All rights reserved.
//

#import "VoiceRecorderBase.h"

@interface VoiceRecorderBase ()
@end

@implementation VoiceRecorderBase
@synthesize vrbDelegate,maxRecordTime,recordFileName,recordFilePath;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        maxRecordTime = kDefaultMaxRecordTime;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
	生成当前时间字符串
	@returns 当前时间字符串
 */
+ (NSString*)getCurrentTimeString
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}


/**
	获取缓存路径
	@returns 缓存路径
 */
+ (NSString*)getCacheDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //return [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Voice"];
}

/**
	判断文件是否存在
	@param _path 文件路径
	@returns 存在返回yes
 */
+ (BOOL)fileExistsAtPath:(NSString*)_path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:_path];
}

/**
	删除文件
	@param _path 文件路径
	@returns 成功返回yes
 */
+ (BOOL)deleteFileAtPath:(NSString*)_path
{
    return [[NSFileManager defaultManager] removeItemAtPath:_path error:nil];
}

/**
	生成文件路径
	@param _fileName 文件名
	@param _type 文件类型
	@returns 文件路径
 */
+ (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type
{
    NSString* fileDirectory = [[[VoiceRecorderBase getCacheDirectory]stringByAppendingPathComponent:_fileName]stringByAppendingPathExtension:_type];
    return fileDirectory;
}

/**
 生成文件路径
 @param _fileName 文件名
 @returns 文件路径
 */
+ (NSString*)getPathByFileName:(NSString *)_fileName{
    NSString* fileDirectory = [[VoiceRecorderBase getCacheDirectory]stringByAppendingPathComponent:_fileName];
    return fileDirectory;
}


#pragma mark - 获取文件大小
+ (NSInteger) getFileSize:(NSString*) path{
    NSFileManager * filemanager = [[NSFileManager alloc]init];
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
        return  [theFileSize intValue];
        else
        return -1;
    }
    else{
        return -1;
    }
}

/**
	获取录音设置
	@returns 录音设置
 */
+ (NSDictionary*)getAudioRecorderSettingDict
{
    // 要降低文件大小的话，可以使用下面注销的参数
    //AVFormatIDKey -> kAudioFormatMPEG4AAC
    //AVEncoderAudioQualityKey -> AVAudioQualityMin
    NSDictionary *recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                                   [NSNumber numberWithFloat:4100.0], AVSampleRateKey,
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   nil];
    
    
//    [[NSDictionary alloc] initWithObjectsAndKeys:
//                                   [NSNumber numberWithFloat: 1000.0],AVSampleRateKey, //采样率
//                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
//                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
//                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
//                                   //[NSNumber numberWithInt:16], AVEncoderBitRateKey,
//                                   //[NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
//                                   // [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
//                                   // [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
//                                   [NSNumber numberWithInt: AVAudioQualityMin],AVEncoderAudioQualityKey,//音频编码质量
//                                   nil];
    return recordSetting;
}


@end