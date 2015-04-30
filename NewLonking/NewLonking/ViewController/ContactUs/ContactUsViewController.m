//
//  ContactUsViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-23.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ContactUsViewController.h"
#import "ContactUsBiz.h"
#import "ContactsModel.h"

@interface ContactUsViewController ()
{
    __weak IBOutlet UITextField *companyNameLabel;
    __weak IBOutlet UITextField *webSiteLabel;
    __weak IBOutlet UITextField *telLabel;
    __weak IBOutlet UITextField *eMailLabel;
    __weak IBOutlet UITextField *eFaxLabel;
    CGFloat kbHeight;
}
@end

@implementation ContactUsViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitCustomerInfoSuccess) name:@"submit CustomerInfo success from FormView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIButton *tempBtn in [self.view subviews]) {
        if ([tempBtn isKindOfClass:[UIButton class]]) {
            tempBtn.layer.cornerRadius = 6.f;
        }
    }
//    self.navigationController.navigationBarHidden = NO;
}

- (void)initSelf
{
    [super initSelf];
    NSDictionary *contactUsDict = [ContactUsBiz loadPlistWithPlistName:@"ContactUs.plist"];
    if (!contactUsDict) {
        return;
    }
    ContactsModel *contactModel = [ContactsModel loadFromService:contactUsDict];
    if (contactModel) {
        companyNameLabel.text = contactModel.company;
        webSiteLabel.text = contactModel.website;
        telLabel.text = contactModel.tel;
        eMailLabel.text = contactModel.email;
        eFaxLabel.text = contactModel.eFax;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 事件处理
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    kbHeight = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -kbHeight); //平移SearchBar
    }];
}

- (void)keyboardwillHide:(NSNotification *)notification
{
//    NSDictionary *userInfo = notification.userInfo;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, kbHeight); //平移searchBar
    }];
}

- (IBAction)submitButtonClick:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification submit customer info From contactViewController" object:nil];
}

#pragma mark - 通知回调
////////客户信息提交后
- (void)submitCustomerInfoSuccess
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
