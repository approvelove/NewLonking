//
//  AboutModel.h
//  NewLonking
//
//  Created by 李健 on 14-9-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"

@interface AboutModel : BaseModel

@property(nonatomic, copy) NSString *content;    //内容
@property(nonatomic, copy) NSString *type;  //类型
@property(nonatomic, copy) NSArray *imgAry;   //图片组

- (AboutModel *)loadResourceArrayFromService:(NSArray *)aObj;
@end
