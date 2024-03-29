//
//  voiceRecordBase.h
//  Clint.DrawTell
//
//  Created by Clintlin on 14/11/3.
//  Copyright (c) 2014年 JoinUs.Clint.Lin. All rights reserved.
//
//  该原版本来自 Jeans on 3/23/13.    http://my.oschina.net/jeans/blog/69937

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AudioToolbox/AudioToolbox.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>


//默认最大录音时间
#define kDefaultMaxRecordTime               60

@protocol VoiceRecorderBaseDelegate <NSObject>

//录音完成回调，返回文件路径和文件名
- (void)VoiceRecorderBaseRecordFinish:(NSString *)_filePath fileName:(NSString*)_fileName;

@end

@interface VoiceRecorderBase : UIViewController{
    
@protected
    NSInteger               maxRecordTime;  //最大录音时间
    NSString                *recordFileName;//录音文件名
    NSString                *recordFilePath;//录音文件路径
}

@property (assign, nonatomic)           id<VoiceRecorderBaseDelegate> vrbDelegate;

@property (assign, nonatomic)           NSInteger               maxRecordTime;//最大录音时间
@property (copy, nonatomic)             NSString                *recordFileName;//录音文件名
@property (copy, nonatomic)             NSString                *recordFilePath;//录音文件路径

/**
 生成当前时间字符串
 @returns 当前时间字符串
 */
+ (NSString*)getCurrentTimeString;

/**
 获取缓存路径
 @returns 缓存路径
 */
+ (NSString*)getCacheDirectory;

/**
 判断文件是否存在
 @param _path 文件路径
 @returns 存在返回yes
 */
+ (BOOL)fileExistsAtPath:(NSString*)_path;

/**
 删除文件
 @param _path 文件路径
 @returns 成功返回yes
 */
+ (BOOL)deleteFileAtPath:(NSString*)_path;


#pragma mark -

/**
 生成文件路径
 @param _fileName 文件名
 @param _type 文件类型
 @returns 文件路径
 */
+ (NSString*)getPathByFileName:(NSString *)_fileName;
+ (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type;

/**
 获取录音设置
 @returns 录音设置
 */
+ (NSDictionary*)getAudioRecorderSettingDict;

/**
 获取文件大小
 @returns 文件大小
 */
+ (NSInteger) getFileSize:(NSString*) path;
@end

