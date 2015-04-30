//
//  FeedbackSubviewController.m
//  Lonking
//
//  Created by 李健 on 14-2-26.
//  Copyright (c) 2014年 李健. All rights reserved.
//

#import "FeedbackSubviewController.h"
#import "Customers.h"
#import "FeedBackBiz.h"

@interface FeedbackSubviewController ()
{
   __weak IBOutlet UITextField *purposeTextView;
   __weak IBOutlet UITextField *nameTextView;
   __weak IBOutlet UITextField *countryTextView;
   __weak IBOutlet UITextField *emailTextView;
}
@end

@implementation FeedbackSubviewController
@synthesize productName,customerCountry,customerEmail,customerName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //注册通知，监听点击submit事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProductName:) name:@"product_name" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postCustomerInfoToService) name:@"notification send customer infomation in FeedBackSubViews" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPostCustomerInfoComplete:) name:FEEDBACK_NOTIFICATION_POST_CUSTOMERINFO object:nil];
}

- (void)getProductName:(NSNotification *)notification
{
    NSDictionary *userDict = [notification userInfo];
    NSString *tempName = [userDict objectForKey:@"name"];
    purposeTextView.text = tempName;
}

- (void)loadDataInForm
{
    self.productName = [self checkStringValue:purposeTextView.text];
    self.customerCountry = [self checkStringValue:countryTextView.text];
    self.customerEmail = [self checkStringValue:emailTextView.text];
    self.customerName = [self checkStringValue:nameTextView.text];
}

- (NSString *)checkStringValue:(NSString *)checkStr
{
    return (checkStr == nil)?@"":checkStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 通知回调
- (void)postCustomerInfoToService
{
    [self loadDataInForm];
    Customers *tempModel = [[Customers alloc] init];
    tempModel.interestedProductName = self.productName;
    tempModel.country = self.customerCountry;
    tempModel.email = self.customerEmail;
    tempModel.name = self.customerName;
    [FeedBackBiz startSendCustomerInfoToServiceWithWithCustomers:tempModel];
}

- (void)requestPostCustomerInfoComplete:(NSNotification *)notification
{
    if (notification.userInfo[@"oldData"]) {
        //说明提交成功
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"submit success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"submit CustomerInfo success" object:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"submit failed" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}
@end
