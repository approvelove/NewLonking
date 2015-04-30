//
//  LKQLPreviewController.m
//  NewLonking
//
//  Created by 李健 on 14-9-8.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "LKQLPreviewController.h"

int count = 0;

@interface LKQLPreviewController()
{
    NSTimer *timer;
}
@end


@implementation LKQLPreviewController

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
   timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(hideRightItem) userInfo:Nil repeats:YES];
}

- (void)hideRightItem
{
    count += 0.01;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)cancelTimer
{
    if (count >10) {
        [timer invalidate];
    }
}
@end
