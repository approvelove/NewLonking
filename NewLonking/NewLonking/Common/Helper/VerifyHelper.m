//
//  VerifyHelper.m
//  onestong
//
//  Created by 王亮 on 14-4-23.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "VerifyHelper.h"

@implementation VerifyHelper
+ (BOOL)isEmpty:(NSString *)field
{
    if (nil == field || NULL == field) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@" "];
    NSString *trimmedString = [field stringByTrimmingCharactersInSet:set];
    if ([trimmedString isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isPhoneNumInputString:(NSString *)phoneStr
{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"; //中国移动
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$"; //中国联通
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";  //中国电信
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$"; //小灵通及大陆固话
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:phoneStr];
    BOOL res2 = [regextestcm evaluateWithObject:phoneStr];
    BOOL res3 = [regextestcu evaluateWithObject:phoneStr];
    BOOL res4 = [regextestct evaluateWithObject:phoneStr];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}
@end
