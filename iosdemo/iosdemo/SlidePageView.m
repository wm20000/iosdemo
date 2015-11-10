//
//  SlidePageView.m
//  iosdemo
//
//  Created by wangmo on 11/5/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "SlidePageView.h"

@interface SlidePageView ()

@property (weak, nonatomic) UIScrollView *myScrollView;
@property (weak, nonatomic) UIPageControl *myPageControl;
@property (strong, nonatomic) NSTimer *myTimer;
@end

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
        pageControl.pageIndicatorTintColor = [UIColor blueColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _myPageControl = pageControl;
        [self addSubview:_myPageControl];
    }
    return _myPageControl;
}

- (void) addTimer {
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(slidePageView) userInfo:nil repeats:YES];
}

- (void) removeTimer {

    [self.myTimer invalidate];
    self.myTimer = nil;
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

/**
 使用前后增加一个图片的方式实现无限循环 到达第一个/最后一个时用真正的图片替代它 方法简单 但占用内存多
 */
    + (SlidePageView *) SlidePageViewWithRect:(CGRect)rect andData:(NSArray *)data {
        
        SlidePageView *spv = [[SlidePageView alloc] initWithFrame:rect];
        
    //    增加头尾冗余数据
        NSMutableArray *temp = [NSMutableArray array];
        [temp addObject:data[data.count - 1]];
        for (int i = 0; i<data.count; i++) {
            [temp addObject:data[i]];
        }
        [temp addObject:data[0]];
        data = temp;
        
        float width = spv.frame.size.width;
        float height = spv.frame.size.height;
        
        spv.myScrollView.contentSize = CGSizeMake(width * data.count, 0);
        spv.myScrollView.pagingEnabled = YES;
        spv.myScrollView.showsHorizontalScrollIndicator = NO;
        spv.myScrollView.showsVerticalScrollIndicator = NO;
        spv.myScrollView.delegate = spv;
        spv.myScrollView.contentOffset = CGPointMake(width, 0);
        
        if (data.count > 0) {
            
            for (int i = 0; i< data.count; i++) {
                UIImage *img = [UIImage imageNamed:data[i]];
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
                imgView.image = img;
                [spv.myScrollView addSubview:imgView];
            }
            
            spv.myPageControl.center = CGPointMake(width / 2, height - 10);
            spv.myPageControl.numberOfPages = data.count - 2;
            spv.myPageControl.currentPage = 0;
        }
        
        [spv addTimer];
        
        return spv;
    }

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"scrollViewDidScroll");
   
    if (scrollView.contentOffset.x == 0) { //是第一张跳到最后一张
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - self.frame.size.width * 2, 0);
        self.myPageControl.currentPage = scrollView.contentSize.width / scrollView.frame.size.width - 2;
    } else if (scrollView.contentSize.width - scrollView.contentOffset.x == scrollView.frame.size.width) { //是最后一张跳到第一张
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        self.myPageControl.currentPage = 0;
    } else if (!(fmod(scrollView.contentOffset.x, scrollView.frame.size.width))) { //其它情况 整除时处理
        self.myPageControl.currentPage = scrollView.contentOffset.x / self.frame.size.width -1;
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
//    NSLog(@"scrollViewWillBeginDragging");
    [self removeTimer];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
//    NSLog(@"scrollViewDidEndDragging");
    [self addTimer];
}

@end
