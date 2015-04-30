//
//  Customers.m
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "Customers.h"

@implementation Customers
@synthesize name,country,email,tel,interestedProductName;

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.country = @"";
        self.email = @"";
        self.tel = @"";
        self.interestedProductName = @"";
    }
    return self;
}
@end
