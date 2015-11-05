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

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imgView;
}

-(void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

@end
