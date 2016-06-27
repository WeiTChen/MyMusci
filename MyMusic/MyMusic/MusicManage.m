//
//  MusicManage.m
//  MyMusic
//
//  Created by William on 16/6/27.
//  Copyright © 2016年 William. All rights reserved.
//

#import "MusicManage.h"

@implementation MusicManage
{
    NSArray *musicItems;
}

+ (instancetype)shared
{
    static MusicManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [self alloc];
    });
    return manage;
}

- (AVQueuePlayer *)queuePlayer
{
    if (!_queuePlayer)
    {
        _queuePlayer = [AVQueuePlayer queuePlayerWithItems:musicItems];
    }
    return _queuePlayer;
}

- (void)getItemsAry
{
    NSMutableArray *itemsAry = [NSMutableArray array];
    NSArray *musicNameAry = @[@"徐佳莹,林俊杰 - 不为谁而作的歌",@"林俊杰 - 她说"];
    for (int i = 0; i < musicNameAry.count; i++)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:musicNameAry[i] ofType:@"mp3"];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:path]];
        [itemsAry addObject:item];
    }
    musicItems = itemsAry;
    for (int i = 0; i < itemsAry.count;i++)
    {
        if ([self.queuePlayer canInsertItem:itemsAry[i] afterItem:self.queuePlayer.items.lastObject])
        {
            [self.queuePlayer insertItem:itemsAry[i] afterItem:self.queuePlayer.items.lastObject];
        }
    }
}

- (void)play
{
    [self.queuePlayer play];
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerDidPlay)])
    {
        [self.delegate playerDidPlay];
    }
}

- (void)pause
{
    [self.queuePlayer pause];
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerDidPause)])
    {
        [self.delegate playerDidPause];
    }
}

@end
