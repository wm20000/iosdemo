//
//  MyTimerXIB.m
//  iosdemo
//
//  Created by wangmo on 12/3/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyTimerXIB.h"

@interface MyTimerXIB ()

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (strong, nonatomic) NSTimer *timer;
@property int count;

@end

@implementation MyTimerXIB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) initTimer {
    
//    创建一个定时器，自动加入到当前运行循环中，这样初始化一个定时器时，在(NSTimeInterval)seconds 时间之后，自动启动定时器
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startCount) userInfo:nil repeats:YES];
    self.timer = t;
    self.count = 10;
    
    /*
     创建一个定时器，不会像上面加入运行循环中 必须手工加入 效果等同于上面
     NSTimer *tt = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(startCount) userInfo:nil repeats:YES];
     self.timer = tt;
     NSRunLoop *rl = [NSRunLoop currentRunLoop];
     [rl addTimer:self.timer forMode:NSDefaultRunLoopMode];
     [self.timer fire]; //fire并不是启动一个定时器 只是提前触发定时器，而不影响之前的那个定时器设置的时间
     */
}

- (IBAction)start:(id)sender {
    
    if (!self.timer || self.count <= 0) {
        [self initTimer];
    } else {
        if (self.timer.isValid) {
            [self.timer setFireDate:[NSDate date]];
        }
    }
}

- (IBAction)pause:(id)sender {
    
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]]; //设置执行时间为无限远 一种暂停的做法
    }
}

- (void) startCount {
    
    if (self.count >= 0) {
        self.countdownLabel.text = [NSString stringWithFormat:@"%d", self.count--];
    } else {
        [self.timer invalidate]; //唯一的可以把timer从runloop移除的方法 timer会被释放掉
    }
}

@end
