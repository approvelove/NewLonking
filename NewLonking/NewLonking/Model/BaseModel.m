//
//  BaseModel.m
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
@synthesize creator,updator,valid,remark,modelId,updateTime;
- (id)init
{
    if (self) {
        self.creator = @"";
        self.updator = @"";
        self.valid = @"0";
        self.remark = @"";
        self.modelId = @"";
        self.updateTime = @"";
    }
    return self;
}

+ (instancetype)loadFromService:(id)aObj
{
    BaseModel *model = [[BaseModel alloc] init];
    return model;
}
@end
