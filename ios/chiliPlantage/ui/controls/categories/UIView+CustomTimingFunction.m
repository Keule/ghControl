//
//  UIView+CustomTimingFunction.m
//  Instants
//
//  Created by Christian Giordano on 16/10/2013.
//  Copyright (c) 2013 Christian Giordano. All rights reserved.
//

#import "UIView+CustomTimingFunction.h"

@implementation UIView (CustomTimingFunction)

-(void)animateRectFrom:(CGRect)from to:(CGRect)to withDuration:(NSTimeInterval)duration delay:(float)delay customTimingFunction:(CustomTimingFunction)customTimingFunction competion:(void (^)(void))competion {
	[self animateProperty:@"frame" from:[NSValue valueWithCGRect:from] to:[NSValue valueWithCGRect:to] withDuration:duration delay:delay customTimingFunction:customTimingFunction competion: ^{self.frame = to; self.layer.frame = to; [competion invoke]; }];
}

+(void)animateWithDuration:(NSTimeInterval)duration customTimingFunction:(CustomTimingFunction)customTimingFunction animation:(void (^)(void))animation competion:(void (^)(void))competion {
	[UIView beginAnimations:nil context:NULL];
	[CATransaction begin];
	[CATransaction setAnimationDuration:duration];
	[CATransaction setAnimationTimingFunction:[self functionWithType:customTimingFunction]];
	[CATransaction setCompletionBlock:competion];

	animation();

	[CATransaction commit];
	[UIView commitAnimations];
}

-(void)animateProperty:(NSString*)property from:(id)from to:(id)to withDuration:(NSTimeInterval)duration
                 delay:(float)delay customTimingFunction:(CustomTimingFunction)customTimingFunction competion:(void (^)(void))competion {
	[CATransaction begin]; {
		[CATransaction setCompletionBlock:competion];

		if ([property isEqualToString:@"frame"]) {
			[self layoutLayer:self.layer from:[from CGRectValue] to:[to CGRectValue] duration:duration delay:delay customTimingFunction:customTimingFunction isSublayer:NO];
		}
		else {
			CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:property];
			animation.duration = duration;
			animation.timingFunction = [[self class] functionWithType:customTimingFunction];
			animation.fillMode = kCAFillModeForwards;
			animation.removedOnCompletion = NO;
			animation.fromValue = from;
			animation.toValue = to;
			animation.beginTime = CACurrentMediaTime() + delay;
			[self.layer addAnimation:animation forKey:animation.keyPath];
		}
	}[CATransaction commit];
}

-(void) layoutLayer:(CALayer*)layer from:(CGRect)from to:(CGRect)to duration:(NSTimeInterval)duration delay:(float)delay customTimingFunction:(CustomTimingFunction)customTimingFunction isSublayer:(BOOL) LINT_SUPPRESS_UNUSED_ATTRIBUTE isSublayer{

    CGPoint fromPosition = CGPointMake(CGRectGetMidX(from), CGRectGetMidY(from));
    CGPoint toPosition =CGPointMake(CGRectGetMidX(to), CGRectGetMidY(to));

    CABasicAnimation* positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.timingFunction = [[self class] functionWithType:customTimingFunction];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];

    CGRect fromRect = CGRectMake(0, 0, from.size.width, from.size.height);
    CGRect toRect = CGRectMake(0, 0, to.size.width, to.size.height);;
    
    CABasicAnimation* boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.timingFunction = [[self class] functionWithType:customTimingFunction];
    boundsAnimation.fromValue = [NSValue valueWithCGRect:fromRect];
    boundsAnimation.toValue = [NSValue valueWithCGRect:toRect];
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = @[positionAnimation, boundsAnimation];
    group.beginTime = CACurrentMediaTime() + delay;
    group.duration = duration;
    
    [layer addAnimation:group forKey:@"frame"];
}


