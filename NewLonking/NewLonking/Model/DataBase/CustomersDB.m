//
//  CustomersDB.m
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import "CustomersDB.h"
#import "Customers.h"

@implementation CustomersDB

@dynamic customersId;
@dynamic name;
@dynamic country;
@dynamic email;
@dynamic tel;
@dynamic interestedProductName;

- (CustomersDB *)fromModel:(Customers *)model
{
    if (model == nil) {
        return nil;
    }
    self.customersId = model.modelId;
    self.name = model.name;
    self.country = model.country;
    self.email = model.email;
    self.tel = model.tel;
    self.interestedProductName = model.interestedProductName;
    return self;
}

- (Customers *)toModel
{
    if (self) {
        Customers *model = [[Customers alloc] init];
        model.modelId = self.customersId;
        model.name = self.name;
        model.country = self.country;
        model.email = self.email;
        model.tel = self.tel;
        model.interestedProductName = self.interestedProductName;
        return model;
    }
    return nil;
}
@end
