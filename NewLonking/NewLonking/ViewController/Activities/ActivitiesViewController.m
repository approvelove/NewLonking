//
//  ActivitiesViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-23.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ActivitiesViewController.h"
#import "LKImageView.h"
#import "FileHelper.h"

//从数据库读取数据源
#import "ActivitiesDAO.h"
#import "ActivitiesDB.h"
#import "ActivitiesModel.h"
#import "ResourceModel.h"

typedef NS_ENUM(NSInteger, SHOW_IMAGE) {
    SHOW_IMAGE_ONE,
    SHOW_IMAGE_TWO,
    SHOW_IMAGE_THREE
};

@interface ActivitiesViewController ()<UITabBarDelegate>
{
    IBOutlet UIScrollView * activiesScrollView;
    NSMutableArray *mainProductIMGAry;
    NSMutableArray *tourLonkingAry;
    NSMutableArray *distributorAry;
    NSMutableArray *internationalAry;
    NSMutableArray *globalSummitAry;
    
    __weak IBOutlet UITabBarItem *itemOne;
    __weak IBOutlet UITabBarItem *itemTwo;
    __weak IBOutlet UITabBarItem *itemThree;
    __weak IBOutlet UITabBar *mainTabBar;
    
    ActivitiesModel *modelOne;
    ActivitiesModel *modelTwo;
    ActivitiesModel *modelThree;
}
@end

@implementation ActivitiesViewController

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
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}

#pragma mark -界面初始化
- (void)initSelf
{
    [super initSelf];
    [self loadDataFromCoreData];
    //default
    mainTabBar.selectedItem = mainTabBar.items[0];
    [self distributorActivitiesShow:nil];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scorllviewMoveToRight) userInfo:Nil repeats:YES];
}

- (void)loadDataFromCoreData
{
    NSArray *activityItemsAry = [ActivitiesDAO findAll];
    if (activityItemsAry.count == 1) {
        [self initItemsOneWithActivityAry:activityItemsAry];
    }
    if (activityItemsAry.count == 2) {
        [self initItemsTwoWithActivityAry:activityItemsAry];
    }
    if (activityItemsAry.count == 3) {
        [self initItemsThreeWithActivityAry:activityItemsAry];
    }
}

- (void)initItemsOneWithActivityAry:(NSArray *)ary
{
    ActivitiesDB *activityDBDataOne = ary[0];
    modelOne = [activityDBDataOne toModel];
    itemOne.title = modelOne.type;
}

- (void)initItemsTwoWithActivityAry:(NSArray *)ary
{
    [self initItemsOneWithActivityAry:ary];
    ActivitiesDB *activityDBDataTwo = ary[1];
    modelTwo = [activityDBDataTwo toModel];
    itemTwo.title = modelTwo.type;
}

- (void)initItemsThreeWithActivityAry:(NSArray *)ary
{
    [self initItemsTwoWithActivityAry:ary];
    ActivitiesDB *activityDBDataThree = ary[2];
    modelThree = [activityDBDataThree  toModel];
    itemThree.title = modelThree.type;
}

#pragma mark - 显示产品

- (void)prodouctShowWithType:(SHOW_IMAGE)type
{
    if (mainProductIMGAry) {
        mainProductIMGAry = nil;
    }
    mainProductIMGAry = [NSMutableArray array];
    switch (type) {
            break;
        case SHOW_IMAGE_ONE:
        {
            for (int i=0; i<modelOne.imgAry.count; i++) {
                ResourceModel *tempModel = modelOne.imgAry[i];
                UIImage *tempImage = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:tempModel.name]];
                if (tempImage) {
                    [mainProductIMGAry addObject:tempImage];
                }
            }
        }
            break;
        case SHOW_IMAGE_TWO:
        {
            for (int i=0; i<modelTwo.imgAry.count; i++) {
                ResourceModel *tempModel = modelTwo.imgAry[i];
                UIImage *tempImage = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:tempModel.name]];
                if (tempImage) {
                    [mainProductIMGAry addObject:tempImage];
                }
            }
        }
            break;
        case SHOW_IMAGE_THREE:
        {
            for (int i=0; i<modelThree.imgAry.count; i++) {
                ResourceModel *tempModel = modelThree.imgAry[i];
                UIImage *tempImage = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:tempModel.name]];
                if (tempImage) {
                    [mainProductIMGAry addObject:tempImage];
                }
            }
        }
            break;
        default:
            break;
    }
    
    for (LKImageView *tempView in [activiesScrollView subviews]) {
        [tempView removeFromSuperview];
    }
    [activiesScrollView setContentOffset:CGPointZero];
    activiesScrollView.contentSize = CGSizeMake(activiesScrollView.frame.size.width*[mainProductIMGAry count], 0);
    [self showCurrentImage];
    [self showNextImage];
}


