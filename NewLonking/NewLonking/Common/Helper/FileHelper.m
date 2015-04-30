//
//  FileHelper.m
//  NewLonking
//
//  Created by 李健 on 14-8-30.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "FileHelper.h"

@implementation FileHelper

+ (NSString *)defaultFilePathWithFileName:(NSString *)fileName
{
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docs[0] stringByAppendingPathComponent:fileName];
    return path;
}

+ (NSString *)getDocumentPathWithName:(NSString *)documentName
{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [[array objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",documentName]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        return fileName;
    }
    BOOL isSuc = [[NSFileManager defaultManager] createDirectoryAtPath:fileName withIntermediateDirectories:YES attributes:nil error:nil];
    if (isSuc) {
        return fileName;
    }
   else
   {
       return nil;
   }
}

+ (BOOL)storeFileToDocumentWithData:(NSData *)data andName:(NSString *)fileName andDocumentPath:(NSString *)aPath
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",aPath,fileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (!data || data.length == 0) {
        return NO;
    }
    if ([manager fileExistsAtPath:filePath]) {
        NSLog(@"success");
        return YES;
    }
    BOOL isSUc = [data writeToFile:filePath atomically:YES];
    if (isSUc) {
        NSLog(@"success");
        return YES;
    }
    return NO;
}

+ (void)deleteFileWithFilePath:(NSString *)filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        [manager removeItemAtPath:filePath error:nil];
    }
}

+ (void)storeFileInDefaultPathWithFileName:(NSString *)fileName andData:(NSData *)data
{
    NSString *filePath = [FileHelper defaultFilePathWithFileName:fileName];
    [data writeToFile:filePath atomically:YES];
}

+ (NSData *)readFileFromDocumentsWithFileName:(NSString *)fileName andDocumentPath:(NSString *)aPath
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",aPath,fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

+ (NSData *)readFileFromDefaultFilePathWithFileName:(NSString *)fileName
{
    NSString *filePath = [FileHelper defaultFilePathWithFileName:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}
@end
