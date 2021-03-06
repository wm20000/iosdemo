//
//  ScrollLayoutWithStoryBoardCtl.m
//  iosdemo
//
//  Created by wangmo on 11/3/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "ScrollViewLayoutCtl.h"

@interface ScrollViewLayoutCtl ()

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *myView1;
@property (weak, nonatomic) IBOutlet UIView *myView2;

@end

@implementation ScrollViewLayoutCtl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void) viewDidLayoutSubviews {
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self resizeScrollView];
}

- (void) resizeScrollView {
    
    CGFloat maxY = CGRectGetMaxY(self.myView2.frame);
//    NSLog(@"max Y is %lf", maxY);
    self.myScrollView.contentSize = CGSizeMake(0, maxY);
    self.myScrollView.contentInset = UIEdgeInsetsMake(0, 0, 9, 0);
}

@end
