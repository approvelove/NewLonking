//
//  GraphicHelper.m
//  onestong
//
//  Created by 王亮 on 14-4-22.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "GraphicHelper.h"

@implementation GraphicHelper
    
+(void)convertRectangleToCircular:(UIView *)view
{
    view.layer.cornerRadius = view.frame.size.width / 2;
}

+(void)convertRectangleToCircular:(UIView *)view withBorderColor:(UIColor *)color andBorderWidth:(float)width
{
    [GraphicHelper convertRectangleToCircular:view];
    view.layer.borderColor = [color CGColor];
    view.layer.borderWidth = width;
}

+(void)convertRectangleToEllipses:(UIView *)view withBorderColor:(UIColor *)color andBorderWidth:(float)width andRadius:(float)radius
{
    view.layer.cornerRadius = radius;
    view.layer.borderColor = [color CGColor];
    view.layer.borderWidth = width;
}

+ (UIImage *)convertColorToImage:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = CWSizeReduce(image.size, length);
    UIImage *img = nil;
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, scale);  // 创建一个 bitmap context
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];              // 将图片绘制到当前的 context 上
    img = UIGraphicsGetImageFromCurrentImageContext();            // 从当前 context 中获取刚绘制的图片
    UIGraphicsEndImageContext();
    
    return img;
}

static inline CGSize CWSizeReduce(CGSize size, CGFloat limit)   // 按比例减少尺寸
{
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }

    CGSize imgSize;
    CGFloat ratio = size.height / size.width;

    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    }
    else
    {
        imgSize = CGSizeMake(limit/ratio, limit);
    }

    return imgSize;
}
@end
