//
//  MenuViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-14.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "MenuViewController.h"
#import "QBFlatButton.h"
#import "GraphicHelper.h"

//只是用于测试
#import "EmployeeBiz.h"
#import "AboutBiz.h"
#import "ActivityBiz.h"
#import "ContactUsBiz.h"
#import "ResourceBiz.h"
#import "ProductBiz.h"
#import "LearningMaterialsBiz.h"
#import "FeedBackBiz.h"
#import "VedioBiz.h"
#import "HomePicBiz.h"


#import "ActivitiesModel.h"
#import "ResourceModel.h"
#import "EmployeeModel.h"

#import "FileHelper.h"
#import "SCLAlertView.h"
#import "ModifyPasswordModel.h"
#import "HomePicDAO.h"
#import "HomePicDB.h"
#import "ResourceDB.h"

@interface MenuViewController ()<UIAlertViewDelegate>
{
   __weak IBOutlet  UIView *buttonMenuView;
   __weak IBOutlet UIImageView *menuImageView;
    UITextField *agentIDField;   //oldpassword and agentId
    UITextField *nameField;   //password and newpassword
    
    __weak IBOutlet UIImageView *machineImageView;
    
    BOOL checkUpdate; //检查是否需要更新
//    __weak IBOutlet UIScrollView *machineScrollView;
    __weak IBOutlet UIImageView *dotImageView; //红点
    
    //test image url array
    NSMutableArray *resourceListAry;
}
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化类数据源
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registRequestNotification];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self freeNotification];
}
#pragma mark - 界面初始化
- (void)initSelf
{
    [super initSelf];
     checkUpdate = NO;
    //启动更换图片
    resourceListAry = [@[] mutableCopy];
    dotImageView.backgroundColor = [UIColor clearColor];
    [GraphicHelper convertRectangleToCircular:dotImageView];
    [self checkIfNeedUpdate];
    [NSTimer scheduledTimerWithTimeInterval:4.f target:self selector:@selector(changeMachineImageInSeconds) userInfo:nil repeats:YES];
}

//登录
- (void)loginAlertViewShow
{
    UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
    loginAlert.tag = 0;
    loginAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    agentIDField = [loginAlert textFieldAtIndex:0];
    agentIDField.placeholder = @"username";
    nameField = [loginAlert textFieldAtIndex:1];
    nameField.placeholder = @"password";
    [loginAlert show];
}

- (void)modifyPasswordShow
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    agentIDField = [alert addTextField:@"Old password"];
    agentIDField.secureTextEntry = YES;
    nameField = [alert addTextField:@"New password"];
    nameField.secureTextEntry = YES;
    UITextField *confirmField = [alert addTextField:@"Confirm password"];
    confirmField.secureTextEntry = YES;
    [alert addButton:@"Ok" actionBlock:^{
        if (![nameField.text isEqual:confirmField.text]) {
            [self showAlertWithTitle:@"Confirm password entered incorrect!"];
            return;
        }
        ModifyPasswordModel *tempMode = [[ModifyPasswordModel alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dict = [defaults objectForKey:@"userInfo"];
        EmployeeModel *model = [EmployeeModel loadFromService:dict];
        tempMode.userId = model.modelId;
        tempMode.oldPassword = agentIDField.text;
        tempMode.password = nameField.text;
        [self startLoading:@"modify..."];
        [EmployeeBiz startModifyPasswordWithModel:tempMode];
    }];
    [alert showEdit:self title:nil subTitle:@"modify password" closeButtonTitle:@"Cancel" duration:0.0f];
}

- (void)loginAlertViewOnlyPwd
{
    UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
    loginAlert.tag = 2;
    loginAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    nameField = [loginAlert textFieldAtIndex:0];
    nameField.placeholder = @"password";
    nameField.secureTextEntry = NO;
    [loginAlert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}

//更换中心机器图片
- (void)changeMachineImageInSeconds
{
    //从数据库读取图片
    NSArray *homePicArray = [HomePicDAO findAll];
    if (homePicArray == nil || homePicArray.count == 0) {
        return;
    }
    static int i = 0;
    if (i>=homePicArray.count) {
        i = 0;
    }
    HomePicDB *tempDB = homePicArray[i];
    UIImage *tempImage = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:tempDB.resource.name]];
    [self animationRippleWithImage:tempImage];
    i++;
}

