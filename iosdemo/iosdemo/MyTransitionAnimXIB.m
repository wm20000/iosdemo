//
//  MyTransitionAnim.m
//  iosdemo
//
//  Created by wangmo on 12/1/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyTransitionAnimXIB.h"

@interface MyTransitionAnimXIB ()

@property (weak, nonatomic) IBOutlet UIImageView *myTarget;
@property int index;

@end

@implementation MyTransitionAnimXIB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    添加手势
    UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    self.index = 1;
    NSLog(@"%d", self.index);
    self.myTarget.image = [UIImage imageNamed:@"spi1"];
}

#pragma -mark 转场动画
/**
 UIViewAnimationOptionTransition
 UIViewAnimationOptionTransitionNone            //无转场动画
 UIViewAnimationOptionTransitionFlipFromLeft    //转场从左翻转
 UIViewAnimationOptionTransitionFlipFromRight   //转场从右翻转
 UIViewAnimationOptionTransitionCurlUp          //上卷转场
 UIViewAnimationOptionTransitionCurlDown        //下卷转场
 UIViewAnimationOptionTransitionCrossDissolve   //转场交叉消失
 UIViewAnimationOptionTransitionFlipFromTop     //转场从上翻转
 UIViewAnimationOptionTransitionFlipFromBottom  //转场从下翻转
 */
- (void)transitionAnimation:(BOOL)isNext {
    
    UIViewAnimationOptions option;
    if (isNext) {
        option = UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionTransitionCurlUp;
    } else {
        option = UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromLeft;
    }
    
    [UIView transitionWithView:self.myTarget duration:1.0 options:option animations:^{
        self.myTarget.image= [self getImage:isNext];
    } completion:nil];
}

#pragma mark 向左滑动浏览下一张图片
- (void)leftSwipe:(UISwipeGestureRecognizer *)gesture {
    
    [self transitionAnimation:YES];
}

#pragma mark 向右滑动浏览上一张图片
- (void)rightSwipe:(UISwipeGestureRecognizer *) gesture {
    
    [self transitionAnimation:NO];
}

#pragma mark 取得当前图片
- (UIImage *)getImage:(BOOL)isNext{
    
    if (isNext) {
        if (self.index > 4) {
            self.index = 1;
        } else {
            self.index++;
        }
    } else {
        if (self.index < 2) {
            self.index = 5;
        } else {
            self.index--;
        }
    }
    NSLog(@"%d", self.index);
    NSString *imageName = [NSString stringWithFormat:@"spi%d",self.index];
    return [UIImage imageNamed:imageName];
}


@end
