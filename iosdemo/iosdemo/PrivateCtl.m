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
                      @"SlidePageViewCtl,SlidePageView,图片轮播器",
                      @"ScrollViewZoomCtl,ScrollViewZoom,ScrollView缩放功能",
                      @"ScrollViewLayoutCtl,ScrollViewLayout,StoryBoard布局",
                      @"ScrollViewLayoutXIB,ScrollViewLayout,XIB布局",
                      @"MyWebViewXIB,WebView,简单浏览器",
                      @"MyImageLoaderXIB,ImgDownloader,图片下载&显示",
                      nil];
}

@end
