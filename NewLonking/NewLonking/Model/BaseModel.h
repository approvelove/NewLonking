//
//  BaseModel.h
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property(nonatomic, copy) NSString *modelId;  //ID
@property(nonatomic, copy) NSString *creator;   //创建人
@property(nonatomic, copy) NSString *updator;  //更新人
@property(nonatomic, copy) NSString *updateTime; //更新时间
@property(nonatomic, copy) NSString *valid;  //是否有效 "0":有效， "1":无效
@property(nonatomic, copy) NSString *remark; //描述

- (id)init;
+ (instancetype)loadFromService:(id)aObj;
@end
