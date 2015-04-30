//
//  FileHelper.h
//  NewLonking
//
//  Created by 李健 on 14-8-30.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

/**
 *	@brief	获取文件目录
 *
 *	@param 	documentName 	文件目录名
 *
 *	@return	获取文件目录路径成功返回路径，否则返回Nil
 */
+ (NSString *)getDocumentPathWithName:(NSString *)documentName;

/**
 *	@brief	存储文件到指定目录
 *
 *	@param 	data 	文件数据
 *	@param 	fileName 	文件名
 *	@param 	aPath 	文件所在文件夹路径
 *
 *	@return 存储成功返回 YES 否则返回NO
 */
+ (BOOL)storeFileToDocumentWithData:(NSData *)data andName:(NSString *)fileName andDocumentPath:(NSString *)aPath;

/**
 *	@brief	读取文件内容
 *
 *	@param 	fileName 	文件名
 *	@param 	aPath 	文件所在文件夹路径
 *
 *	@return	读取成功返回文件数据，否则Nil
 */
+ (NSData *)readFileFromDocumentsWithFileName:(NSString *)fileName andDocumentPath:(NSString *)aPath;

/**
 *	@brief	获得默认的存储路径
 *
 *	@param 	fileName 	文件名
 *
 *	@return	文件的物理路径
 */
+ (NSString *)defaultFilePathWithFileName:(NSString *)fileName;

/**
 *	@brief	从默认文件路径读取文件
 *
 *	@param 	fileName 	文件名
 *
 *	@return	文件数据
 */
+ (NSData *)readFileFromDefaultFilePathWithFileName:(NSString *)fileName;

/**
 *	@brief	删除指定路径的文件
 *
 *	@param 	filePath 	文件物理路径
 *
 *	@return	nil
 */
+ (void)deleteFileWithFilePath:(NSString *)filePath;

/**
 *	@brief	存储图片到指定路径
 *
 *	@param 	fileName 	文件名
 *	@param 	data 	文件数据
 *
 *	@return	nil
 */
+ (void)storeFileInDefaultPathWithFileName:(NSString *)fileName andData:(NSData *)data;

@end