+  (CAMediaTimingFunction*) LINT_SUPPRESS_CYCLOMATIC_COMPLEXITY LINT_SUPPRESS_NON_COMMENTED_LINES functionWithType:(CustomTimingFunction)type {
    //select media timing functions

    CAMediaTimingFunction* function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
	switch (type) {
		case CustomTimingFunctionDefault:
			function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            break;
		case CustomTimingFunctionLinear:
			function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
		case CustomTimingFunctionEaseIn:
			function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
		case CustomTimingFunctionEaseOut:
			function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
		case CustomTimingFunctionEaseInOut:
			function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;
		case CustomTimingFunctionSineIn:
			function = [CAMediaTimingFunction functionWithControlPoints:0.45:0:1:1];
            break;
		case CustomTimingFunctionSineOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0:0:0.55:1];
            break;
		case CustomTimingFunctionSineInOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.45:0:0.55:1];
            break;
		case CustomTimingFunctionQuadIn:
			function = [CAMediaTimingFunction functionWithControlPoints:0.43:0:0.82:0.60];
            break;
		case CustomTimingFunctionQuadOut:
            //QuadOut
			function = [CAMediaTimingFunction functionWithControlPoints:0.18:0.4:0.57:1];
            break;
		case CustomTimingFunctionQuadInOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.43:0:0.57:1];
            break;
		case CustomTimingFunctionCubicIn:
			function = [CAMediaTimingFunction functionWithControlPoints:0.67:0:0.84:0.54];
            break;
		case CustomTimingFunctionCubicOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.16:0.46:0.33:1];
            break;
		case CustomTimingFunctionCubicInOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.65:0:0.35:1];
            break;
		case CustomTimingFunctionQuartIn:
			function = [CAMediaTimingFunction functionWithControlPoints:0.81:0:0.77:0.34];
            break;
		case CustomTimingFunctionQuartOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.23:0.66:0.19:1];
            break;
		case CustomTimingFunctionQuartInOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.81:0:0.19:1];
            break;
		case CustomTimingFunctionQuintIn:
			function = [CAMediaTimingFunction functionWithControlPoints:0.89:0:0.81:0.27];
            break;
		case CustomTimingFunctionQuintOut:
            //QuintOut
			function = [CAMediaTimingFunction functionWithControlPoints:0.19:0.73:0.11:1];
            break;
		case CustomTimingFunctionQuintInOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.9:0:0.1:1];
            break;
		case CustomTimingFunctionExpoIn:
			function = [CAMediaTimingFunction functionWithControlPoints:1.04:0:0.88:0.49];
            break;
		case CustomTimingFunctionExpoOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.12:0.51:-0.4:1];
            break;
		case CustomTimingFunctionExpoInOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.95:0:0.05:1];
            break;
		case CustomTimingFunctionCircIn:
			function = [CAMediaTimingFunction functionWithControlPoints:0.6:0:1:0.45];
            break;
		case CustomTimingFunctionCircOut:
			function = [CAMediaTimingFunction functionWithControlPoints:1:0.55:0.4:1];
            break;
		case CustomTimingFunctionCircInOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.82:0:0.18:1];
            break;
		case CustomTimingFunctionBackIn:
			function = [CAMediaTimingFunction functionWithControlPoints:0.77:-0.63:1:1];
            break;
		case CustomTimingFunctionBackOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0:0:0.23:1.37];
            break;
		case CustomTimingFunctionBackInOut:
			function = [CAMediaTimingFunction functionWithControlPoints:0.77:-0.63:0.23:1.37];
            break;
	}

	NSLog(@"Couldn't find CustomTimingFunction, will return linear");
	return function;
}

-(void)printFrameView {
	NSLog(@"FRAME X: %1.1f Y: %1.1f height: %1.1f width: %1.1f", self.frame.origin.x, self.frame.origin.y, self.frame.size.height, self.frame.size.width);
}

-(void)printFrameLayer {
	NSLog(@"LAYER X: %1.1f Y: %1.1f height: %1.1f width: %1.1f", self.layer.frame.origin.x, self.layer.frame.origin.y, self.layer.frame.size.height, self.layer.frame.size.width);
}

@end
