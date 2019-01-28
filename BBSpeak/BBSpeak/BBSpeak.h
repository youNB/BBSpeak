//
//  BBSpeak.h
//  BBSpeak
//
//  Created by 程肖斌 on 2019/1/24.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BBSpeak : NSObject

//单例
+ (BBSpeak *)sharedManager;

//播放一段文本
- (void)speakString:(NSString *)words;

//播放系统音效
- (void)play:(SystemSoundID)ID;

//播放bundle里音效
- (void)play:(NSString *)name
        type:(NSString *)type;

//播放音乐
- (void)playFromFile:(NSString *)file;

- (void)playFromBundle:(NSString *)name
                  type:(NSString *)type;

- (void)playFromData:(NSData *)data;

@end

