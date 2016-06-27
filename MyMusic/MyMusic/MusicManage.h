//
//  MusicManage.h
//  MyMusic
//
//  Created by William on 16/6/27.
//  Copyright © 2016年 William. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class musicPlayDelegate;

@protocol musicPlayDelegate <NSObject>

- (void)playerDidPlay;

- (void)playerDidPause;

@end

@interface MusicManage : NSObject

@property (nonatomic,strong) AVQueuePlayer *queuePlayer;

@property (nonatomic,weak) id<musicPlayDelegate> delegate;

+ (instancetype)shared;

- (void)getItemsAry;

- (void)play;

- (void)pause;

@end
