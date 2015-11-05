//
//  slidePageView.h
//  iosdemo
//
//  Created by wangmo on 11/4/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidePageView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) NSArray *data;

- (void) initSlidePageWith:(CGRect) rect andSlideData:(NSArray*) data;
@end
