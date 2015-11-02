//
//  NSFileManager+WMPlus.h
//  WMDemos
//
//  Created by wangmo on 10/23/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (WMPlus)

+ (NSString *) homePath;
+ (NSString *) documentPath;
+ (NSString *) libraryPath;
+ (NSString *) cachePath;
+ (NSString *) tempPath;
+ (NSString *) getPathWithSubDirName: (NSString *) subPath andFileName: (NSString *) fileName;
+ (BOOL) createDir: (NSString *) name;
+ (BOOL) removeDir: (NSString *) path;
+ (BOOL) createFile: (NSString *) path : (NSString *) name : (NSData *) data;
+ (BOOL) removeFile: (NSString *) path : (NSString *) name;
@end
