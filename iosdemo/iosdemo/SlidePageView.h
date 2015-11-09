//
//  SlidePageView.h
//  iosdemo
//
//  Created by wangmo on 11/5/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidePageView : UIView <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *myScrollView;
@property (weak, nonatomic) UIPageControl *myPageControl;
@property (strong, nonatomic) NSTimer *myTimer;

+ (SlidePageView *) SlidePageViewWithRect: (CGRect) rect andData: (NSArray*) data;

@end
