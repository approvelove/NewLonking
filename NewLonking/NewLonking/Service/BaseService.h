//
//  BaseService.h
//  NewLonking
//
//  Created by 李健 on 14-8-12.
//  Copyright (c) 2014年 王亮. All rights reserved.
//服务层


//测试服务器
//#define HOST @"http://192.168.9.232:8080/lonking/restapi/"

 //正式服务器
//#define HOST @"http://222.69.242.13:18080/lonking/restapi/"

//域名登陆服务器
#define HOST @"http://app.lonking.cn:18080/lonking/restapi/"


#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface BaseService : NSObject

@end
