//
//  ProductService.m
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ProductService.h"
#import "ProductBiz.h"
#import "ProductTypeModel.h"
#import "Products.h"
#import "HotProductModel.h"

@implementation ProductService

//产品类型列表（wheel loader, skid loader...）
+ (void)sendRequestGetProductType:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@productType/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *productTypeModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            productTypeModelArray = nil;
            productTypeModelArray = [ProductBiz saveProductTypeDataWithArray:responseObject[@"resultData"]];
            if (productTypeModelArray.count>0) {
                ProductTypeModel *lastModel = [productTypeModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[ProductBiz loadSynchronizePlist] mutableCopy];
                [synchronizeTable setValue:lastModel.updateTime forKey:@"producttype"];
                [ProductBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:PRODUCT_NOTIFICATION_GET_PRODUCTTYPE userInfo:@{@"resultData":productTypeModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *productTypeModelArray = [NSArray array];
        [CommonHelper postNotification:PRODUCT_NOTIFICATION_GET_PRODUCTTYPE userInfo:@{@"resultData":productTypeModelArray}];
    }];
}

//所有的产品(包括产品的矢量图，参数图，产品样图)
+ (void)sendRequestGetProduct:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@product/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *productModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            productModelArray = nil;
            productModelArray = [ProductBiz saveProductDataWithArray:responseObject[@"resultData"]];
            if (productModelArray.count>0) {
                Products *lastModel = [productModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[ProductBiz loadSynchronizePlist] mutableCopy];
                [synchronizeTable setValue:lastModel.updateTime forKey:@"product"];
                [ProductBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:PRODUCT_NOTIFICATION_GET_PRODUCTS userInfo:@{@"resultData":productModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *productModelArray = [NSArray array];
        [CommonHelper postNotification:PRODUCT_NOTIFICATION_GET_PRODUCTS userInfo:@{@"resultData":productModelArray}];
    }];
}

//首页产品
+ (void)sendRequestGetHotProduct:(long long)aTimes
{
    NSString *urlString = [NSString stringWithFormat:@"%@hotProduct/%lld",HOST,aTimes];
    [[AFHTTPRequestOperationManager manager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *hotProductModelArray = [NSArray array];
        if ([responseObject[@"resultCode"] isEqual:@"SUCCESS"]) {
            hotProductModelArray = nil;
            hotProductModelArray = [ProductBiz saveHotProductDataWithArray:responseObject[@"resultData"]];
            if (hotProductModelArray.count>0) {
                HotProductModel *lastModel = [hotProductModelArray lastObject];
                NSMutableDictionary *synchronizeTable = [[ProductBiz loadSynchronizePlist] mutableCopy];
                [synchronizeTable setValue:lastModel.updateTime forKey:@"hotproduct"];
                [ProductBiz writeSynchronizeStatusToPlist:synchronizeTable];
            }
        }
        [CommonHelper postNotification:PRODUCT_NOTIFICATION_GET_HOTPRODUCT userInfo:@{@"resultData":hotProductModelArray,@"oldData":responseObject[@"resultData"]}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSArray *hotProductModelArray = [NSArray array];
        [CommonHelper postNotification:PRODUCT_NOTIFICATION_GET_HOTPRODUCT userInfo:@{@"resultData":hotProductModelArray}];
    }];
}
@end
