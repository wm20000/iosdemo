//
//  ScrollVIewLayoutWithXIB.m
//  iosdemo
//
//  Created by wangmo on 11/3/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "ScrollViewLayoutWithXIB.h"

@interface ScrollViewLayoutWithXIB ()

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIView *myContainerView;
@property (weak, nonatomic) IBOutlet UIView *myView1;
@property (weak, nonatomic) IBOutlet UIView *myView2;

@end

@implementation ScrollViewLayoutWithXIB

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self resizeScrollView];
}

- (void) resizeScrollView {
    
    CGFloat maxY = CGRectGetMaxY(self.myView2.frame);
    NSLog(@"%lf", maxY);
    self.myScrollView.contentSize = CGSizeMake(0, maxY);
    self.myScrollView.contentInset = UIEdgeInsetsMake(64, 0, 9, 0);
}

@end
