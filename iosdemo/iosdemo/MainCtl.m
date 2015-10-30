//
//  MainCtl.m
//  iosdemo
//
//  Created by wangmo on 10/30/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MainCtl.h"

#define CELLID "myCell"

@interface MainCtl () <UITableViewDataSource>

@end

@implementation MainCtl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    [tableView registerNib:[UINib nibWithNibName:@"MyCellView" bundle:nil] forCellReuseIdentifier:@CELLID];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCellView *cell = [tableView dequeueReusableCellWithIdentifier:@CELLID];
    if (!cell) {
        cell = [[MyCellView alloc] init];
    }
    cell.myTitleView.text = self.tableData[indexPath.row];
    cell.myDetailView.text = self.tableData[indexPath.row];
    return cell;
}


@end
