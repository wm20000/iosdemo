//
//  MyLayerXIB.m
//  iosdemo
//
//  Created by wangmo on 12/1/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyLayerXIB.h"

@interface MyLayerXIB ()

@property (weak, nonatomic) IBOutlet UIView *layer1;
@property (weak, nonatomic) IBOutlet UIView *layer2;

@end

/**
 UIView之所以能显示在屏幕上，完全是因为它内部的一个图层，在创建UIView对象时，UIView内部会自动创建一个图层(即CALayer对象)，通过UIView的layer属性可以访问这个层
 当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的图层上，绘图完毕后，系统会将图层拷贝到屏幕上，于是就完成了UIView的显示
 */
@implementation MyLayerXIB

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    边框
    self.layer1.layer.borderWidth = 5;
//    UI框架和CA框架不能混用 layer中不能直接接受UI框架中的东西
    self.layer1.layer.borderColor = [[UIColor redColor] CGColor];
//    圆角
    self.layer1.layer.cornerRadius = 20;
//    阴影
    self.layer1.layer.shadowColor = [[UIColor blackColor] CGColor];
//    设置阴影的偏移量，如果为正数，则代表为往右边 下边 偏移
    self.layer1.layer.shadowOffset = CGSizeMake(10, 10);
    self.layer1.layer.shadowOpacity = 0.6;
    
//    contents是id类型，可以接受内容，上面的实例让layer显示一张图片
    self.layer2.layer.cornerRadius = 50;
    self.layer2.layer.contents = (id) [UIImage imageNamed:@"spi1"].CGImage;
//    img方角遮住了layer得圆角 设置超出部分裁剪即可
    self.layer2.layer.masksToBounds = YES;
//    UI框架使用的方法
//    self.customView.clipsToBounds=YES;
}

@end
