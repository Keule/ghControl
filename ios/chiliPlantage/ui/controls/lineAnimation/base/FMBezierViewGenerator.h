//
//  FMBezierViewGenerator.h
//  XXX_PROJECTNAME_XXX
//
//  Created by Thomas Wolters on 13/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMBezierAnimationView.h"

@interface FMBezierViewGenerator : NSObject
+(FMBezierAnimationView*)viewForSizeTarget:(CGSize)sizeTarget strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor bezierPathes:(NSArray*)bezierPathes sizeOriginal:(CGSize)sizeOriginal state:(FMBezierSingleAnimationViewState)state;
@end
