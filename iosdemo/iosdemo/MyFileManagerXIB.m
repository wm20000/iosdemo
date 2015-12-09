//
//  MyFileManager.m
//  iosdemo
//
//  Created by wangmo on 12/9/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyFileManagerXIB.h"
#import "NSFileManager+WMPlus.h"

@interface MyFileManagerXIB ()

@end

@implementation MyFileManagerXIB

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", NSHomeDirectory());
}

- (IBAction)createDir:(id)sender {
    
    NSLog(@"create dir is %d", [NSFileManager createDir:@"test"]);
}

- (IBAction)removeDir:(id)sender {
    
    NSLog(@"remove dir is %d", [NSFileManager removeDir:@"test"]);
}

- (IBAction)existFile:(id)sender {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSFileManager getPathWithSubDirName:@"test" andFileName:@"test.txt"]]) {
        NSLog(@"file exist");
    } else {
        NSLog(@"file not exist");
    }
}

- (IBAction)createFile:(id)sender {
    
    NSData *data = [@"test" dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"create file is %d", [NSFileManager createFile:@"test" :@"test.txt" :data]);
}

- (IBAction)removeFile:(id)sender {
    
    NSLog(@"remove file is %d", [NSFileManager removeFile:@"test" : @"test.txt"]);
}

- (IBAction)readFile:(id)sender {
    
    NSString *path = [[[NSFileManager documentPath] stringByAppendingPathComponent:@"test"] stringByAppendingPathComponent:@"test.txt"];
    NSLog(@"file content is '%@'", [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil]);
}

- (IBAction)writeFile:(id)sender {
    
    NSString *path = [NSFileManager getPathWithSubDirName:@"test" andFileName:@"test.txt"];
//    atomically yes=先写入临时文件 然后覆盖目标文件 防止出现错误
    BOOL success = [@"test test" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"write file is %d", success);
}

#pragma mark NSFileHandle

- (IBAction)handleWriteFile:(id)sender {
    
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:[NSFileManager getPathWithSubDirName:@"test" andFileName:@"test.txt"]];
    NSData *data = [@"test test test" dataUsingEncoding:NSUTF8StringEncoding];
    [handle writeData:data];
    [handle closeFile];
}

- (IBAction)handleFileAppend:(id)sender {
    
    NSString *path = [self getRegualrPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:path];
        //        追加到末尾
        [handle seekToEndOfFile];
        [handle writeData:[@"append" dataUsingEncoding:NSUTF8StringEncoding]];
        [handle closeFile];
    }
}

- (IBAction)handleReadFile:(id)sender {
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:[NSFileManager getPathWithSubDirName:@"test" andFileName:@"test.txt"]];
//    读取所有内容
    NSData *data = [handle readDataToEndOfFile];
    NSLog(@"read file content is %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (IBAction)handleReadFileOffse:(id)sender {
    
    NSString *path = [self getRegualrPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
        NSInteger length = [[handle availableData] length];
        [handle seekToFileOffset:length/2];
        NSLog(@"%@", [[NSString alloc] initWithData:[handle readDataToEndOfFile] encoding:NSUTF8StringEncoding]);
    }
}

- (IBAction)handleCopyFile:(id)sender {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *sourcePath = [NSFileManager getPathWithSubDirName:@"test" andFileName:@"test.txt"];
    NSString *targetPath = [NSFileManager getPathWithSubDirName:@"test" andFileName:@"test_copy.txt"];
    BOOL isDir; //输出参数 是否是目录
    BOOL exist = [manager fileExistsAtPath:sourcePath isDirectory:&isDir];
    if (exist) {
        NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:sourcePath];
        NSData *data = [readHandle readDataToEndOfFile];
//        handle不能创建文件 必须现有目标文件 才能操作
        if ([manager createFileAtPath:targetPath contents:nil attributes:nil]) {
            NSFileHandle *writeHandle = [NSFileHandle fileHandleForWritingAtPath:targetPath];
            [writeHandle writeData:data];
            [writeHandle closeFile];
        }
        [readHandle closeFile];
    } else {
        NSLog(@"source file is not exist");
    }
}

- (NSString *) getRegualrPath {
    
    return [NSFileManager getPathWithSubDirName:@"test" andFileName:@"test.txt"];
}

@end
