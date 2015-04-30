//
//  LKImageView.m
//  NewLonking
//
//  Created by 李健 on 14-9-1.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "LKImageView.h"
#import "CommonHelper.h"
#import "ImageShowViewController.h"

@implementation LKImageView
@synthesize superViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)tap:(UIGestureRecognizer *)gesture
{
    ImageShowViewController *tempViewController = [[ImageShowViewController alloc] initWithNibName:@"ImageShowViewController" bundle:nil];
    tempViewController.bigImage = self.image;
    [self.superViewController.navigationController pushViewController:tempViewController animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
