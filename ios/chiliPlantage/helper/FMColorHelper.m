//
//  FMColorHelper.m
//  XXX_PROJECTNAME_XXX
//
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "FMColorHelper.h"

@implementation FMColorHelper
+ (UIColor*)disco {
    CGFloat hue = arc4random() % 256 / 256.0;    //  0.0 to 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
