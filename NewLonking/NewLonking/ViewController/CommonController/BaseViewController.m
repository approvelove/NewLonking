//
//  BaseViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-4.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

#define APP_WINDOW [[UIApplication sharedApplication] keyWindow]

@interface BaseViewController ()

@end

@implementation BaseViewController

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
//添加键盘监听
    [self initSelf];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([NSStringFromClass([self class]) isEqualToString:@"MenuViewController"]) {
        self.navigationController.navigationBarHidden = YES;
        
    }
    else
    {
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 界面初始化
- (void)initSelf
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
}

#pragma mark - helper

- (void)startLoading
{
    [self startLoading:@"loading..."];
}

- (void)stopLoading
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)startLoading:(NSString *)labelText
{
    [[MBProgressHUD showHUDAddedTo:self.view animated:YES] setLabelText:labelText];
}

- (void)backToRootWithRootViewControllerName:(NSString *)controller
{
    NSLog(@"className = %@",NSStringFromClass([self class]));
    if (self) {
        if ([NSStringFromClass([self class]) isEqualToString:controller]) {
            return;
        }
        if (self.navigationController) {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        else
        {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }
}

- (void)showAlertWithTitle:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (NSArray *)doResponseWithDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary.count == 0) {
        //可能失败了，也可能是没有数据了
        if (aDictionary[@"oldData"]) {
            [self showAlertWithTitle:@"该数据是最新的了..."];
        }
        else
        {
            [self showAlertWithTitle:@"请求发生错误了..."];
        }
        return nil;
    }
    return aDictionary[@"resultData"];
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
