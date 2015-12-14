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
    
    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
    NSString *value = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    [testObject setObject:value forKey:@"foo"];
    BOOL save = [testObject save];
    NSLog(@"LeanCloud TestObject save is %d", save);
}

- (IBAction)queryObject:(id)sender {
    
    AVQuery *query = [AVQuery queryWithClassName:@"TestObject"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (NSObject *obj in objects) {
            NSLog(@"%@", obj);
        }
    }];
}

@end