#pragma mark - 事件处理
//检查是否需要更新
- (void)checkIfNeedUpdate
{
    checkUpdate = YES;
    //[self startLoading:@"check need update..."];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    [ResourceBiz startLoadResouceListDataFromServiceWithTimes:synchronizeTable[@"resource"]]; //检查是否有新资源
}

- (IBAction)synchronizeButtonClick:(id)sender
{
    checkUpdate = NO;
    [self loadData];
}

- (IBAction)modifyPasswordButtonClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:@"userInfo"];
    if (dict == nil || dict.count == 0) {
        [self showAlertWithTitle:@"Cannot Login" andMessage:@"\nThe password is incorrect"];
        return;
    }
    [self modifyPasswordShow];
}

#pragma mark - 请求事件流
- (void)loadData
{
    //（1）判断是否登录 如果登录则不需要登录请求 否则要登录请求
    NSLog(@"开始加载数据...");
    if ([EmployeeBiz verifyHasLogin]) {
        [self loginAlertViewOnlyPwd];
    }
    else
    {
        //弹出登录框提示登录
        [self loginAlertViewShow];
    }
}

//（1）登录完成的回调
- (void)requestLoginComplete:(NSNotification *)notification
{
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"] && [notification.userInfo[@"oldData"] isKindOfClass:[NSDictionary class]]) { //登录成功
        //如果登录正常进行第二步
        [EmployeeBiz startLoadEmployeeListFromServiceWithTimes:synchronizeTable[@"employee"]];
    }else{
        [self stopLoading];
//        if ([EmployeeBiz verifyHasLogin]) {
//            //直接加载数据
//            [self loginAlertViewOnlyPwd];
//            return; //如果已经登录不需要重复登录
//        }
//        [self loginAlertViewShow];
        [self showAlertWithTitle:@"Cannot Login" andMessage:@"\nThe password is incorrect"];
    }
}

//(2)获取完员工列表的回调
- (void)requestGetEmployeeListComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取员工列表正常
        //第三步,获取学习资料列表
        [self startLoading:@"load learning materials..."];
        [LearningMaterialsBiz startLoadLearningMaterialsDataFromServiceWithWithTimes:synchronizeTable[@"study"]];
    }
}

- (void)requestGetLearningMaterialsComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取学习资料列表成功
        //第四步，获取联系我们
        [self startLoading:@"load contact us infomation..."];
        [ContactUsBiz startLoadContactUsInfoFromServiceWithTimes:synchronizeTable[@"contact"]];
    }
}

//(4)获取联系我们成功成功
- (void)requestGetContactUsInfoComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取联系我们相关信息正常
        //第五步,获取产品类型列表
        [self startLoading:@"load product type..."];
        [ProductBiz startLoadProductTypeDataFromServiceWithWithTimes:synchronizeTable[@"producttype"]];
    }
}

//(5)获取产品类型成功
- (void)requestGetProductTypeComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取产品列表成功
        //第六步,获取产品详细信息
        [self startLoading:@"load products..."];
        [ProductBiz startLoadProductsDataFromServiceWithWithTimes:synchronizeTable[@"product"]];
    }
}

//(6)获取产品详细成功
- (void)requestGetProductsComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取产品详细信息成功
        //第七步,获取热卖产品
        [self startLoading:@"load hot products..."];
        [ProductBiz startLoadHotProductDataFromServiceWithWithTimes:synchronizeTable[@"hotproduct"]];
    }
}

//(7)获取热卖产品成功
- (void)requestGetHotProductComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取热卖产品成功
        //第八步,获取活动类目
        [self startLoading:@"load activities infomation..."];
        [ActivityBiz startLoadActivityItemsFromServiceWithTimes:synchronizeTable[@"activity"]];
    }
}

//(8)如果获得活动类目成功
- (void)requestGetActivityItemsComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取热卖产品成功
        //第九步,获取活动资源
        [self startLoading:@"load activities image resource..."];
        [ActivityBiz startLoadActivityResourceFromServiceWithTimes:synchronizeTable[@"activityres"]];
    }
}

//(9)获取活动资源成功
- (void)requestGetActivityResourceComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取活动资源列表成功
        //第十步,获取关于龙工类目
        [self startLoading:@"load infomation about us..."];
        [AboutBiz startLoadAboutItemsFromServiceWithTimes:synchronizeTable[@"about"]];
    }
}

