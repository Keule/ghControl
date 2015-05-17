//
//  UIView+CustomTimingFunction.h
//  Instants
//
//  Created by Christian Giordano on 16/10/2013.
//  Copyright (c) 2013 Christian Giordano. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	CustomTimingFunctionDefault,
	CustomTimingFunctionLinear,
	CustomTimingFunctionEaseIn,
	CustomTimingFunctionEaseOut,
	CustomTimingFunctionEaseInOut,
	CustomTimingFunctionSineIn,
	CustomTimingFunctionSineOut,
	CustomTimingFunctionSineInOut,
	CustomTimingFunctionQuadIn,
	CustomTimingFunctionQuadOut,
	CustomTimingFunctionQuadInOut,
	CustomTimingFunctionCubicIn,
	CustomTimingFunctionCubicOut,
	CustomTimingFunctionCubicInOut,
	CustomTimingFunctionQuartIn,
	CustomTimingFunctionQuartOut,
	CustomTimingFunctionQuartInOut,
	CustomTimingFunctionQuintIn,
	CustomTimingFunctionQuintOut,
	CustomTimingFunctionQuintInOut,
	CustomTimingFunctionExpoIn,
	CustomTimingFunctionExpoOut,
	CustomTimingFunctionExpoInOut,
	CustomTimingFunctionCircIn,
	CustomTimingFunctionCircOut,
	CustomTimingFunctionCircInOut,
	CustomTimingFunctionBackIn,
	CustomTimingFunctionBackOut,
	CustomTimingFunctionBackInOut
} CustomTimingFunction;

@interface UIView (CustomTimingFunction)

+(void)animateWithDuration:(NSTimeInterval)duration customTimingFunction:(CustomTimingFunction)customTimingFunction animation:(void (^)(void))animation competion:(void (^)(void))competion;

-(void)animateProperty:(NSString*)property from:(id)from to:(id)to withDuration:(NSTimeInterval)duration delay:(float)delay customTimingFunction:(CustomTimingFunction)customTimingFunction competion:(void (^)(void))competion;
-(void)animateRectFrom:(CGRect)from to:(CGRect)to withDuration:(NSTimeInterval)duration delay:(float)delay customTimingFunction:(CustomTimingFunction)customTimingFunction competion:(void (^)(void))competion;

-(void)printFrameView;
-(void)printFrameLayer;
@end
