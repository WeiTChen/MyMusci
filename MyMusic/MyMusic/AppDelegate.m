//
//  AppDelegate.m
//  MyMusic
//
//  Created by William on 16/6/27.
//  Copyright © 2016年 William. All rights reserved.
//

#import "AppDelegate.h"
#import "MusicManage.h"

@interface AppDelegate ()<musicPlayDelegate>

@property (nonatomic,strong) NSTimer *checkMusicTimer;

@property (nonatomic,strong) MusicManage *manage;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.manage = [MusicManage shared];
    self.manage.delegate = self;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    [self.checkMusicTimer invalidate];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    //进入前台时播放(有的其他应用会暂停播放器,比如唱吧)
    [self.manage play];
}

//旧的item无法重用,也无法用于多个avpler,不管是Remove还是置为nil都不行,搞不懂苹果
- (void)checkMusic
{
    //当音乐播放完毕的时候,程序也就无法操作了,所以要提前操作
    MusicManage *manage = [MusicManage shared];
    if (manage.queuePlayer.items.count == 1)
    {
        [manage getItemsAry];
        [manage play];
    }
}


#pragma mark - musicPlayDelegate
//根据是否播放,来销毁和创建计时器
- (void)playerDidPlay
{
    self.checkMusicTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(checkMusic) userInfo:nil repeats:YES];
}

- (void)playerDidPause
{
    [self.checkMusicTimer invalidate];
}

@end
