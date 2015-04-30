//
//  ResourceService.m
//  NewLonking
//
//  Created by 李健 on 14-10-13.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ResourceService.h"
#import "ResourceBiz.h"
#import "ResourceModel.h"
#import "FileHelper.h"

@implementation ResourceService

+ (NSOperationQueue *)defaultQueue
{
    static NSOperationQueue *queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
    });
    return queue;
}

+ (void)sendRequestGetResourceList:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@resource/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *resourceModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            resourceModelArray = nil;
            resourceModelArray = [ResourceBiz saveResourceListDataWithArray:responseObject[@"resultData"]];
            if (resourceModelArray.count>0) {
                ResourceModel *lastModel = [resourceModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[ResourceBiz loadSynchronizePlist] mutableCopy];
                [synchronizeTable setValue:lastModel.updateTime forKey:@"resource"];
                [ResourceBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:RESOURCE_NOTIFICATION_GET_RESOURCELIST userInfo:@{@"resultData":resourceModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *resourceModelArray = @[];
        [CommonHelper postNotification:RESOURCE_NOTIFICATION_GET_RESOURCELIST userInfo:@{@"resultData":resourceModelArray}];
    }];
}

+ (void)sendRequestDownloadResourceWithResourceName:(NSString *)resourceName andResourceType:(NSString *)resourceType
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@download/%@/%@",HOST,resourceName,resourceType];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSString *filePath = [FileHelper defaultFilePathWithFileName:resourceName];
    op.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        // 设置进度条的百分比
        CGFloat precent = (CGFloat)totalBytesRead / totalBytesExpectedToRead;
        NSLog(@"%f", precent); 
    }];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功 ");
        NSData *tempData = [FileHelper readFileFromDefaultFilePathWithFileName:resourceName];
        NSLog(@"图片下载好了");
        NSArray *tempAry = @[tempData];
        [CommonHelper postNotification:RESOURCE_NOTIFICATION_POST_TOGET_RESOURCE userInfo:@{@"resultData":tempAry,@"oldData":tempData}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败= %@",error);
        NSArray *tempAry = @[];
        [FileHelper deleteFileWithFilePath:filePath]; //如果下载失败了就清楚数据
        [CommonHelper postNotification:RESOURCE_NOTIFICATION_POST_TOGET_RESOURCE userInfo:@{@"resultData":tempAry}];
    }];
    // 启动下载
    [queue addOperation:op];
}

@end
