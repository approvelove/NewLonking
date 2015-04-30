//
//  InformationViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-23.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "InformationViewController.h"
#import "EmployeeModel.h"
#import "InformationViewCell.h"
#import "LearningMaterials.h"
#import "FileHelper.h"
#import "EmployeeBiz.h"
#import "LearningMaterialsBiz.h"
#import "LearningMaterialsDB.h"
#import "LearningMaterialsDAO.h"

#import "VedioBiz.h"
#import "VedioModel.h"
#import "VedioDB.h"
#import "VedioDAO.h"

@interface InformationViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *agentIDField;
    UITextField *nameField;
    EmployeeModel *employeeInUse;
    __weak IBOutlet UITableView *resourceTabelView;
    NSArray *learningMaterialsAry;
    BOOL hasLogIn;
}
@end

@implementation InformationViewController

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
    hasLogIn = NO;  ///初始化是否验证登录状态
    [self sendMessageForHasLoginValueStatus];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registNotification];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self freeNotification];
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
#pragma mark -datasource
//其他学习资料
-(void)loadInformationDataFromDB
{
    //加载数据
    NSArray *tempDB = [LearningMaterialsDAO findAll];
    NSMutableArray *tempAry = [@[] mutableCopy];
    if (tempDB && tempDB.count>0) {
        [tempDB enumerateObjectsUsingBlock:^(LearningMaterialsDB *obj, NSUInteger idx, BOOL *stop) {
            LearningMaterials *learnMaterialModel = [obj toModel];
            [tempAry addObject:learnMaterialModel];
        }];
    }
    learningMaterialsAry = [tempAry copy];
    [resourceTabelView reloadData];
}

//视频资料
- (void)loadVedioDataFromDB
{
    //加载数据
    NSArray *tempDB = [VedioDAO findAll];
    NSMutableArray *tempAry = [@[] mutableCopy];
    if (tempDB && tempDB.count>0) {
        [tempDB enumerateObjectsUsingBlock:^(VedioDB *obj, NSUInteger idx, BOOL *stop) {
            VedioModel *vedioModel = [obj toModel];
            LearningMaterials *tempModel = [vedioModel toLearningMaterials];
            [tempAry addObject:tempModel];
        }];
    }
    learningMaterialsAry = [tempAry copy];
    [resourceTabelView reloadData];
}
#pragma mark - 界面处理
- (void)initSelf
{
    [super initSelf];
    if ([self.navigationItem.title isEqualToString:@"Infomation"]) {
        [self loadInformationDataFromDB];
        [self loginAlertViewShow];
    }
    else
    {
        [self loadVedioDataFromDB];
    }
}

- (void)loginAlertViewOnlyPwd
{
    UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Login" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
    loginAlert.tag = 2;
    loginAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    nameField = [loginAlert textFieldAtIndex:0];
    nameField.placeholder = @"password";
    nameField.secureTextEntry = NO;
    [loginAlert show];
}

- (void)loginAlertViewShow
{
    if ([EmployeeBiz verifyHasLogin]) {
        //直接加载数据
         [self loginAlertViewOnlyPwd];
        return; //如果已经登录不需要重复登录
    }
    UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Login" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
    loginAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    agentIDField = [loginAlert textFieldAtIndex:0];
    agentIDField.placeholder = @"username";
    nameField = [loginAlert textFieldAtIndex:1];
    nameField.placeholder = @"password";
    [loginAlert show];
}

- (void)forbiddenUserInterActionOnView
{
    self.view.userInteractionEnabled = NO;
}

#pragma mark - 代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
//        [self forbiddenUserInterActionOnView];
        hasLogIn = NO;
        [self sendMessageForHasLoginValueStatus];
    }
    else
    {
        if (alertView.tag == 2) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *dict = [defaults objectForKey:@"userInfo"];
            EmployeeModel *model = [EmployeeModel loadFromService:dict];
            hasLogIn = YES;  //先假设已经登录成功
            if (![[CommonHelper md5:nameField.text] isEqualToString:model.password]) {
//                if ([EmployeeBiz verifyHasLogin]) {
//                    //直接加载数据
//                    [self loginAlertViewOnlyPwd];
//                    return; //如果已经登录不需要重复登录
//                }
//                [self loginAlertViewShow];
                ///该处不再弹出登录框,也不禁用屏幕,弹出提示
                [self showAlertWithTitle:@"Cannot Login" andMessage:@"\nThe password is incorrect"];
                hasLogIn = NO;
            }
            [self sendMessageForHasLoginValueStatus];
        }
        else
        {
             [self getEmployeeInfo];
        }
    }
}

//tabelView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!learningMaterialsAry || learningMaterialsAry.count == 0) {
        return 0;
    }
    else
    {
        return learningMaterialsAry.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    InformationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [InformationViewCell loadFromNib];
        cell.superController = self;
    }
    [self loadCellWithCell:cell andIndexPath:indexPath];
    return cell;
}

//cell init helper
- (void)loadCellWithCell:(InformationViewCell *)cell andIndexPath:(NSIndexPath *)indexPath
{
    [cell initWithLearningMaterials:learningMaterialsAry[indexPath.row] currentPageName:self.navigationItem.title];
}

#pragma mark - 界面数据封装
- (void)getEmployeeInfo
{
    if (!employeeInUse) {
        employeeInUse = [[EmployeeModel alloc] init];
    }
    employeeInUse.userName = agentIDField.text;
    employeeInUse.password = nameField.text;
    //发送登录请求
    [self startLoading:@"login..."];
    [EmployeeBiz startLoginWithEmployee:employeeInUse];
}

#pragma mark - 通知回调
- (void)requestLoginComplete:(NSNotification *)notification
{
    if (notification.userInfo[@"oldData"] && [notification.userInfo[@"oldData"] isKindOfClass:[NSDictionary class]]) {
        //登录成功
        [self stopLoading];
        hasLogIn = YES;
        [self sendMessageForHasLoginValueStatus];
    }
    else
    {
        [self stopLoading];
//        if ([EmployeeBiz verifyHasLogin]) {
//            //直接加载数据
//            [self loginAlertViewOnlyPwd];
//            return; //如果已经登录不需要重复登录
//        }
//        [self loginAlertViewShow];
        hasLogIn = NO;
        [self showAlertWithTitle:@"Cannot Login" andMessage:@"\nThe password is incorrect"];
        [self sendMessageForHasLoginValueStatus];
    }
}

#pragma mark - helper
- (void)sendMessageForHasLoginValueStatus
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_STATUS_CHANGED object:nil userInfo:@{@"loginStatus":@(hasLogIn)}];
}

#pragma mark - 注册通知
- (void)registNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestLoginComplete:) name:EMPLOYEE_NOTIFICATION_POST_TO_LOGIN object:nil];
    if ([EmployeeBiz verifyHasLogin]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAlertViewOnlyPwd) name:VERIFY_LOGIN_NOT_LOGIN object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAlertViewShow) name:VERIFY_LOGIN_NOT_LOGIN object:nil];
    }
}

- (void)freeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EMPLOYEE_NOTIFICATION_POST_TO_LOGIN object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:VERIFY_LOGIN_NOT_LOGIN object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