//(10)获取关于龙工类目成功
- (void)requestGetAboutLonkingItemsComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取关于龙工类目成功
        //第十一步,获取关于龙工资源
        [self startLoading:@"load resource about us..."];
        [AboutBiz startLoadAboutResourceFromServiceWithTimes:synchronizeTable[@"aboutres"]];
    }
}

//(11)获取关于龙工资源成功
- (void)requestGetAboutLonkingResourceComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取关于龙工类目成功
        //第十二步,获取首页轮播图
        [self startLoading:@"load Home Picture..."];
        [HomePicBiz startLoadHomePicDataFromServiceWithWithTimes:synchronizeTable[@"homepic"]];
    }
}

//(12)获取首页轮播图成功
- (void)requestGetHomePicComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取关于龙工类目成功
        //第十三步,获取视频资源列表
        [self startLoading:@"load vedioes..."];
        [VedioBiz startLoadVedioDataFromServiceWithWithTimes:synchronizeTable[@"vedio"]];
    }
}

//(13)获取视频资源成功
- (void)requestGetVediosComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSDictionary *synchronizeTable = [BaseBiz loadSynchronizePlist];
    if (notification.userInfo[@"oldData"]) { //如果获取关于龙工资源成功成功
        //第十四步,获取资源列表
        [self startLoading:@"load all resources list..."];
        [ResourceBiz startLoadResouceListDataFromServiceWithTimes:synchronizeTable[@"resource"]];
    }
}

//（14）获取完所有的资源列表
- (void)requestGetResourceListComplete:(NSNotification *)notification
{
    [self stopLoading];
    NSLog(@"所有数据加载完成加载完成");
    if ([self doResponseWithDictionary:notification.userInfo].count == 0) {
        return;
    }
    NSArray *resourceList = [self doResponseWithDictionary:notification.userInfo];
    if (resourceList) {
        //ActivityModel类
        if (resourceListAry) {
            [resourceListAry removeAllObjects];
        }
        [resourceList enumerateObjectsUsingBlock:^(ResourceModel *obj, NSUInteger idx, BOOL *stop) {
            [resourceListAry addObject:obj]; //将所有图片地址都放入到资源数组中
        }];
        if (notification.userInfo[@"oldData"]) {
             [self dealWithResourceDataArray]; //处理资源数组中不必要的部分
            if (checkUpdate) { //如果是检查更新
                if (resourceListAry.count == 0) {
                    //无更新
                    dotImageView.backgroundColor = [UIColor clearColor];
                }
                else
                {
                    //有更新
                    dotImageView.backgroundColor = [UIColor redColor];
                }
                return;
            }
            if (resourceListAry.count == 0) {
                [self showAlertWithTitle:@"no resource to update..."];
                return; 
            }
            dotImageView.backgroundColor = [UIColor clearColor];
            [self downloadImageFirstObject];
        }
    }
}

- (void)requestModifyPasswordComplete:(NSNotification *)notification
{
    [self stopLoading];
    if (notification.userInfo[@"oldData"] && [notification.userInfo[@"oldData"] isKindOfClass:[NSDictionary class]]) { //登录成功
        [self showAlertWithTitle:@"modify success"];
    }else{
        [self stopLoading];
        [self showAlertWithTitle:@"modify failed"];
    }
}

