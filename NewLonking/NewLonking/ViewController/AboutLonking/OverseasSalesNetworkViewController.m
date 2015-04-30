//
//  OverseasSalesNetworkViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "OverseasSalesNetworkViewController.h"
#import "AboutBiz.h"
#import "AboutDAO.h"
#import "AboutModel.h"
#import "AboutDB.h"
#import "FileHelper.h"
#import "ResourceModel.h"

@interface OverseasSalesNetworkViewController ()
{
    __weak IBOutlet UIImageView *mainImageView;
}
@end

@implementation OverseasSalesNetworkViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSelf
{
    [super initSelf];
    AboutDB *tempDB = [AboutDAO findById:@"3"];
    AboutModel *tempModel = [tempDB toModel];
    self.navigationItem.title = tempModel.type;
    self.tabBarItem.title = tempModel.type;
    if (tempModel.imgAry && tempModel.imgAry.count>0) {
        ResourceModel *resModel = [tempModel.imgAry lastObject];
        UIImage *tempImage = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:resModel.name]];
        mainImageView.image = tempImage;
    }
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
