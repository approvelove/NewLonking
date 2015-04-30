//
//  ActivitiesModel.h
//  NewLonking
//
//  Created by 李健 on 14-9-15.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"

@interface ActivitiesModel : BaseModel

@property (nonatomic, copy) NSString *type;  //活动类型
@property (nonatomic, copy) NSArray *imgAry;   //里面装的都是ResourceModel对象

+ (instancetype)loadFromService:(NSDictionary *)aObj;
- (ActivitiesModel *)loadResourceArrayFromService:(NSArray *)aObj;
@end
