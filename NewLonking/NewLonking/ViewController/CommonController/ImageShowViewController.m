//
//  ImageShowViewController.m
//  NewLonking
//
//  Created by 李健 on 14-9-1.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ImageShowViewController.h"
#import "ImageCropperView.h"

@interface ImageShowViewController ()
{
    __weak IBOutlet ImageCropperView *mainImageView;
}
@end

@implementation ImageShowViewController
@synthesize bigImage;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件处理
- (void)tap:(UIGestureRecognizer *)gesture
{
//    if (self.navigationController.navigationBarHidden == YES) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//    else
//    {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 界面处理
- (void)initSelf
{
    [super initSelf];
    [mainImageView setup];
    mainImageView.image = self.bigImage;
    [self registTapGesture];
}

- (void)registTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [mainImageView addGestureRecognizer:tapGesture];
}
#pragma mark - 通知管理

#pragma mark - 通知回调处理

@end
