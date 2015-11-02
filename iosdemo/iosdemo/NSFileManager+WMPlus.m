//
//  NSFileManager+WMPlus.m
//  WMDemos
//
//  Created by wangmo on 10/23/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "NSFileManager+WMPlus.h"

@implementation NSFileManager (WMPlus)

+ (NSString *) homePath {
    
    return NSHomeDirectory();
}

+ (NSString *) documentPath {
    
//    return [[self getHomePath] stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *) libraryPath {

//    [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *) cachePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *) tempPath {
    
//    [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    return NSTemporaryDirectory();
}

/**
 just for document folder
 */
+ (NSString *) getPathWithSubDirName: (NSString *) subPath andFileName: (NSString *) fileName {
    
    return [[self documentPath] stringByAppendingPathComponent:[subPath stringByAppendingPathComponent:fileName]];
}

//for document folder
+ (BOOL) createDir:(NSString *)name {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [[self documentPath] stringByAppendingPathComponent:name];
    return [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
}

//for document folder
+ (BOOL) removeDir:(NSString *)name {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *dirPath = [[self documentPath] stringByAppendingPathComponent:name];
    return [manager removeItemAtPath:dirPath error:nil];
}

//for document folder
+ (BOOL) createFile: (NSString *) path : (NSString *) name : (NSData *) data {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = [self getPathWithSubDirName:path andFileName:name];
    return [manager createFileAtPath:filePath contents:data attributes:nil];
}

//for document folder
+ (BOOL) removeFile: (NSString *) path : (NSString *) name {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = [self getPathWithSubDirName:path andFileName:name];
    return [manager removeItemAtPath:filePath error:nil];
}


@end
