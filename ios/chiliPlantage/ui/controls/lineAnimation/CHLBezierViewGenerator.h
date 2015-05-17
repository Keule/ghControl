//
//  Pr0BezierViewGenerator.h
// KellerClient
//
//  Created by Thomas Wolters on 03/04/15.
//  Copyright (c) 2015 Thomas Wolters. All rights reserved.
//

#import "FMBezierViewGenerator.h"

#import "FMBezierAnimationView.h"

@interface CHLBezierViewGenerator : FMBezierViewGenerator

+(FMBezierAnimationView*)animationViewTemplateForTargetSize:(CGSize)sizeTarget strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor state:(FMBezierSingleAnimationViewState)state;

@end
