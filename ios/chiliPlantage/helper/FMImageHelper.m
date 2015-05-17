//
//  FMImageHelper.m
//  winzerApp
//
//  Created by Thomas Wolters on 6/28/13.
//  Copyright (c) 2013 fluidmobile. All rights reserved.
//

#import "FMImageHelper.h"

@implementation FMImageHelper

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
@end