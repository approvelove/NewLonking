//
//  LonkingMilestonesViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "LonkingMilestonesViewController.h"
#import "AboutBiz.h"
#import "AboutDAO.h"
#import "AboutModel.h"
#import "AboutDB.h"
#import "ResourceModel.h"

@interface LonkingMilestonesViewController ()
{
    __weak IBOutlet UITextView *contentTextView;
}
@end

@implementation LonkingMilestonesViewController

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
    AboutDB *tempDB = [AboutDAO findById:@"2"];
    AboutModel *tempModel = [tempDB toModel];
    contentTextView.text = tempModel.content;
    contentTextView.font = [UIFont systemFontOfSize:16.f];
    self.navigationItem.title = tempModel.type;
    self.tabBarItem.title = tempModel.type;
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
