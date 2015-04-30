//
//  ProductsDB.m
//  Pods
//
//  Created by 李健 on 14-9-17.
//
//

#import "ProductsDB.h"
#import "ResourceDB.h"
#import "Products.h"
#import "ResourceDAO.h"
#import "ProductTypeDB.h"
#import "ResourceModel.h"
#import "ProductTypeDAO.h"
#import "ProductTypeModel.h"

@implementation ProductsDB

@dynamic productsId;
@dynamic name;
@dynamic img;
@dynamic modelImage;
@dynamic productDataImage;
@dynamic type;
@dynamic orderindex;

- (ProductsDB *)fromModel:(Products *)model
{
    if (model == nil) {
        return nil;
    }
    self.productsId = model.modelId;
    self.name = model.name;
    self.orderindex = model.orderindex;
    
    ProductTypeDB *typeDB = [ProductTypeDAO findById:model.typeModel.modelId];
    if (!typeDB) {
        [ProductTypeDAO save:model.typeModel];
    }
    typeDB = [ProductTypeDAO findById:model.typeModel.modelId];
    self.type = typeDB;
    
    ResourceDB *imgDB = [ResourceDAO findById:model.imgModel.modelId];
    if (!imgDB) {
        [ResourceDAO save:model.imgModel];
    }
    imgDB  = [ResourceDAO findById:model.imgModel.modelId];
    self.img = imgDB;
    
    ResourceDB *modelImgDB = [ResourceDAO findById:model.modelImageModel.modelId];
    if (!modelImgDB) {
        [ResourceDAO save:model.modelImageModel];
    }
    modelImgDB = [ResourceDAO findById:model.modelImageModel.modelId];
    self.modelImage = modelImgDB;
    
    ResourceDB *productDataImgDB = [ResourceDAO findById:model.productDataImageModel.modelId];
    if (!productDataImgDB) {
        [ResourceDAO save:model.productDataImageModel];
    }
    productDataImgDB = [ResourceDAO findById:model.productDataImageModel.modelId];
    self.productDataImage = productDataImgDB;
    
    return self;
}

- (Products *)toModel
{
    if (self) {
        Products *model = [[Products alloc] init];
        model.modelId = self.productsId;
        model.name = self.name;
        model.orderindex = self.orderindex;
        model.imgModel = [self.img toModel];
        model.modelImageModel = [self.modelImage toModel];
        model.productDataImageModel = [self.productDataImage toModel];
        model.typeModel = [self.type toModel];
        return model;
    }
    return nil;
}
@end
