//
//  LKImageView.h
//  NewLonking
//
//  Created by 李健 on 14-9-1.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKImageView : UIImageView

@property (nonatomic, strong) UIViewController *superViewController;
/**
 *	@brief	给图片添加点击手势
 *
 *	@return	nil
 */
- (void)addTapGesture;

@end
