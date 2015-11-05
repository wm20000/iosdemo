//
//  slidePageView.m
//  iosdemo
//
//  Created by wangmo on 11/4/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "SlidePageView.h"

@implementation SlidePageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib {
    
}

- (void) initSlidePageWith:(CGRect)rect andSlideData:(NSArray *)data {

    self.frame = rect;
    
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.contentSize = CGSizeMake(data.count * self.frame.size.width, 0);
    
    for (int i=0; i<data.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * rect.size.width, 0, rect.size.width, rect.size.height)];
//        imgView.clipsToBounds = NO;
        imgView.contentMode = UIViewContentModeScaleToFill;
        UIImage *img = [UIImage imageNamed:data[i]];
        imgView.image = img;
        [self.myScrollView addSubview:imgView];
    }
}

@end
