//
//  BaseBiz.m
//  NewLonking
//
//  Created by 李健 on 14-8-12.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseBiz.h"
#import "Filehelper.h"

@implementation BaseBiz

+ (NSDictionary *)loadSynchronizePlist
{
    NSString *filePath = [FileHelper defaultFilePathWithFileName:@"SynchronizeTimeList.plist"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:filePath]) {
        NSDictionary *dict = @{@"about":@"0",@"aboutres":@"0",@"activity":@"0",@"activityres":@"0",@"contact":@"0",@"employee":@"0",@"study":@"0",@"resource":@"0",@"producttype":@"0",@"product":@"0",@"hotproduct":@"0",@"homepic":@"0",@"vedio":@"0"};
        [dict writeToFile:filePath atomically:YES];
        return dict;
    }
    return [NSDictionary dictionaryWithContentsOfFile:filePath];//从指定路径读出
}

+ (NSDictionary *)loadPlistWithPlistName:(NSString *)name
{
    NSString *filePath = [FileHelper defaultFilePathWithFileName:name];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:filePath]) {
        return nil;
    }
    return [NSDictionary dictionaryWithContentsOfFile:filePath];//从指定路径读出
}

+ (void)writeSynchronizeStatusToPlist:(NSDictionary *)infoDict
{
    NSAssert(infoDict != nil, @"info dictionary can't be nil");
    NSString *filePath = [FileHelper defaultFilePathWithFileName:@"SynchronizeTimeList.plist"];
    [infoDict writeToFile:filePath atomically:YES];
}

@end
