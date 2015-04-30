//
//  AboutLonkingViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-15.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "AboutLonkingViewController.h"
#import "LKImageView.h"
#import "AboutBiz.h"
#import "AboutDAO.h"
#import "AboutModel.h"
#import "AboutDB.h"
#import "FileHelper.h"
#import "ResourceModel.h"

@interface AboutLonkingViewController ()
{
    __weak IBOutlet UITextView *companyIntroducTextView;
    __weak IBOutlet UIScrollView *showCompanyImageScrollView;
    
    //default
    NSMutableArray *defaultImageAry;
}
@end

@implementation AboutLonkingViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

#pragma mark -self
- (void)initSelf
{
    [super initSelf];
    [self showDefaultImageOnScrollView];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scorllviewMoveToRight) userInfo:Nil repeats:YES];
}

- (void)showDefaultImageOnScrollView
{
    if (defaultImageAry == NULL) {
        defaultImageAry = [NSMutableArray array];
    }
    
    AboutDB *tempDB = [AboutDAO findById:@"1"];
    if (tempDB) {
        AboutModel *tempModel = [tempDB toModel];
        companyIntroducTextView.text = tempModel.content;
        companyIntroducTextView.font = [UIFont systemFontOfSize:16.f];
        self.navigationItem.title = tempModel.type;
        self.tabBarItem.title = tempModel.type;
        if (tempModel.imgAry && tempModel.imgAry.count>0) {
            for (int i=0; i<tempModel.imgAry.count; i++) {
                ResourceModel *resModel = tempModel.imgAry[i];
                UIImage *tempImage = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:resModel.name]];
                if (tempImage) {
                    [defaultImageAry addObject:tempImage];
                }
            }
        }
    }
    showCompanyImageScrollView.pagingEnabled = YES;
    showCompanyImageScrollView.contentSize = CGSizeMake(defaultImageAry.count*480, 0);
    [self showCurrentImage];
    [self showNextImage];
}

- (void)showCurrentImage
{
    [self addImageViewOnScrollViewWithPoint:showCompanyImageScrollView.contentOffset];
}

- (void)showNextImage
{
    [self addImageViewOnScrollViewWithPoint:CGPointMake(showCompanyImageScrollView.contentOffset.x+showCompanyImageScrollView.frame.size.width, showCompanyImageScrollView.contentOffset.y)];
}

- (void)addImageViewOnScrollViewWithPoint:(CGPoint)point
{
    UIView *checkView = [showCompanyImageScrollView viewWithTag:point.x/showCompanyImageScrollView.frame.size.width];
    if (checkView&&([checkView isMemberOfClass:[LKImageView class]])) {
        return;
    }
    if (point.x/showCompanyImageScrollView.frame.size.width>=[defaultImageAry count]) {
        return;
    }
    LKImageView *testIMG = [[LKImageView alloc] initWithFrame:CGRectMake(point.x, 0, 480, 360)];
    testIMG.superViewController = self;
    testIMG.userInteractionEnabled = YES;
    testIMG.contentMode = UIViewContentModeScaleToFill;
    [testIMG addTapGesture];
    testIMG.image = [defaultImageAry objectAtIndex:point.x/showCompanyImageScrollView.frame.size.width];
    testIMG.tag = point.x/showCompanyImageScrollView.frame.size.width;
    [showCompanyImageScrollView addSubview:testIMG];
}

//视图向右滑动
- (void)scorllviewMoveToRight
{
    if (![self checkContentOffset]) {
        return;
    }
    if (showCompanyImageScrollView.contentOffset.x>=(showCompanyImageScrollView.contentSize.width-showCompanyImageScrollView.frame.size.width)) {
        [showCompanyImageScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    else
    {
        [showCompanyImageScrollView setContentOffset:CGPointMake(showCompanyImageScrollView.contentOffset.x+showCompanyImageScrollView.frame.size.width, 0) animated:NO];
    }
    [self doAnimationPushWithdirectionLeft:NO];
    [self showNextImage];
}

- (void)doAnimationPushWithdirectionLeft:(BOOL)directionFromLeft
{
    CATransition *transition = [CATransition animation];
    
    transition.duration = 0.3f;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    transition.type = kCATransitionPush;
    
    if (directionFromLeft) {
        transition.subtype = kCATransitionFromLeft;
    }
    else
    {
        transition.subtype = kCATransitionFromRight;
    }
    
    transition.delegate = self;
    
    for (LKImageView *tempImg in [showCompanyImageScrollView subviews]) {
        if ([tempImg isMemberOfClass:[LKImageView class]]) {
            [tempImg.layer addAnimation:transition forKey:nil];
        }
    }
}

- (BOOL)checkContentOffset
{
    int a = (int)showCompanyImageScrollView.contentOffset.x%(int)showCompanyImageScrollView.frame.size.width;
    if (a != 0) {
        return NO;
    }
    return YES;
}

#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self showCurrentImage];
    [self showNextImage];
}

#pragma mark - 通知管理
- (void)registNotification
{
    
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
