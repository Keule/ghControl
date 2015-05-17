//
//  PR0BezierAnimationView.m
// KellerClient
//
//  Created by Thomas Wolters on 03/04/15.
//  Copyright (c) 2015 Thomas Wolters. All rights reserved.
//

#import "FMBezierAnimationView.h"

@interface FMBezierAnimationView()
@property (nonatomic, assign) CGSize size;
@end

@implementation FMBezierAnimationView

-(id)initWithSizeTarget:(CGSize)sizeTarget strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor bezierPathes:(NSArray*)bezierPathes sizeOriginal:(CGSize)sizeOriginal{
    _size = sizeOriginal;
    self = [super initWithBezierPathes:bezierPathes targetSize:sizeTarget strokeColor:strokeColor fillColor:fillColor lineWidth:ICON_LINE_WIDTH];
    if (self) {
        //CLEAN -> STANDARD
        {
            NSArray* color = @[(id)strokeColor.CGColor,  (id)strokeColor.CGColor];
            NSArray* times = @[@0, @1];
            NSArray* valuesEnd = @[@0, @1];
            NSArray* valuesStart = @[@0, @0];
            for (int i = 0; i <bezierPathes.count;i++){
                [self setAnimationForState:FMBezierSingleAnimationViewStateStandard fromState:FMBezierSingleAnimationViewStateClean timing:times keyPathValues:@{@"strokeColor":color, @"strokeEnd":valuesEnd, @"strokeStart":valuesStart} forBezierID:i];
            }
        }
        self.frame = (CGRect){0,0,sizeTarget};
    }
    return self;
}

-(CGSize)dimension {
    return _size;
}

@end