//show activity item one
- (void)distributorActivitiesShow:(id)sender
{
    [self prodouctShowWithType:SHOW_IMAGE_ONE];
}

//show activity item two
- (void)internationalExhibitionsShow:(id)sender
{
    [self prodouctShowWithType:SHOW_IMAGE_TWO];
}

//show activity item three
- (void)lonkingGlobalSummitShow:(id)sender
{
    [self prodouctShowWithType:SHOW_IMAGE_THREE];
}

////
- (void)showCurrentImage
{
    [self addImageViewOnScrollViewWithPoint:activiesScrollView.contentOffset];
}

- (void)showNextImage
{
    [self addImageViewOnScrollViewWithPoint:CGPointMake(activiesScrollView.contentOffset.x+activiesScrollView.frame.size.width, activiesScrollView.contentOffset.y)];
}

- (void)addImageViewOnScrollViewWithPoint:(CGPoint)point
{
    UIView *checkView = [activiesScrollView viewWithTag:point.x/activiesScrollView.frame.size.width];
    if (checkView&&([checkView isMemberOfClass:[LKImageView class]])) {
        return;
    }
    if (point.x/activiesScrollView.frame.size.width>=[mainProductIMGAry count]) {
        return;
    }
    
    LKImageView *testIMG = [[LKImageView alloc] initWithFrame:CGRectMake(point.x, 0, activiesScrollView.frame.size.width, activiesScrollView.frame.size.height)];
    testIMG.superViewController = self;
    testIMG.userInteractionEnabled = YES;
    testIMG.contentMode = UIViewContentModeScaleAspectFill;
//    [testIMG addTapGesture];
    testIMG.image = [mainProductIMGAry objectAtIndex:point.x/activiesScrollView.frame.size.width];
    testIMG.tag = point.x/activiesScrollView.frame.size.width;
    [activiesScrollView addSubview:testIMG];
}

//视图向右滑动
- (void)scorllviewMoveToRight
{
    if (![self checkContentOffset]) {
        return;
    }
    if (activiesScrollView.contentOffset.x>=(activiesScrollView.contentSize.width-activiesScrollView.frame.size.width)) {
        [activiesScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    else
    {
        [activiesScrollView setContentOffset:CGPointMake(activiesScrollView.contentOffset.x+activiesScrollView.frame.size.width, 0) animated:NO];
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
    
    for (LKImageView *tempImg in [activiesScrollView subviews]) {
        if ([tempImg isMemberOfClass:[LKImageView class]]) {
            [tempImg.layer addAnimation:transition forKey:nil];
        }
    }
}

- (BOOL)checkContentOffset
{
    int a = (int)activiesScrollView.contentOffset.x%(int)activiesScrollView.frame.size.width;
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


///main tabbar delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSArray *methodNameAry = @[@"distributorActivitiesShow:",@"internationalExhibitionsShow:",@"lonkingGlobalSummitShow:"];
    if ([self respondsToSelector:NSSelectorFromString(methodNameAry[item.tag])]) {
        [self performSelector:NSSelectorFromString(methodNameAry[item.tag]) withObject:self afterDelay:0.f];
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
