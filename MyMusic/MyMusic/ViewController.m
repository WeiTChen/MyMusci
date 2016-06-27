//
//  ViewController.m
//  MyMusic
//
//  Created by William on 16/6/27.
//  Copyright © 2016年 William. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicManage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MusicManage *manage = [MusicManage shared];
    [manage getItemsAry];
    manage.queuePlayer.volume = 1;
    [manage play];
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
}



@end
