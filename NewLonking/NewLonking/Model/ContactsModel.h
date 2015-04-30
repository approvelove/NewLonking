//
//  ContactsModel.h
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"

@interface ContactsModel : BaseModel
@property(nonatomic, copy) NSString *company;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *tel;
@property(nonatomic, copy) NSString *eFax;
@property(nonatomic, copy) NSString *website;
@end
