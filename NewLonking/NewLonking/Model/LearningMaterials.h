//
//  LearningMaterials.h
//  NewLonking
//
//  Created by 李健 on 14-8-30.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseModel.h"
@class ResourceModel;

typedef NS_ENUM(NSInteger, FileStatus) {
    FileStatus_Prepare,
    FileStatus_isLoading,
    FileStatus_hasLoad
};


@interface LearningMaterials : BaseModel

@property (nonatomic, copy) NSString *name; //资料名 带后缀
@property (nonatomic, copy) NSString *uploadDateStr;  //资料上传日期
@property (nonatomic, copy) NSString *materialsUrl; //资料的URL
@property (nonatomic, copy) NSString *subName; //资料名  不带后缀名
@property (nonatomic, copy) NSString *fileType; //文件格式
//@property (nonatomic, copy) NSString *resourceId; //资源ID
@property (nonatomic, strong) ResourceModel *resource;

//状态
@property (nonatomic) BOOL prepareLoad; //准备下载
@property (nonatomic) BOOL isLoading; //正在下载
@property (nonatomic) BOOL hasLoad; //已存在

- (id)init;

- (void)resetStatusWithStatus:(FileStatus)status;

- (void)resetStatusToOrigin;
@end
