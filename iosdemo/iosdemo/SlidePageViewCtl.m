//
//  SlidePageViewCtl.m
//  iosdemo
//
//  Created by wangmo on 11/4/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "SlidePageViewCtl.h"
#import "SlidePageView.h"

@interface SlidePageViewCtl ()

@end

@implementation SlidePageViewCtl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    是否会让出64高度（statusbar+tabbar） 默认YES
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self addPageView];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self addPageView];
}

- (void) viewWillAppear:(BOOL)animated {
    
//    [self addPageView];
}

- (void) addPageView {

    CGRect rect = self.view.frame;
    float width = rect.size.width;
    float height = rect.size.height;
    
    NSArray *data = [NSArray arrayWithObjects:@"spi4", @"spi2", @"spi3", nil];
    SlidePageView *spv = [SlidePageView SlidePageViewWithRect:CGRectMake(0, 64, width, height / 4) andData:data];
    [self.view addSubview:spv];
}

@end
