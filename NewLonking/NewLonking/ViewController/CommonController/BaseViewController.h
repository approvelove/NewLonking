//
//  BaseViewController.h
//  NewLonking
//
//  Created by 李健 on 14-8-4.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *	@brief	初始化界面
 *
 *	@return	nil
 */
- (void)initSelf;

- (void)showAlertWithTitle:(NSString *)title;
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)msg;
//- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)msg andButtonTitle:(NSString *)buttonTitle;

- (NSArray *)doResponseWithDictionary:(NSDictionary *)aDictionary;

- (void)startLoading:(NSString *)labelText;
- (void)startLoading;
- (void)stopLoading;
@end
