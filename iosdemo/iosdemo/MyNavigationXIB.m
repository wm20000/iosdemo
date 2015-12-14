//
//  MyNavigationXIB.m
//  iosdemo
//
//  Created by wangmo on 12/10/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyNavigationXIB.h"

@interface MyNavigationXIB ()<UINavigationControllerDelegate, UINavigationBarDelegate>

@end
/**
 navigationItem是UIViewController的一个属性
 即navigation item在navigation Bar代表一个viewController 每一个加到navigationController的viewController都会有一个对应的navigationItem，该对象由viewController以懒加载的方式创建
 UIBarItem: UIBarItem类是一个可以放置在Bar之上的所有小控件类的抽象类。继承了该基类所有子类在外观上类似于一个Button，它们都有一个标题，图片，动作以及目标，这点可以从其子类的初始化方法处看到。
 UIBarButtonItem: 专门用来放在UIToolbar 或者 UINavigationBar的特殊button.基本行为跟button是一样的。另外从IOS5开始的Customizing Appearance 增加了一系列的方法调整显示。
 UINavigationItem: NSObject （包含了当前页面导航栏上需要显示的全部信息） title,prompt,titleView,leftBarButtonItem,rightBarButtonItem,backBarButonItem
 UINavigationBar :UIView NavigaitonBar就是导航栏，位于屏幕的上方，管理整个NavigationController的navigationItem，即类似navigationcontroller一样提供了一个栈来管理item。
 UINavigtionController :UIViewController 包含：viewcontrollers、navigationbar、toolbar
 navigationbar：UIView 包含：items(UINavigationItem)
 viewController 包含navigationitem，toolItem.  这两个属性控制了当前页面当前页面的navigationbar，toolbar的外观。
 navigationcontroller直接控制viewcontrollers，然后包含的navigationbar形成整个nv的导航栏，bar并包含整个navigationItem的栈,管理整个nv的navigationitem（ NSArray *items 属性）
 navigationItem包含了bar视图的全部元素（如title,tileview,backBarButtonItem等），受当前viewcontroller管理，即bar形成整个nv的导航视图，然后每个nv页面的导航栏元素由所在页面的navigationItem管理。
 即设置当前页面的左右barbutton，用 self.navigationItem.leftBarButtonItem等。
 */
@implementation MyNavigationXIB

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.delegate = self;
    
    //    如果当前VC指定了rightBarButtonItem的话，则显示指定的内容。
    //    如果当前VC没有指定rightBarButtonItem的话，则不显示任何东西。
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    self.navigationItem.rightBarButtonItem = right;
    
    //    如果当前的viewController设置了leftBarButtonItem，则显示当前VC所自带的leftBarButtonItem。
    //    如果当前的viewController没有设置leftBarButtonItem，且当前VC不是rootVC的时候，则显示前一层VC的backBarButtonItem。
    //    如果前一层的VC没有显示的指定backBarButtonItem的话，系统将会根据前一层VC的title属性自动生成一个back按钮，并显示出来。
    //    如果当前的viewController没有设置leftBarButtonItem，且当前VC已是rootVC的时候，左边将不显示任何东西。
    //    5.0中新增加了一个属性leftItemsSupplementBackButton，通过指定该属性为YES，可以让leftBarButtonItem和backBarButtonItem同时显示，其中leftBarButtonItem显示在backBarButtonItem的右边。
    self.navigationItem.leftItemsSupplementBackButton = YES;
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    self.navigationItem.leftBarButtonItem = left;
    
    //    backBar显示由上个ctl决定 当前设置只对下层有效
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    self.navigationItem.backBarButtonItem = back;
    //    添加prompt以后NavigationBar的高度会增加30，总的高度会变成74(不管当前方向是Portrait还是Landscape，此模式下navgationbar都使用高度44加上prompt30的方式进行显示)
    self.navigationItem.prompt = @"I'm prompt";
    
    //    如果当前VC通过 .navigationItem.titleView指定了自定义的titleView，系统将会显示指定的titleView，此处要注意自定义titleView的高度不要超过navigationBar的高度，否则会显示出界。
    //    如果当前VC没有指定titleView，系统则会根据当前VC的title或者当前VC的navigationItem.title的内容创建一个UILabel并显示，其中如果指定了navigationItem.title的话，则优先显示navigationItem.title的内容。
    //    self.navigationItem.titleView = view;
    self.navigationItem.title = @"I'm title";
    
    //    配置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowColor = [UIColor lightGrayColor];
    shadow.shadowBlurRadius = 0.5;
    
    //    配置字体
    UIFont *font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:20.0];
    
    NSArray *objects = [NSArray arrayWithObjects:[UIColor redColor], shadow, font, nil];
    NSArray *keys = [NSArray arrayWithObjects:NSForegroundColorAttributeName, NSShadowAttributeName, NSFontAttributeName, nil];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //    控制navigation宽高 高度不生效
    //    CGRect frame = CGRectMake(0, 0, 400, 400);
    //    self.navigationController.navigationBar.frame = frame;
    
    //    控制是否显示toolbar
    self.navigationController.toolbarHidden = NO;
    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
    UIBarButtonItem *three = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    UIBarButtonItem *four = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
    //    间距
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *array = [NSArray arrayWithObjects:one, two, flexItem, three, four, nil];
    [self setToolbarItems:array animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSLog(@"will show");
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSLog(@"did show");
}

- (void) test {
    
}
@end
