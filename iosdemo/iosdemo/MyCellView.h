//
//  MyCellView.h
//  iosdemo
//
//  Created by wangmo on 10/30/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCellView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *myTitleView;
@property (weak, nonatomic) IBOutlet UILabel *myDetailView;

@end
