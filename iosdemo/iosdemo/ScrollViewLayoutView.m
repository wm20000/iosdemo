//
//  ScrollViewLayoutView.m
//  iosdemo
//
//  Created by wangmo on 11/2/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "ScrollViewLayoutView.h"

@implementation ScrollViewLayoutView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib {
    
    NSLog(@"awakeFromNib");
    NSLog(@"new scroll height is %lf", CGRectGetMaxY(self.myButton7.frame));
    self.myScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.myButton7.frame));
    self.myScrollView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
}

@end
