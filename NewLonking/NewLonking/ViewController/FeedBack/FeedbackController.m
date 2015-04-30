//
//  FeedbackController.m
//  Lonking
//
//  Created by 李健 on 14-2-25.
//  Copyright (c) 2014年 李健. All rights reserved.
//

#import "FeedbackController.h"
#import "TimeHelper.h"
#import "QBFlatButton.h"

@interface FeedbackController ()

@end

@implementation FeedbackController
@synthesize defaultProductName;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitCustomerInfoSuccess) name:@"submit CustomerInfo success" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"product_name" object:nil userInfo:@{@"name":self.defaultProductName}];
}

- (void)initSelf
{
    [super initSelf];
//    for (QBFlatButton *tempBtn in [self.view subviews]) {
//        if ([tempBtn isKindOfClass:[QBFlatButton class]]) {
//            tempBtn.faceColor = rgbaColor(86, 161, 217, 1);
//            tempBtn.sideColor = rgbaColor(53, 103, 140, 1);
//            tempBtn.radius = 6.0;
//            tempBtn.margin = 7.0;
//            tempBtn.depth = 6.0;
//        }
//    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *temp in [self.view subviews]) {
        if ([temp isMemberOfClass:[UITextField class]]) {
            [temp resignFirstResponder];
        }
    }
}

- (IBAction)backToRootViewCtrl:(id)sender
{
    [CommonHelper postNotification:@"notification send customer infomation in FeedBackSubViews" userInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 通知回调
- (void)submitCustomerInfoSuccess
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
