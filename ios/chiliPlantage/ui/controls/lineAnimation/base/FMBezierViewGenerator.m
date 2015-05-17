//
//  FMBezierViewGenerator.m
//  XXX_PROJECTNAME_XXX
//
//  Created by Thomas Wolters on 13/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "FMBezierViewGenerator.h"

@implementation FMBezierViewGenerator

+(FMBezierAnimationView*)viewForSizeTarget:(CGSize)sizeTarget strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor bezierPathes:(NSArray*)bezierPathes sizeOriginal:(CGSize)sizeOriginal state:(FMBezierSingleAnimationViewState)state{
    FMBezierAnimationView* view = [[FMBezierAnimationView alloc] initWithSizeTarget:sizeTarget strokeColor:strokeColor fillColor:fillColor bezierPathes:bezierPathes sizeOriginal:sizeOriginal];
    [view setState:state animated:NO duration:0 startIn:0];
    return view;
}

@end
