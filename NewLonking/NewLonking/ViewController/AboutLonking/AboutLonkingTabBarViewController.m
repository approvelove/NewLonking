//
//  AboutLonkingTabBarViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-15.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "AboutLonkingTabBarViewController.h"
#import "AboutBiz.h"
#import "AboutDAO.h"
#import "AboutModel.h"
#import "AboutDB.h"
#import "ResourceModel.h"

@interface AboutLonkingTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation AboutLonkingTabBarViewController

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
    [self initSelf];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 界面初始化
- (void)initSelf
{
    //调用tabbar的代理
    self.delegate = self;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self editNavigationTitle];
    [self initTabBarTitle];
}

- (void)initTabBarTitle
{
    for (int i=1; i<=self.viewControllers.count; i++) {
        NSString *idString = [@(i) stringValue];
        AboutDB *tempDB = [AboutDAO findById:idString];
        if (tempDB) {
            AboutModel *tempModel = [tempDB toModel];
            UIViewController *tempController = self.viewControllers[i-1];
            tempController.tabBarItem.title = tempModel.type;
        }
    }
}

- (void)editNavigationTitle
{
    if (self.selectedViewController) {
        self.navigationItem.title = self.selectedViewController.title;
    }
    else
    {
        UIViewController *defaultCtrl = [self.viewControllers firstObject];
        self.navigationItem.title = defaultCtrl.title;
    }
}

#pragma mark - 代理
//tabbar delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self editNavigationTitle];
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
