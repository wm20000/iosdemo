//
//  ScrollViewZoomCtl.m
//  iosdemo
//
//  Created by wangmo on 11/3/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "ScrollViewZoomCtl.h"

@interface ScrollViewZoomCtl () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end

/**
 UIScrollView属性
 CGPoint contentOffSet                    监控目前滚动的位置
 CGSize contentSize                       滚动范围的大小
 UIEdgeInsets contentInset                视图在scrollView中的位置
 id<UIScrollerViewDelegate> delegate      设置协议
 BOOL directionalLockEnabled              指定控件是否只能在一个方向上滚动
 BOOL bounces                             控制控件遇到边框是否反弹
 BOOL alwaysBounceVertical                控制垂直方向遇到边框是否反弹
 BOOL alwaysBounceHorizontal              控制水平方向遇到边框是否反弹
 BOOL pagingEnabled                       控制控件是否整页翻动
 BOOL scrollEnabled                       控制控件是否能滚动
 BOOL showsHorizontalScrollIndicator      控制是否显示水平方向的滚动条
 BOOL showsVerticalScrollIndicator        控制是否显示垂直方向的滚动条
 UIEdgeInsets scrollIndicatorInsets       指定滚动条在scrollerView中的位置
 UIScrollViewIndicatorStyleindicatorStyle 设定滚动条的样式
 float decelerationRate                   改变scrollerView的减速点位置
 BOOL tracking                            监控当前目标是否正在被跟踪
 BOOL dragging                            监控当前目标是否正在被拖拽
 BOOL decelerating                        监控当前目标是否正在减速
 BOOL delaysContentTouches                控制视图是否延时调用开始滚动的方法
 BOOL canCancelContentTouches             控制控件是否接触取消touch的事件
 float minimumZoomScale                   缩小的最小比例
 float maximumZoomScale                   放大的最大比例
 float zoomScale                          设置变化比例
 BOOL bouncesZoom                         控制缩放的时候是否会反弹
 BOOL zooming                             判断控件的大小是否正在改变
 BOOL zoomBouncing                        判断是否正在进行缩放反弹
 BOOL scrollsToTop                        控制控件滚动到顶部
 */
@implementation ScrollViewZoomCtl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImage *img = [UIImage imageNamed:@"bigimg.jpg"];
    self.imgView = [[UIImageView alloc] initWithImage:img];
    [self.myScrollView addSubview:self.imgView];
    self.myScrollView.contentSize = img.size;
    
    self.myScrollView.delegate = self;
    self.myScrollView.minimumZoomScale = 0.01;
    self.myScrollView.maximumZoomScale = 2;
}

#pragma mark -UIScrollViewDelegate
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
//    NSLog(@" scrollViewDidScroll");
    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewWillBeginDragging");
}

//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    NSLog(@"scrollViewDidEndDragging");
}

//将开始降速时
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewWillBeginDecelerating");
}

//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewDidEndDecelerating");
}

//滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewDidEndScrollingAnimation");
}

//如果你不是完全滚动到滚轴视图的顶部，你可以轻点状态栏，那个可视的滚轴视图会一直滚动到顶部，那是默认行为，你可以通过该方法返回NO来关闭它
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewShouldScrollToTop");
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewDidScrollToTop");
}

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imgView;
}

-(void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

@end
