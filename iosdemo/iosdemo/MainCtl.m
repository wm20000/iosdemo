//
//  MainCtl.m
//  iosdemo
//
//  Created by wangmo on 10/30/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MainCtl.h"
#import "ScrollViewLayoutCtl.h"

#define CELLID "myCell"

@interface MainCtl () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MainCtl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    [tableView registerNib:[UINib nibWithNibName:@"MyCellView" bundle:nil] forCellReuseIdentifier:@CELLID];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCellView *cell = [tableView dequeueReusableCellWithIdentifier:@CELLID];
    if (!cell) {
        cell = [[MyCellView alloc] init];
    }
    NSString *content = self.tableData[indexPath.row];
    if ([content containsString:@","]) {
        cell.myTitleView.text = [content componentsSeparatedByString:@","][0];
        cell.myDetailView.text = [content componentsSeparatedByString:@","][1];
    } else {
        cell.myTitleView.text = content;
    }

    return cell;
}

#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.tableData.count > 0) {
        NSString *content = self.tableData[indexPath.row];
        if ([content containsString:@","]) {
            content = [content componentsSeparatedByString:@","][0];
        }
        UIViewController *ctl = [[self storyboard] instantiateViewControllerWithIdentifier:content];
        [[self navigationController] pushViewController:ctl animated:YES];
    }
}


@end
