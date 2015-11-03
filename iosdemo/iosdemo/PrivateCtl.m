//
//  PrivateCtl.m
//  iosdemo
//
//  Created by wangmo on 10/30/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "PrivateCtl.h"

@implementation PrivateCtl

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableData = [[NSArray alloc] initWithObjects:
                      @"ScrollViewLayoutCtl,ScrollViewLayout,StoryBoard布局",
                      @"ScrollViewLayoutXIB,ScrollViewLayout,XIB布局", nil];
}

@end
