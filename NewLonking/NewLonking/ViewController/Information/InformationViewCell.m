//
//  InformationViewCell.m
//  NewLonking
//
//  Created by 李健 on 14-8-30.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "InformationViewCell.h"
#import "LearningMaterials.h"
#import "FileHelper.h"
#import "LKQLPreViewController.h"
#import "ResourceModel.h"

//测试服务器
//#define HOST @"http://192.168.9.232:8080/lonking/restapi/"

//正式服务器
#define HOST @"http://222.69.242.13:18080/lonking/restapi/"

@interface InformationViewCell()<QLPreviewControllerDataSource>
{
    __weak IBOutlet UIButton *downloadButton;
    __weak IBOutlet UILabel *learningMaterialsNameLabel;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UILabel *uploadorLabel;
    __weak IBOutlet UILabel *progressLabel;
    LearningMaterials *materialsModel;
    SGdownloader* download;
    BOOL hasLogin;
    BOOL buttonClick;
    NSString *currentPageName;
}
@end

@implementation InformationViewCell
@synthesize superController,identify;

- (void)awakeFromNib
{
    // Initialization code
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (InformationViewCell *)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"InformationViewCell" owner:nil options:nil] objectAtIndex:0];
}

- (void)changeHasLoginStatus:(NSNotification *)notification
{
    NSDictionary *tempDic = notification.userInfo;
    hasLogin = [tempDic[@"loginStatus"] boolValue];
    if (buttonClick && hasLogin) {  //如果已经点击过登录按钮，且登录成功
        [self downloadButtonClick:nil];
    }
    buttonClick = NO;
}
#pragma mark - 数据处理
- (void)initWithLearningMaterials:(LearningMaterials *)model currentPageName:(NSString *)aName
{
    currentPageName = aName;
    buttonClick = NO;  //初始化时， 按钮未点击
    if ([currentPageName isEqualToString:@"Infomation"]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHasLoginStatus:) name:LOGIN_STATUS_CHANGED object:nil];
    }
    materialsModel = model;
    learningMaterialsNameLabel.text = model.name;
    dateLabel.text = model.uploadDateStr;
    uploadorLabel.text = model.updator;
    [self getFileWithMaterials:model];
}

- (void)getFileWithMaterials:(LearningMaterials *)model
{
    NSString *documentPath = [FileHelper defaultFilePathWithFileName:model.resource.name];
    if (documentPath) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
            materialsModel.hasLoad = YES;
            [self resetButtonOutlook];
        }
    }
}
#pragma mark - 事件处理
- (IBAction)downloadButtonClick:(id)sender
{
    ///先验证是否登录,如果没有验证登录，弹出登录框,如果已经登录则继续正常运行
    if ((!hasLogin) && [currentPageName isEqualToString:@"Infomation"]) { //尚未验证登录
        if (sender != nil) {
            buttonClick = YES;  //点击了按钮
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:VERIFY_LOGIN_NOT_LOGIN object:nil];
        return;
    }
    if (materialsModel.prepareLoad) {
        [self cancelRequest];
        return;
    }
    if (materialsModel.isLoading) {
        [self cancelRequest];
        return;
    }
    if (materialsModel.hasLoad) {
        [self openFileOnController];
        return;
    }
    //开始下载
    NSLog(@"无任何状态");
    [self startRequest];
}

-(void)startRequest
{
    [materialsModel resetStatusWithStatus:FileStatus_Prepare];
    [self resetButtonOutlook];
    if (download) {
        download = nil;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@download/%@/%@",HOST,materialsModel.materialsUrl,materialsModel.fileType];
    download = [[SGdownloader alloc] initWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] timeout:1000];
    [download startWithDelegate:self];
}

- (void)cancelRequest
{
    [download cancel];
    progressLabel.text = @"";
    [materialsModel resetStatusToOrigin];
    [downloadButton setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    [downloadButton setTitle:@"" forState:UIControlStateNormal];
}
#pragma mark - 界面处理
- (void)resetButtonOutlook
{
    [downloadButton setImage:nil forState:UIControlStateNormal];
    if (materialsModel.prepareLoad) {
        [downloadButton setTitle:@"prepare for load..." forState:UIControlStateNormal];
        progressLabel.text = @"0%";
    }
    if (materialsModel.isLoading) {
        [downloadButton setTitle:@"cancel" forState:UIControlStateNormal];
    }
    if (materialsModel.hasLoad) {
        [downloadButton setTitle:@"open" forState:UIControlStateNormal];
        progressLabel.text = @"complete";
    }
    [downloadButton setTitleColor:rgbaColor(0, 122, 255, 1) forState:UIControlStateNormal];
}

#pragma mark - helper
- (void)storeFileWithData:(NSData *)fileData
{
    [materialsModel resetStatusWithStatus:FileStatus_hasLoad];
    [self resetButtonOutlook];
    [FileHelper storeFileInDefaultPathWithFileName:materialsModel.materialsUrl andData:fileData];
}

- (void)showAlertWithTitle:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - open file
- (void)openFileOnController
{
    LKQLPreviewController *previewoCntroller = [[LKQLPreviewController alloc] init];
    previewoCntroller.dataSource = self;
    [previewoCntroller setTitle:materialsModel.name];
    [previewoCntroller setCurrentPreviewItemIndex:0];
    [self.superController.navigationController pushViewController:previewoCntroller animated:YES];
}


#pragma mark - 代理
#pragma mark DownloadProcess
-(void)SGDownloadProgress:(float)progress Percentage:(NSInteger)percentage
{
    NSLog(@"progress = %f  percentage = %ld ",progress,(long)percentage);
    if (percentage<100) {
        [materialsModel resetStatusWithStatus:FileStatus_isLoading];
        [self resetButtonOutlook];
        progressLabel.text = [NSString stringWithFormat:@"%ld%%",(long)percentage];
    }
}
-(void)SGDownloadFinished:(NSData*)fileData
{
    NSLog(@"success");
    [self storeFileWithData:fileData];
}

-(void)SGDownloadFail:(NSError*)error
{
    NSLog(@"error = %@",error);
}

#pragma mark 打开文件
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    NSString *urlPath = [FileHelper defaultFilePathWithFileName:materialsModel.resource.name];
    controller.navigationItem.rightBarButtonItem = nil;
    return [NSURL fileURLWithPath:urlPath];
}

@end
