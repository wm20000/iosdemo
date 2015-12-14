//
//  ComponentCtl.m
//  iosdemo
//
//  Created by wangmo on 11/13/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "ComponentCtl.h"

@interface ComponentCtl ()

@end

@implementation ComponentCtl

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableData = [[NSArray alloc] initWithObjects:
                      @"MyQuartz2DCtl,Quartz2D,绘图示例",
                      @"MyLayerXIB,Layer,层",
                      @"MyNSURLSessionXIB,NSURLSession,网络请求",
                      @"MyGCDXIB,GCD,多线程",
                      @"MyNSOperationXIB,NSOperation,多线程",
                      @"MyAnimationXIB,TransformAnimation,形变动画",
                      @"MyTransitionAnimXIB,TransitionAnimation,转场动画",
                      @"MyTimerXIB,NSTimer,NSTimer应用",
                      @"MyFileManagerXIB,FileManager,文件应用",
                      @"MyNavigationXIB,Navigation,导航栏应用",
                      nil];
}


@end
