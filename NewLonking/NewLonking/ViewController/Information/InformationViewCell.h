//
//  InformationViewCell.h
//  NewLonking
//
//  Created by 李健 on 14-8-30.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#define VERIFY_LOGIN_NOT_LOGIN @"doesn't verify login!"
#define LOGIN_STATUS_CHANGED @"login status has changed"

#import <UIKit/UIKit.h>
@class LearningMaterials;
#import "SGdownloader.h"

@interface InformationViewCell : UITableViewCell<SGdownloaderDelegate>
@property (nonatomic, strong) UIViewController *superController;
@property (nonatomic, strong) NSString *identify;

+ (InformationViewCell *)loadFromNib;

- (void)initWithLearningMaterials:(LearningMaterials *)model currentPageName:(NSString *)aName;

- (void)resetButtonOutlook;
@end
