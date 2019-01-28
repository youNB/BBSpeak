//
//  BBSpeak.m
//  BBSpeak
//
//  Created by 程肖斌 on 2019/1/24.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import "BBSpeak.h"

@interface BBSpeak()<AVSpeechSynthesizerDelegate>
@property(nonatomic, strong) AVSpeechSynthesizer *speech;
@property(nonatomic, strong) AVAudioPlayer *audio_player;
@end

@implementation BBSpeak

//单例
+ (BBSpeak *)sharedManager{
    static BBSpeak *manager       = nil;
    static dispatch_once_t once_t = 0;
    dispatch_once(&once_t, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (instancetype)init{
    if([super init]){
        AVAudioSession *session = AVAudioSession.sharedInstance;
        [session setCategory:AVAudioSessionCategoryPlayback
                 withOptions:AVAudioSessionCategoryOptionDuckOthers
                       error:nil];
        [session setActive:YES error:nil];
        
        self.speech = [[AVSpeechSynthesizer alloc]init];
        self.speech.delegate = self;
    }
    return self;
}

//获取音乐播放器，进行设置
- (AVAudioPlayer *)audioPlayer{
    return self.audio_player;
}

//播放一段文本
- (void)speakString:(NSString *)words{
    AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:words];
    [aUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
    
    //iOS语音合成在iOS8及以下版本系统上语速异常/iOS8设置为0.15
    if(@available(iOS 8.0, *)){}
    else{aUtterance.rate = 0.15;}
    
    [self.speech speakUtterance:aUtterance];
}

//播放系统音效
- (void)play:(SystemSoundID)ID{
    AudioServicesPlaySystemSound(ID);
}

//播放bundle里音效
- (void)play:(NSString *)name
        type:(NSString *)type{
    @try {
        NSString *path = [NSBundle.mainBundle pathForResource:name
                                                       ofType:type];
        SystemSoundID ID = 0;
        NSURL *URL = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, &ID);
        AudioServicesPlaySystemSound(ID);
    } @catch (NSException *exception) {} @finally {}
}

//播放音乐
- (void)playFromFile:(NSString *)file{
    @try {
        NSURL *URL  = [NSURL fileURLWithPath:file];
        self.audio_player = [[AVAudioPlayer alloc]initWithContentsOfURL:URL
                                                                  error:nil];
        [self.audio_player stop];
        [self.audio_player prepareToPlay];
        [self.audio_player play];
    } @catch (NSException *exception) {} @finally {}
}

- (void)playFromBundle:(NSString *)name
                  type:(NSString *)type{
    @try {
        NSString *path = [NSBundle.mainBundle pathForResource:name
                                                       ofType:type];
        NSURL *URL = [NSURL fileURLWithPath:path];
        self.audio_player = [[AVAudioPlayer alloc]initWithContentsOfURL:URL
                                                                  error:nil];
        [self.audio_player stop];
        [self.audio_player prepareToPlay];
        [self.audio_player play];
    } @catch (NSException *exception) {} @finally {}
}

- (void)playFromData:(NSData *)data{
    @try {
        [self.audio_player stop];
        self.audio_player = [[AVAudioPlayer alloc]initWithData:data
                                                         error:nil];
        [self.audio_player prepareToPlay];
        [self.audio_player play];
    } @catch (NSException *exception) {} @finally {}
}

@end
