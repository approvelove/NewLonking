//
//  CustomersDB.h
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Customers;
@interface CustomersDB : NSManagedObject

@property (nonatomic, retain) NSString * customersId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * interestedProductName;

- (CustomersDB *)fromModel:(Customers *)model;
- (Customers *)toModel;

@end
