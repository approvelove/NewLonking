//
//  ProductListViewController.m
//  NewLonking
//
//  Created by 李健 on 14-8-29.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ProductListViewController.h"
#import "Products.h"
#import "ProductsDAO.h"
#import "ProductsDB.h"
#import "ProductTypeModel.h"
//default
#import "QBFlatButton.h"
#import "FileHelper.h"
#import "ProductTypeDB.h"
#import "ProductTypeDAO.h"
#import "ResourceDB.h"

@interface ProductListViewController ()
{
    IBOutlet UIImageView *categoryImageView;
    NSMutableArray *productAry;
    int x_num;
    int y_num;
}
@end

@implementation ProductListViewController
@synthesize titleName,category;

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


#pragma mark -界面处理
- (void)initSelf
{
    [super initSelf];
    self.navigationItem.title = self.titleName;
//    categoryImageView.image = [UIImage imageNamed:self.category];   //产品类型图
    ProductTypeDB *tempDB = [ProductTypeDAO findByTypeName:self.category];
    if (tempDB && tempDB.typeName) {
        categoryImageView.image = [UIImage imageWithData:[FileHelper readFileFromDefaultFilePathWithFileName:tempDB.resource.name]];
    }
    [self loadDefaultData];
}

#pragma mark - 数据处理
- (void)loadDefaultData
{
    [self addProductListToControllorWithOriginY:442.f];
}

- (void)addProductListToControllorWithOriginY:(float)originY
{
    //46 ,60
    x_num = 5;
    y_num = 6;
    NSArray *staticProductAry = [ProductsDAO findAll]; //1，先从数据库中查出所有的产品
    if (staticProductAry == nil || staticProductAry.count == 0) {
        return;
    }
    
    productAry = [@[] mutableCopy];
    [staticProductAry enumerateObjectsUsingBlock:^(ProductsDB *obj, NSUInteger idx, BOOL *stop) {
        Products *tempModel = [obj toModel];
        if ([tempModel.typeModel.typeName isEqualToString:self.category]) {
            [productAry addObject:tempModel]; //找出同一类目的数据
        }
    }];
    
    for (int Y=0; Y<y_num; Y++) {
        for (int X=0; X<x_num; X++) {
            if ((X+Y*x_num)<[productAry count]) {
                Products *myProduct = [productAry objectAtIndex:X+Y*x_num];
                UIButton *tempbtn = [UIButton buttonWithType:UIButtonTypeCustom];
                tempbtn.frame = CGRectMake(90+(160+10)*X, originY+(45+10)*Y, 160, 45);
                tempbtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
                tempbtn.tag = [myProduct.modelId intValue];
                tempbtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 14, 0);
                [tempbtn setBackgroundImage:[UIImage imageNamed:@"BgButton"] forState:UIControlStateNormal];
                [tempbtn setTitle:myProduct.name forState:UIControlStateNormal];
                [tempbtn addTarget:self action:@selector(productButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:tempbtn];
            }
        }
    }
}


#pragma mark - push to next view
- (void)productButtonClick:(id)sender
{
    [self performSegueWithIdentifier:@"productDetail" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *segueCtrl = segue.destinationViewController;
    UIButton *sendBtn = (UIButton *)sender;
    [segueCtrl setValue:sendBtn.titleLabel.text forKey:@"productName"];
    [segueCtrl setValue:[NSString stringWithFormat:@"%d",sendBtn.tag] forKeyPath:@"productIdentify"];
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
