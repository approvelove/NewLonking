//
//  ProductsDB.h
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ResourceDB;
@class Products;
@class ProductTypeDB;

@interface ProductsDB : NSManagedObject

@property (nonatomic, retain) NSString * productsId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderindex;
@property (nonatomic, retain) ResourceDB *img;    //产品图
@property (nonatomic, retain) ResourceDB *modelImage;  //产品模型图
@property (nonatomic, retain) ResourceDB *productDataImage;  //产品参数图
@property (nonatomic, retain) ProductTypeDB *type;   //产品类型

- (ProductsDB *)fromModel:(Products *)model;

- (Products *)toModel;
@end
