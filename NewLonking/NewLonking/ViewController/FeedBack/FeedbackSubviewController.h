//
//  FeedbackSubviewController.h
//  Lonking
//
//  Created by 李健 on 14-2-26.
//  Copyright (c) 2014年 李健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackSubviewController : UITableViewController

@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *customerCountry;
@property (nonatomic, copy) NSString *customerEmail;

//加载表单数据
@end