//*******************************************end****************************************************
#pragma mark 通知注册
- (void)registRequestNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestModifyPasswordComplete:) name:EMPLOYEE_NOTIFICATION_POST_TO_MODIFY_PWD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestLoginComplete:) name:EMPLOYEE_NOTIFICATION_POST_TO_LOGIN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetEmployeeListComplete:) name:EMPLOYEE_NOTIFICATION_GET_LIST object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetLearningMaterialsComplete:) name:LEARNINGMATERIALS_NOTIFICATION_GET_LEARNINGMATERIALS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetContactUsInfoComplete:) name:CONTACTUS_NOTIFICATION_GET_CONTACTINFO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetProductTypeComplete:) name:PRODUCT_NOTIFICATION_GET_PRODUCTTYPE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetProductsComplete:) name:PRODUCT_NOTIFICATION_GET_PRODUCTS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetHotProductComplete:) name:PRODUCT_NOTIFICATION_GET_HOTPRODUCT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetActivityItemsComplete:) name:ACTIVITY_NOTIFICATION_GET_ITEMS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetActivityResourceComplete:) name:ACTIVITY_NOTIFICATION_GET_RESOURCE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetAboutLonkingItemsComplete:) name:ABOUT_NOTIFICATION_GET_ABOUTLONKING_ITEMS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetAboutLonkingResourceComplete:) name:ABOUT_NOTIFICATION_GET_ABOUTLONKING_RESOURCE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetResourceListComplete:) name:RESOURCE_NOTIFICATION_GET_RESOURCELIST object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestResourceImageLoadComplete:) name:RESOURCE_NOTIFICATION_POST_TOGET_RESOURCE object:nil];
    //新添
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetHomePicComplete:) name:NOTIFICATION_GET_HOMEPIC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetVediosComplete:) name:NOTIFICATION_GET_VEDIOS object:nil];
}

- (void)freeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//******************************************下载图片*************************************************
//
//最后加载耗流量耗时间的图片等资源

- (void)downloadImageFirstObject
{
    //取第一个图片地址开始下载图片
    ResourceModel *firstResourceModel = [resourceListAry firstObject];
    [self startLoading:[NSString stringWithFormat:@"There are %lu resources wait for download...", resourceListAry.count-1]];
    [ResourceBiz startLoadImageDataFromServiceWithResourceModel:firstResourceModel];
}
- (void)requestResourceImageLoadComplete:(NSNotification *)notification
{
    [self stopLoading];
    static int i = 1;
    NSArray *tempAry = [self doResponseWithDictionary:notification.userInfo];
    if (tempAry.count == 0) {
        i--;
        return;
    }
    NSLog(@"活动图片的第%d张加载完成!",i);
    i++;
    if ([resourceListAry firstObject]) {
        //加载完成之后将之移除
        [resourceListAry removeObject:[resourceListAry firstObject]];
    }
    if (resourceListAry && resourceListAry.count>0) {
        //如果数组里面还有图片继续加载第一张
        [self downloadImageFirstObject];
    }
    else
    {
        NSLog(@"所有的资源文件加载完毕");
        [self stopLoading];
    }
}

//datasource helper(过滤掉已经下载过的图片,)
- (void)dealWithResourceDataArray
{
    NSMutableArray *needUpdateAry = [@[] mutableCopy];
    for (int i=0; i<resourceListAry.count; i++) {
        ResourceModel *staticResModel = resourceListAry[i];  //当前资源模型
        if ([staticResModel.valid isEqual:@"0"]) { //该数据有效时
            NSString *filePath = [FileHelper defaultFilePathWithFileName:staticResModel.name];
            if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {  //如果不存在该文件
                [needUpdateAry addObject:staticResModel];
            }
        }
    }
    resourceListAry = nil;
    resourceListAry = [needUpdateAry mutableCopy];
}

#pragma mark - 代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //当取消登录时，则终止下载.
    }
    else
    {
        if (alertView.tag == 0) {
            EmployeeModel *model =[[EmployeeModel alloc] init];
            model.userName = agentIDField.text;
            model.password = nameField.text;
            [self startLoading:@"login..."];
            [EmployeeBiz startLoginWithEmployee:model];//员工登录
        }
        else if (alertView.tag == 1)
        {
            //empty now
        }
        else
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *dict = [defaults objectForKey:@"userInfo"];
            EmployeeModel *model = [EmployeeModel loadFromService:dict];
            model.password = nameField.text;
            [self startLoading:@"login..."];
            [EmployeeBiz startLoginWithEmployee:model];
        }
    }
}

#pragma mark - helper
// animation helper
- (void)animationRippleWithImage:(UIImage *)tempImg
{
    CATransition *animation = [CATransition animation];
    animation.type = @"alignedFlip";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    machineImageView.layer.contents = (id)tempImg.CGImage;
    [machineImageView.layer addAnimation:animation forKey:@"Transition"];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *destCtrl = segue.destinationViewController;
    if (sender.tag == 5) {
        ///此时点击的是Vedio
        destCtrl.navigationItem.title = @"Vedio";
    }
    else if (sender.tag == 3)
    {
        destCtrl.navigationItem.title = @"Infomation";
    }
}


@end
