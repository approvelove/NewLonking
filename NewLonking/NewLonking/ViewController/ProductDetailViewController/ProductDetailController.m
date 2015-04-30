//
//  ProductDetailController.m
//  Lonking
//
//  Created by 李健 on 14-2-25.
//  Copyright (c) 2014年 李健. All rights reserved.
//

#import "ProductDetailController.h"
#import "LKImageView.h"
#import "QBFlatButton.h"

#import "Products.h"
#import "ProductsDAO.h"
#import "ProductsDB.h"
#import "FileHelper.h"
#import "ResourceModel.h"
#import "GraphicHelper.h"

@interface ProductDetailController ()
{
    __weak IBOutlet LKImageView *productImage; //产品图片
    __weak IBOutlet LKImageView *modelImage;  //产品矢量图
}
@end

@implementation ProductDetailController
@synthesize productName,productIdentify;

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

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 界面初始化处理
- (void)initSelf
{
    [super initSelf];
    self.navigationItem.title = self.productName;
    ProductsDB *myPrdDB = [ProductsDAO findById:self.productIdentify];
    Products *myPrd = [myPrdDB toModel];
    if (myPrd) {
        UIImage *tempImage = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:myPrd.imgModel.name]];
        if (tempImage.size.width>400 || tempImage.size.height>400) {
            tempImage = [GraphicHelper imageWithMaxSide:400.f sourceImage:tempImage];
        }
        productImage.image = tempImage; //产品图样
        
        UIImage *tempModelImage = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:myPrd.modelImageModel.name]];   //产品模型图
        if (tempModelImage.size.width>1600 || tempModelImage.size.height>1600) {
            tempModelImage = [GraphicHelper imageWithMaxSide:1600.f sourceImage:tempModelImage];
        }
        if (tempModelImage) {
            modelImage.image = tempModelImage;
            [modelImage addTapGesture];
            modelImage.superViewController = self;
        }
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *segueCtrl = segue.destinationViewController;
    [segueCtrl setValue:self.productName forKey:@"defaultProductName"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        productImage = nil;
        modelImage = nil;
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}
@end
