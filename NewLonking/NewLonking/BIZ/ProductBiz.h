//
//  ProductBiz.h
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#define PRODUCT_NOTIFICATION_GET_PRODUCTTYPE @"product notification get product type"
#define PRODUCT_NOTIFICATION_GET_PRODUCTS @"product notification get products"
#define PRODUCT_NOTIFICATION_GET_HOTPRODUCT @"product notification get hot product"

#import "BaseBiz.h"

@interface ProductBiz : BaseBiz

/**
 *	@brief	保存产品类型到数据库
 *
 *	@param 	aArray 	从服务器端请求产品类型的数据的数据
 *
 *	@return	返回ProductTypeModel
 */
+ (NSArray *)saveProductTypeDataWithArray:(NSArray *)aArray;

/**
 *	@brief	保存产品到数据库
 *
 *	@param 	aArray 	从服务器端请求产品的数据的数据
 *
 *	@return	返回Product Model
 */
+ (NSArray *)saveProductDataWithArray:(NSArray *)aArray;

/**
 *	@brief	保存热卖产品到数据库
 *
 *	@param 	aArray 	从服务器端请求产品的数据的数据
 *
 *	@return	返回hotProduct Model
 */
+ (NSArray *)saveHotProductDataWithArray:(NSArray *)aArray;

/**
 *	@brief  发送请求获取产品类型列表
 *
 *	@param 	productTypeModel 	
 *
 *	@return	nil
 */
+ (void)startLoadProductTypeDataFromServiceWithWithTimes:(NSString *)times;

/**
 *	@brief	发送请求从网络获取产品
 *
 *	@param 	times 	最后一次更新时间
 *
 *	@return	nil
 */
+ (void)startLoadProductsDataFromServiceWithWithTimes:(NSString *)times;

/**
 *	@brief	发送请求从网络获取最热产品图
 *
 *	@param 	times 	最后一次更新时间
 *
 *	@return	nil
 */
+ (void)startLoadHotProductDataFromServiceWithWithTimes:(NSString *)times;
@end
