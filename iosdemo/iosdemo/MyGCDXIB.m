//
//  MyGCDXIB.m
//  iosdemo
//
//  Created by wangmo on 12/10/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyGCDXIB.h"

@interface MyGCDXIB ()

@end

/**
 NSOperation是基于OC实现的，NSOperation以面向对象的方式封装了需要执行的操作，不必关心线程管理、同步等问题。
 NSOperation是一个抽象基类，iOS提供了两种默认实现：NSInvocationOperation和NSBlockOperation，当然也可以自定义NSOperation
 NSOperation不区分串行\并行队列
 */
@implementation MyGCDXIB

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self NSODemo1];
}

- (void) NSODemo3 {
    
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片 %@", [NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"修饰图片 %@", [NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"保存图片 %@", [NSThread currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"更新UI %@", [NSThread currentThread]);
    }];
    
//    设定执行顺序, Dependency依赖，可能会开多个，但不会太多 依赖关系是可以跨队列的 好用的方法
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [op4 addDependency:op3];
    
    [q addOperation:op1];
    [q addOperation:op2];
    [q addOperation:op3];
    [[NSOperationQueue mainQueue] addOperation:op4]; //在主线程上进行UI的更新
}

- (void) NSODemo2 {
    
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    for (int i=0; i<10; i++) {
        NSInvocationOperation *io = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation:) object:[NSNumber numberWithInt:i]];
        [q addOperation:io]; //多子线程 并发执行
//        [[NSOperationQueue mainQueue] addOperation:io]; //主线程 顺序执行
        
    }
}

- (void) NSODemo1 {
    
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [q setMaxConcurrentOperationCount:2]; //设置最大线程数 不是很准确 并发时容易hold不住
    for (int i=0; i<10; i++) {
        [q addOperationWithBlock:^{ //多子线程 并发执行
            NSLog(@"%@ %d", [NSThread currentThread], i);
        }];
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{ //主线程 顺序执行
//            NSLog(@"%@ %d", [NSThread currentThread], i);
//        }];
        
    }
}

- (void) operation:(id)param {
    
    NSLog(@"%@ %@", [NSThread currentThread], param);
}

@end
