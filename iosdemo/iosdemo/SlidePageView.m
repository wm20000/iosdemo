//
//  SlidePageView.m
//  iosdemo
//
//  Created by wangmo on 11/5/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "SlidePageView.h"

@implementation SlidePageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib {
    
    NSLog(@"awakeFromNib");
}

- (UIScrollView *) myScrollView {
    
    if (!_myScrollView) {
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:rect];
        _myScrollView = sv;
        [self addSubview:_myScrollView];
    }
    return _myScrollView;
}

- (UIPageControl *) myPageControl {
    
    if (!_myPageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.pageIndicatorTintColor = [UIColor blackColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _myPageControl = pageControl;
        [self addSubview:_myPageControl];
    }
    return _myPageControl;
}

- (void) setTimer {
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(slidePageView) userInfo:nil repeats:YES];
}

- (void) slidePageView {
    
    CGPoint point = CGPointMake([self getNextPageNum] * self.frame.size.width, 0);
    [self.myScrollView setContentOffset:point animated:YES];
}

- (int) getNextPageNum {
    
    int page = self.myScrollView.contentOffset.x / self.frame.size.width;
    if (page == self.myScrollView.contentSize.width / self.frame.size.width -1) {
        return 0;
    }
    return page + 1;
}

- (void) destroyTimer {
    
    [self.myTimer invalidate];
    self.myTimer = nil;
}

+ (SlidePageView *) SlidePageViewWithRect:(CGRect)rect andData:(NSArray *)data {
    
    
    
    SlidePageView *spv = [[SlidePageView alloc] initWithFrame:rect];
    if (data.count > 0) {
        float width = spv.frame.size.width;
        float height = spv.frame.size.height;
        
        spv.myScrollView.contentSize = CGSizeMake(width * data.count, 0);
        spv.myScrollView.pagingEnabled = YES;
        spv.myScrollView.showsHorizontalScrollIndicator = NO;
        spv.myScrollView.showsVerticalScrollIndicator = NO;
        spv.myScrollView.delegate = spv;
        
        for (int i = 0; i< data.count; i++) {
            UIImage *img = [UIImage imageNamed:data[i]];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
            imgView.image = img;
            [spv.myScrollView addSubview:imgView];
        }
        
        spv.myPageControl.center = CGPointMake(width / 2, height - 10);
        spv.myPageControl.numberOfPages = data.count;
        spv.myPageControl.currentPage = 0;
    }
    
    [spv setTimer];
    
    return spv;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSLog(@"scrollViewDidScroll");
//    NSLog(@"%f, %f", self.myScrollView.contentOffset.x, self.myScrollView.frame.size.width);
    if (!(fmod(self.myScrollView.contentOffset.x, self.myScrollView.frame.size.width))) {
        int index = self.myScrollView.contentOffset.x / self.myScrollView.frame.size.width;
        self.myPageControl.currentPage = index;
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    NSLog(@"scrollViewWillBeginDragging");
    [self destroyTimer];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    NSLog(@"scrollViewDidEndDragging");
    [self setTimer];
}

@end
