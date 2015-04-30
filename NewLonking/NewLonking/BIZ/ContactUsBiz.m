//
//  ContactUsBiz.m
//  NewLonking
//
//  Created by 李健 on 14-10-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ContactUsBiz.h"
#import "ContactUsService.h"
#import "FileHelper.h"
#import "ContactsModel.h"

@implementation ContactUsBiz

+ (NSArray *)saveContactUsDataWithArray:(NSArray *)aArray
{
    NSAssert(aArray != nil, @"method saveEmployeeDataWithArray has failed!");
    NSMutableArray *tempAry = [@[] mutableCopy];
    //联系我们这个模块儿只有一个记录
    NSDictionary *infoDict = [aArray lastObject];
    
    NSString *filePath = [FileHelper defaultFilePathWithFileName:@"ContactUs.plist"];
    [infoDict writeToFile:filePath atomically:YES]; //存储联系我们的相关信息到指定的文件
    
    ContactsModel *contactModel = [ContactsModel loadFromService:infoDict];
    [tempAry addObject:contactModel];
    return tempAry;
}

+ (void)startLoadContactUsInfoFromServiceWithTimes:(NSString *)times
{
    long long recordTimes = [times longLongValue];
    [ContactUsService sendRequestGetInformationOfUs:recordTimes];
}
@end
