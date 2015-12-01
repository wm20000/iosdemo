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
                      @"MyAnimationXIB,TransformAnimation,形变动画",
                      @"MyTransitionAnimXIB,TransitionAnimation,转场动画",
                      nil];
}


@end
