//
//  MyQuartz2DView.m
//  iosdemo
//
//  Created by wangmo on 11/13/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyQuartz2DView.h"

@implementation MyQuartz2DView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    drawTriangle();
    drawRectangle();
    drawCircle();
    
}

//圆形
void drawCircle() {
    
    [[UIColor blueColor] set];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextFillEllipseInRect(ctx, CGRectMake(140, 20, 50, 30));
}

//矩形
void drawRectangle() {
    
    [[UIColor yellowColor] set];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextFillRect(ctx, CGRectMake(80, 10, 50, 25));
}

//三角形
void drawTriangle() {

    [[UIColor redColor] set];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 10, 10);
    CGContextAddLineToPoint(ctx, 30, 50);
    CGContextAddLineToPoint(ctx, 70, 30);
    CGContextClosePath(ctx);
//    CGContextStrokePath(ctx);
    CGContextFillPath(ctx);
}

@end
