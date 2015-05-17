//
//  PR0BezierAnimationView.h
// KellerClient
//
//  Created by Thomas Wolters on 03/04/15.
//  Copyright (c) 2015 Thomas Wolters. All rights reserved.
//

#import "FMBezierAnimationBaseView.h"

@interface FMBezierAnimationView : FMBezierAnimationBaseView
-(id)initWithSizeTarget:(CGSize)sizeTarget strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor bezierPathes:(NSArray*)bezierPathes sizeOriginal:(CGSize)sizeOriginal;
@end
