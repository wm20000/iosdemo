//
//  MyAnimationXIB.m
//  iosdemo
//
//  Created by wangmo on 12/1/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyAnimationXIB.h"

@interface MyAnimationXIB ()

@property (weak, nonatomic) IBOutlet UIView *myTarget;

@end

@implementation MyAnimationXIB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma -mark 基础动画
/**
 transform我们一般称为形变属性，其本质是通过矩阵变化改变控件的大小 位置 角度
 frame bounds center transform alpha backgroundColor contentStretch 这些改变后触发动画
 获得CGAffineTransform有多种方法，例如使用CGAffineTransformMake，但是对于矩阵操作相对比较麻烦，IOS准备了三个方法：
 CGAffineTransformMakeRotation（旋转）、CGAffineTransformMakeScale（缩放）、CGAffineTransformMakeTranslation（移动 每次都是以最初位置的中心点为参考）
 transform进行旋转、缩放、移动的时候不是在原来的基础上增量形变的，因此如果需要持续在原来的基础上旋转、缩放、移动那么每次需要在原来的基础上增加或减少 可以定义一个全局变量进行累加
 IOS提供三个对应的方法，分别用于在原来的角度、缩放、移动位置的基础上做出修改：CGAffineTransformRotate、CGAffineTransformScale、CGAffineTransformTranslate（每次都是以传入的transform为参照 既有叠加效果）
 CGAffineTransformIdentity 最初位置的中心点
 
 UIViewAnimationOptions
 在动画方法中有一个option参数，UIViewAnimationOptions类型，它是一个枚举类型，动画参数分为三类，可以组合使用：
 1.常规动画属性设置（可以同时选择多个进行设置）
 UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
 UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
 UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
 UIViewAnimationOptionRepeat：重复运行动画。
 UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点 前提是设置动画无限重复
 UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
 UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
 UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
 UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
 UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
 
 2.动画速度控制（可从其中选择一个设置）
 UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
 UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
 UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
 UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
 
 3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
 UIViewAnimationOptionTransitionNone：没有转场动画效果。
 UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
 UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
 UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。
 UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。
 UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
 UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。
 UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。
 */

- (IBAction)myTranslation:(id)sender {
    
    [UIView animateWithDuration:2 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.myTarget.transform = CGAffineTransformMakeTranslation(100, 100);
    } completion:^(BOOL finished) {
        self.myTarget.transform = CGAffineTransformIdentity; //结束后马上还原
    }];
}

/**
 旋转
 弧度：弧长等于半径的弧，其所对的圆心角为1弧度。(即两条射线从圆心向圆周射出，形成一个夹角和夹角正对的一段弧。当这段弧长正好等于圆的半径时，两条射线的夹角的弧度为1)。
 一周的弧度数为2πr/r=2π，360°角=2π弧度，因此，1弧度约为57.3°，即57°17'44.806''，1°为π/180弧度，近似值为0.01745弧度，周角为2π弧度，平角（即180°角）为π弧度，直角为π/2弧度。
 M_PI   pi
 M_PI_2 pi/2
 M_PI_4 pi/4
 M_1_PI 1/pi
 M_2_PI 2/pi
 */
- (IBAction)myRoation:(id)sender {
    
    [UIView animateWithDuration:2 animations:^{
        self.myTarget.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        self.myTarget.transform = CGAffineTransformIdentity; //结束后马上还原
    }];
}

- (IBAction)myScale:(id)sender {
    
    [UIView animateWithDuration:2 animations:^{
        self.myTarget.transform = CGAffineTransformMakeScale(3.0, 6.0);
    } completion:^(BOOL finished) {
        self.myTarget.transform = CGAffineTransformIdentity; //结束后马上还原
    }];
}

#pragma -mark 关键帧动画
/**
 关键帧动画就是在动画控制过程中开发者指定主要的动画状态，至于各个状态间动画如何进行则由系统自动运算补充（每两个关键帧之间系统形成的动画称为“补间动画”）
 这种动画的好处就是开发者不用逐个控制每个动画帧，而只要关心几个关键帧的状态即可。
 关键帧动画开发分为两种形式：一种是通过设置不同的属性值进行关键帧控制，另一种是通过绘制路径进行关键帧控制。后者优先级高于前者，如果设置了路径则属性值就不再起作用。
 
 UIViewKeyframeAnimationOptions类型，和上面基本动画参数设置有些差别，关键帧动画设置参数分为两类，可以组合使用：
 1.常规动画属性设置（可以同时选择多个进行设置）
 UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
 UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
 UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
 UIViewAnimationOptionRepeat：重复运行动画。
 UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点 前提是设置动画无限重复
 UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
 UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
 2.动画模式设置（同前面关键帧动画动画模式一一对应，可以从其中选择一个进行设置）
 UIViewKeyframeAnimationOptionCalculationModeLinear：连续运算模式。
 UIViewKeyframeAnimationOptionCalculationModeDiscrete ：离散运算模式。
 UIViewKeyframeAnimationOptionCalculationModePaced：均匀执行运算模式。
 UIViewKeyframeAnimationOptionCalculationModeCubic：平滑运算模式。
 UIViewKeyframeAnimationOptionCalculationModeCubicPaced：平滑均匀运算模式。
 注意：前面说过关键帧动画有两种形式，上面演示的是属性值关键帧动画，路径关键帧动画目前UIView还不支持。
 */
- (IBAction)myKeyFrame:(id)sender {
    
    [UIView animateKeyframesWithDuration:5 delay:0.5 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //第二个关键帧（准确的说第一个关键帧是开始位置）:从0秒开始持续50%的时间，也就是5.0*0.5=2.5秒
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            self.myTarget.center = CGPointMake(80.0, 220.0);
        }];
        //第三个关键帧，从0.5*5.0秒开始，持续5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            self.myTarget.center = CGPointMake(45.0, 300.0);
        }];
        //第四个关键帧：从0.75*5.0秒开始，持所需5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            self.myTarget.center = CGPointMake(100.0, 500.0);
        }];
    } completion:^(BOOL finished) {
        NSLog(@"Animation end");
    }];
}

@end
