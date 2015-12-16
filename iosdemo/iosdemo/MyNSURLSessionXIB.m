//
//  MyNSURLSessionXIB.m
//  iosdemo
//
//  Created by wangmo on 12/11/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyNSURLSessionXIB.h"
#import "User.h"
#import <YYModel.h>

@interface MyNSURLSessionXIB ()

@end

/**
 NSURLConnection框架在IOS9中已经过时被NSURLSession框架替换
 NSURLSessionTask抽象类有三个子类 所有任务均可撤销，也可以暂停和恢复。当一个下载任务被取消时，它可以选择创建恢复数据，然后可以传递给下一次新创建的下载任务，以便继续之前的下载
 1.NSURLSessionDataTask 处理一般的NSData数据对象, 比如通过GET或POST方式从服务器获取JSON或XML返回等等, 但不支持后台获取.
 2.NSURLSessionUploadTask 用于上传文件, 支持后台上传.
 3.NSURLSessionDownloadTask 用于下载文件, 支持后台下载.
 
 delegate继承示意
 NSURLSessionDelegate -> NSURLSessionTaskDelegate -> NSURLSessionDataDelegate -> NSURLSessionDownloadDelegate
 
 defaultSessionConfiguration 默认配置，类似 NSURLConnection 的标准配置，使用硬盘来存储缓存数据
 ephemeralSessionConfiguration 临时session配置，与默认配置相比，这个配置不会将缓存、cookie等存在本地，只会存在内存里，所以当程序退出时，所有的数据都会消失
 backgroundSessionConfigurationWithIdentifier 后台session配置，与默认配置类似，不同的是会在后台开启另一个线程来处理网络数据。参数指定了会话的ID，用于标记后台的session。
 */
@implementation MyNSURLSessionXIB

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSURLRequest*) postReq {
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    可配置req
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
//    声明POST
    req.HTTPMethod = @"POST";
//    形成数据体 业务配合
    NSString *str = [NSString stringWithFormat:@"login?username=wm&pwd=123"];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    req.HTTPBody = data;
    return req;
}

- (IBAction)httpGet:(id)sender {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://7xkme5.com1.z0.glb.clouddn.com/students.json"];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    [task resume];
}

- (IBAction)httpPost:(id)sender{
    
    NSURLRequest *req = [self postReq];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    [task resume];
}

-(IBAction) parseJsonToObject{
    
    NSURL *url = [NSURL URLWithString:@"http://7xkme5.com1.z0.glb.clouddn.com/students.json"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        for(int i=0; i<array.count; i++){
            User *user = [User yy_modelWithJSON:array[i]]; //YYModel json->model
            NSLog(@"name is %@, age is %@", user.name, user.age);
            
            NSDictionary *json = [user yy_modelToJSONObject]; //YYModel model->json
            NSLog(@"%@", json);
        }
    }];
    [task resume];
}

@end
