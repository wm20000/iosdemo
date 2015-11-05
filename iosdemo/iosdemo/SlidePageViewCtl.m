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
    
    CGRect rect = self.view.frame;
    float width = rect.size.width;
    float height = rect.size.height;
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SlidePageView" owner:self options:nil];
    SlidePageView *sv = [array lastObject];
    
    NSArray *data = [NSArray arrayWithObjects:@"spi1", @"spi2", @"spi3", nil];
//    [sv initSlidePageWith:CGRectMake(0, 0, width, height/3) andSlideData:data];
    [self.view addSubview:sv];
}

@end
