//
//  ScrollLayoutWithStoryBoardCtl.m
//  iosdemo
//
//  Created by wangmo on 11/3/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "ScrollLayoutWithStoryBoardCtl.h"

@interface ScrollLayoutWithStoryBoardCtl ()

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *myView1;
@property (weak, nonatomic) IBOutlet UIView *myView2;

@end

@implementation ScrollLayoutWithStoryBoardCtl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//subView布局时调用
- (void) viewDidLayoutSubviews {
    
    CGFloat maxY = CGRectGetMaxY(self.myView2.frame);
    NSLog(@"max Y is %lf", maxY);
    self.myScrollView.contentSize = CGSizeMake(0, maxY);
    self.myScrollView.contentInset = UIEdgeInsetsMake(0, 0, 9, 0);
}

@end
