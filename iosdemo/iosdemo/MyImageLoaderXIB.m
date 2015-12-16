//
//  MyImageLoaderXIB.m
//  iosdemo
//
//  Created by wangmo on 12/15/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyImageLoaderXIB.h"

@interface MyImageLoaderXIB () <NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDownloadTask *task;
@property (strong, nonatomic) NSData *data;

@end

@implementation MyImageLoaderXIB

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSURLSession*) session {
    
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil]; //指定了session的委托和委托所处的队列
    }
    return _session;
}

- (NSURLSessionTask*) task {
    
    if (!_task) {
        _task = [self.session downloadTaskWithURL:[NSURL URLWithString:@"http://7xnjxd.com1.z0.glb.clouddn.com/bigimg2.jpg"]];
    }
    return _task;
}

- (IBAction)start:(id)sender {
    
    [self.task resume];
    self.progressView.progress = 0;
}

- (IBAction)pause:(id)sender {
    
    [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.data = resumeData;
        self.task = nil;
    }];
}

- (IBAction)resume:(id)sender {
    
    if (self.data && self.task.state == NSURLSessionTaskStateSuspended) {
        self.task = [self.session downloadTaskWithResumeData:self.data];
    }
    [self.task resume];
}

#pragma mark NSURLSessionDownloadDelegate

- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
//    NSLog(@"%@", location);
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/down.img"];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL exist = [manager fileExistsAtPath:path];
    if (exist) {
        BOOL delete = [manager removeItemAtPath:path error:nil];
        if (delete) {
            NSLog(@"delete down.img success");
        }
    }
    
    BOOL move = [manager moveItemAtPath:[location path] toPath:path error:nil];
    if (move) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIImage *img = [UIImage imageWithContentsOfFile:path];
            if (img) {
                self.imgView.image = img;
                self.progressView.progress = 0;
                [UIView animateWithDuration:2.0 animations:^{
                    self.imgView.alpha = 1.0;
                }];
            }
        }];
    }
}

/**
 bytesWritten 写入数据大小
 totalBytesWritten 已经写入的数据大小
 totalBytesExpectedToWrite 想要一共写入的数据大小
 */
- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        double currentProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
        self.progressView.progress = currentProgress;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

@end
