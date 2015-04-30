//
//  HomeViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-12.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "HomeViewController.h"
#import "LKImageView.h"
#import "QBFlatButton.h"
#import "FileHelper.h"

///////
#import "HotProductDAO.h"
#import "HotProductDB.h"
#import "HotProductModel.h"
#import "ResourceDB.h"

#import "ProductTypeDAO.h"
#import "ProductTypeDB.h"

@interface HomeViewController ()
{
    __weak IBOutlet UIScrollView *mainScrollView;
    __weak IBOutlet UIPageControl *pageControl;
    
    //default
    NSMutableArray *defaultImageAry;
    NSDictionary *btnTitleAndSegueIdentify;
    NSDictionary *segueIdentifyAndBtnTitle;
    int tag;
}
@end

@implementation HomeViewController

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
}

-(void)viewDidAppear:(BOOL)animated{
    tag = 0;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (tag == 0) {
        if ([self.view window] == nil)// 是否是正在使用的视图
        {
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        defaultImageAry = nil;
        btnTitleAndSegueIdentify = nil;
        segueIdentifyAndBtnTitle = nil;
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}

#pragma mark - 事件处理
- (IBAction)categoryButtonClick:(id)sender
{
    tag = 1;
    UIButton *senderBtn = (UIButton *)sender;
    NSString * name = [btnTitleAndSegueIdentify objectForKey:senderBtn.titleLabel.text]; //segue identify
    if (name != nil) {
        [self performSegueWithIdentifier:name sender:sender];
    }
}

#pragma mark -界面初始化
- (void)initSelf
{
    [super initSelf];
    [self drawButtonBoarder];
    [self showDefaultImageOnView];
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scorllviewMoveToRight) userInfo:Nil repeats:YES];
}
- (void)drawButtonBoarder
{
    NSArray *productTypeAry = [ProductTypeDAO findAll];   //ProductTypeDB
    if (productTypeAry == nil || productTypeAry.count == 0) {
        for (UIButton *tempBtn in [self.view subviews]) {
            if ([tempBtn isKindOfClass:[UIButton class]]) {
                tempBtn.hidden = YES;
            }
        }
        return;
    }
    NSArray *segueIdentify = @[BULLDOZER,CONTAINERSTACKER,WHEELLOADER,EXCAVATOR,FORKLIFT,ROADROLLER,SKIDLOADER,MOTORGRADER];
    
    NSMutableDictionary *tempDict = [@{} mutableCopy];
    NSMutableDictionary *tempDictOne = [@{} mutableCopy];
    for (int i=0; i<productTypeAry.count; i++) {
        ProductTypeDB *tempPDB = productTypeAry[i];
        [tempDict setValue:segueIdentify[i] forKey:tempPDB.typeName]; //button title and segue identify
        [tempDictOne setValue:tempPDB.typeName forKey:segueIdentify[i]]; //segue identify and button title
    }
    btnTitleAndSegueIdentify = [tempDict copy];
    segueIdentifyAndBtnTitle = [tempDictOne copy];
    
    int buttonTag = 0;
    for (UIButton *tempBtn in [self.view subviews]) {
        if ([tempBtn isKindOfClass:[UIButton class]]) {
            tempBtn.tag = buttonTag;
            buttonTag++;
            ProductTypeDB *tempPDB = productTypeAry[tempBtn.tag];
            [tempBtn setTitle:tempPDB.typeName forState:UIControlStateNormal];
        }
    }
}

#pragma mark  default image show
- (void)showDefaultImageOnView
{
    [self productShow];
}

-(void)productShow
{
    if (defaultImageAry == NULL) {
        defaultImageAry = [NSMutableArray array];
    }
    
    //获取所有的热卖产品, type:HotProductDB
    NSArray *tempAry = [HotProductDAO findAll];
    if (tempAry && tempAry.count) {
        for (int i=0; i<tempAry.count; i++) {
            HotProductDB *tempHotProductDB = tempAry[i];
            UIImage *tempImage = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:tempHotProductDB.resource.name]];
            if (tempImage) {
                [defaultImageAry addObject:tempImage];
            }
        }
    }
    
    mainScrollView.contentSize = CGSizeMake(mainScrollView.frame.size.width*[defaultImageAry count], 0);
    mainScrollView.pagingEnabled = YES;
    
    for (int i=0; i<[defaultImageAry count]; i++) {
        LKImageView *testIMG = [[LKImageView alloc] initWithFrame:CGRectMake(i*mainScrollView.frame.size.width, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
        testIMG.contentMode = UIViewContentModeScaleAspectFill;
        testIMG.superViewController = self;
        testIMG.userInteractionEnabled = YES;
        [testIMG addTapGesture];
        testIMG.image = [defaultImageAry objectAtIndex:i];
        [mainScrollView addSubview:testIMG];
    }
    
    pageControl.numberOfPages = [defaultImageAry count];
    pageControl.currentPage = 0;
    defaultImageAry = nil;
}

- (BOOL)checkContentOffset
{
    int a = (int)mainScrollView.contentOffset.x%(int)mainScrollView.frame.size.width;
    if (a != 0) {
        return NO;
    }
    return YES;
}

//视图向右滑动
- (void)scorllviewMoveToRight
{
    if (mainScrollView == nil) {
        return;
    }
    if (![self checkContentOffset]) {
        return;
    }
    if (mainScrollView.contentOffset.x>=(mainScrollView.contentSize.width-mainScrollView.frame.size.width)) {
        [mainScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    else
    {
        [mainScrollView setContentOffset:CGPointMake(mainScrollView.contentOffset.x+mainScrollView.frame.size.width, 0) animated:NO];
    }
    [self doAnimationPushWithdirectionLeft:NO];
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
    
    for (LKImageView *tempImg in [mainScrollView subviews]) {
        if ([tempImg isMemberOfClass:[LKImageView class]]) {
            [tempImg.layer addAnimation:transition forKey:nil];
        }
    }
}

#pragma mark -delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    pageControl.currentPage = page;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    id destinationOBJ = segue.destinationViewController;
    NSString * tempValue = [segueIdentifyAndBtnTitle objectForKey:segue.identifier];
    [destinationOBJ setValue:tempValue forKey:@"category"];
    [destinationOBJ setValue:tempValue forKey:@"titleName"];
}
@end
