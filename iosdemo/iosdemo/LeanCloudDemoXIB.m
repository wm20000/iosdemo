//
//  LeanCloudDemoXIB.m
//  iosdemo
//
//  Created by wangmo on 12/14/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "LeanCloudDemoXIB.h"
#import <AVOSCloud/AVOSCloud.h>

@interface LeanCloudDemoXIB ()

@end

@implementation LeanCloudDemoXIB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)insertObject:(id)sender {
    
    AVObject *obj = [AVObject objectWithClassName:@"TestObject"];
    NSString *value = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    [obj setObject:value forKey:@"foo"];
//    [obj saveInBackground]; //主线程
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) { //后台线程 回调后可操作UI
        if (succeeded) {
            NSLog(@"save successed");
        } else {
            NSLog(@"save failed");
        }
    }];
}

- (IBAction)queryObject:(id)sender {
    
    AVQuery *query = [AVQuery queryWithClassName:@"TestObject"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (AVObject *obj in objects) {
                NSLog(@"id is %@ foo is %@", [obj objectForKey:@"objectId"], obj[@"foo"]); //两种写法
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (IBAction)deleteOjbect:(id)sender {
    
    AVQuery *query = [AVQuery queryWithClassName:@"TestObject"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (AVObject *obj in objects) {
                [obj deleteInBackground];
//                [obj removeObjectForKey:@"foo"]; //删除 AVObject 实例的单个属性 需要save生效
//                [obj saveInBackground];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
