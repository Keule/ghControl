//
//  FMBezierSingleAnimationView.m
//  herbalife
//
//  Created by Thomas Wolters on 27/08/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMBezierAnimationBaseView.h"
#import <QuartzCore/QuartzCore.h>
#import "CAMediaTimingFunction+AdditionalEquations.h"




#define KEY_ANIMATION_KEYPATH_VALUES @"KEY_ANIMATION_KEYPATH_VALUES"
#define KEY_ANIMATION_TIMINGS @"KEY_ANIMATION_TIMINGS"
@interface FMBezierAnimationBaseView ()
@property (nonatomic, strong) NSMutableDictionary* animations;

@property (nonatomic, strong) NSArray* shapeLayers;
@property (nonatomic, assign) CGSize targetSize;

@end

@implementation FMBezierAnimationBaseView

-(instancetype)initWithBezierPathes:(NSArray*)bezierPathes targetSize:(CGSize)targetSize strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor lineWidth:(float)lineWidth withColorGradient:(NSArray*)colors image:(UIImage*)image{
    self = [super init];
    if (!self) {
        return nil;
    }
    _targetSize = targetSize;
    _animations = [@{} mutableCopy];
    _state = FMBezierSingleAnimationViewStateClean;
    
    NSMutableArray* layers = [@[] mutableCopy];
    int currentImageNumber = 0;
    for (UIBezierPath* bezierPath in bezierPathes) {
        currentImageNumber++;
        CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.strokeColor = strokeColor.CGColor;
        shapeLayer.fillColor = fillColor.CGColor;
        shapeLayer.strokeEnd = .0f;
        shapeLayer.lineWidth = lineWidth;
        shapeLayer.backgroundColor = [UIColor yellowColor].CGColor;
        [shapeLayer setPath:[self scalePath:bezierPath toSize:_targetSize fromSize:[self dimension]].CGPath];
        [shapeLayer setPath:bezierPath.CGPath];
        [layers addObject:shapeLayer];
        
        if (colors) {
            
            CAGradientLayer* gradientLayer = [CAGradientLayer layer];
            gradientLayer.frame = (CGRect) {0, 0, _targetSize.width, _targetSize.height};
            
            NSMutableArray* colorCGs = [@[] mutableCopy];
            for (UIColor* color in colors) {
                [colorCGs addObject:(__bridge id)color.CGColor];
            }
            gradientLayer.colors = colorCGs;
            gradientLayer.startPoint = CGPointMake(0, 0.5);
            gradientLayer.endPoint = CGPointMake(1, 0.5);
            
            
            //Using arc as a mask instead of adding it as a sublayer.
            gradientLayer.mask = shapeLayer;
            [self.layer addSublayer:gradientLayer];
        }
        if (image&& bezierPathes.count==currentImageNumber){
            CALayer* layer = [[CALayer alloc] init];
            layer.frame = (CGRect) {0, 0, _targetSize.width, _targetSize.height};
            layer.contents = (id)image.CGImage;
            layer.mask = shapeLayer;
            [self.layer addSublayer:layer];
        }
        else {
            [[self layer] addSublayer:shapeLayer];
        }
    }
    _shapeLayers = layers;
    
    return self;
}

-(instancetype)initWithBezierPathes:(NSArray*)bezierPathes targetSize:(CGSize)targetSize strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor lineWidth:(float)lineWidth withColorGradient:(NSArray*)colors{
    return [self initWithBezierPathes:bezierPathes targetSize:targetSize strokeColor:strokeColor fillColor:fillColor lineWidth:lineWidth withColorGradient:colors image:nil];
}

-(instancetype)initWithBezierPathes:(NSArray*)bezierPathes targetSize:(CGSize)targetSize strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor lineWidth:(float)lineWidth image:(UIImage*)image{
    return [self initWithBezierPathes:bezierPathes targetSize:targetSize strokeColor:strokeColor fillColor:fillColor lineWidth:lineWidth withColorGradient:nil image:image];
}

-(instancetype)initWithBezierPathes:(NSArray*)bezierPathes targetSize:(CGSize)targetSize strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor lineWidth:(float)lineWidth {
    return [self initWithBezierPathes:bezierPathes targetSize:targetSize strokeColor:strokeColor fillColor:fillColor lineWidth:lineWidth withColorGradient:nil];
}

-(void)setAnimationForState:(enum FMBezierSingleAnimationViewState)state fromState:(enum FMBezierSingleAnimationViewState)fromState timing:(NSArray*)timings keyPathValues:(NSDictionary*)keyPathValues forBezierID:(int)bezierID {
    NSDictionary* dict = @{KEY_ANIMATION_KEYPATH_VALUES:keyPathValues, KEY_ANIMATION_TIMINGS:timings};
    NSString* keyToState = [NSString stringWithFormat:@"%li", (unsigned long)state];
    NSMutableDictionary* animationForToStateDict = [_animations valueForKey:keyToState];
    if (!animationForToStateDict) {
        animationForToStateDict = [@{} mutableCopy];
        [_animations setValue:animationForToStateDict forKeyPath:keyToState];
    }
    NSString* keyFromState = [NSString stringWithFormat:@"%li", (unsigned long)fromState];
    NSMutableDictionary* animationFromToStateDict = [animationForToStateDict valueForKey:keyFromState];
    
    if (!animationFromToStateDict) {
        animationFromToStateDict = [@{} mutableCopy];
        [animationForToStateDict setValue:animationFromToStateDict forKeyPath:keyFromState];
    }
    [animationFromToStateDict setValue:dict forKeyPath:[NSString stringWithFormat:@"%i", bezierID]];
}

-(void) setState:(enum FMBezierSingleAnimationViewState)state animated:(BOOL) LINT_SUPPRESS_UNUSED_ATTRIBUTE animated duration:(float)duration startIn:(float)startIn {
    NSDictionary* allBezierLayerAnimations = [[_animations valueForKey:[NSString stringWithFormat:@"%li", (unsigned long)state]] valueForKey:[NSString stringWithFormat:@"%li",(unsigned long) _state]];
    
    
    [CATransaction begin];
    {
        //duration == 0 => no animation
        duration = MAX(duration, 0.001f);
        
        [CATransaction setAnimationDuration:duration + startIn];   //Dynamic Duration
        [CATransaction setCompletionBlock: ^{
        }];
        
        // These could come from an array or whatever, this is just easy...
        //            _shapeLayer.strokeStart = 0;
        //            _shapeLayer.strokeEnd = 1;
        
        for (NSString* bezierID in allBezierLayerAnimations.allKeys) {
            NSArray* timings = [[allBezierLayerAnimations valueForKey:bezierID] valueForKey:KEY_ANIMATION_TIMINGS];
            
            if (startIn > 0) {
                NSMutableArray* newTimings = [@[] mutableCopy];
                for (NSNumber* time in timings) {
                    float newTime = (duration * time.floatValue + startIn) / (startIn + duration);
                    [newTimings addObject:@(newTime)];
                }
                timings = newTimings;
            }
            
            NSDictionary* animationKeyPassValue = [[allBezierLayerAnimations valueForKey:bezierID] valueForKey:KEY_ANIMATION_KEYPATH_VALUES];
            int i = 0;
            
            for (NSString* keyPath in animationKeyPassValue.allKeys) {
                CAShapeLayer* shapeLayer = _shapeLayers [bezierID.intValue];
                CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
                
                animation.keyTimes = timings;
                if ([keyPath isEqualToString:@"path"]){
                    NSMutableArray* pathes = [@[] mutableCopy];
                    NSArray* bezierPathes = [animationKeyPassValue valueForKey:keyPath];
                    int i = 0;
                    for (UIBezierPath* path in bezierPathes){
                        if (i==0){
                            [pathes addObject:(id)shapeLayer.path];
                        }
                        else{
                            [pathes addObject:(id)[self scalePath:path toSize:_targetSize fromSize:[self dimension]].CGPath];
                        }
                        i++;
                        
                    }
                    animation.values = pathes;
                }
                else{
                    animation.values = [animationKeyPassValue valueForKey:keyPath];
                }
                
                
                NSMutableArray* timingFunctions = [@[] mutableCopy];
                if (timings.count == 2) {
                    [timingFunctions addObject:[CAMediaTimingFunction easeInOutCubic]];
                }
                else {
                    for (int j = 1; j < timingFunctions.count; j++) {
                        if (j == 1) {
                            [timingFunctions addObject:[CAMediaTimingFunction easeInCubic]];
                        }
                        else if (j == timingFunctions.count - 1) {
                            [timingFunctions addObject:[CAMediaTimingFunction easeOutCubic]];
                        }
                        else {
                            [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
                        }
                    }
                }
                
                animation.timingFunctions = timingFunctions;
                animation.removedOnCompletion = NO;
                animation.fillMode = kCAFillModeForwards;
                [shapeLayer addAnimation:animation forKey:[NSString stringWithFormat:@"whatever%i", i]];
                i++;
            }
            if (state == FMBezierSingleAnimationViewStateStandard) {
                [self tempMorph];
            }
        }
    }
    [CATransaction commit];
    self.state = state;
}

-(id)initWithXFrame:(CGRect) LINT_SUPPRESS_UNUSED_ATTRIBUTE frame strokeColor:(UIColor*) LINT_SUPPRESS_UNUSED_ATTRIBUTE strokeColor fillColor:(UIColor*) LINT_SUPPRESS_UNUSED_ATTRIBUTE fillColor {
    assert(@"ERROR DO NOT CALL ON THIS CLASS!!!");
    return nil;
}

-(CGSize)dimension {
    assert(@"NEVER CALL THIS!!");
    return CGSizeZero;
}

-(UIBezierPath*)scalePath:(UIBezierPath*)bezierPath toSize:(CGSize)toSize fromSize:(CGSize)fromSize {
    float scale = MIN(toSize.width / fromSize.width, toSize.height / fromSize.height);
    [bezierPath applyTransform:CGAffineTransformMakeScale(scale, scale)];
    return bezierPath;
}

-(void)tempMorph {
    //	CABasicAnimation* morph = [CABasicAnimation animationWithKeyPath:@"path"];
    //	morph.duration = 5;
    //	UIBezierPath* bezierPathProspect = UIBezierPath.bezierPath;
    //	[bezierPathProspect moveToPoint:CGPointMake(47.3, 43.3)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(34.9, 37.3) controlPoint1:CGPointMake(46.6, 42.3) controlPoint2:CGPointMake(43.9, 39.5)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(34.7, 34) controlPoint1:CGPointMake(34.9, 35.2) controlPoint2:CGPointMake(34.7, 34)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(37.6, 25.2) controlPoint1:CGPointMake(34.7, 34) controlPoint2:CGPointMake(37.4, 30.3)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(31, 18.3) controlPoint1:CGPointMake(37.6, 24.4) controlPoint2:CGPointMake(38, 18.6)];
    //	[bezierPathProspect addLineToPoint:CGPointMake(31, 18.3)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(30.9, 18.3) controlPoint1:CGPointMake(31, 18.3) controlPoint2:CGPointMake(31, 18.3)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(30.8, 18.3) controlPoint1:CGPointMake(30.9, 18.3) controlPoint2:CGPointMake(30.9, 18.3)];
    //	[bezierPathProspect addLineToPoint:CGPointMake(30.8, 18.3)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(24.2, 25.2) controlPoint1:CGPointMake(23.8, 18.6) controlPoint2:CGPointMake(24.2, 24.3)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(27.1, 34) controlPoint1:CGPointMake(24.4, 30.3) controlPoint2:CGPointMake(27.1, 34)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(27, 37.3) controlPoint1:CGPointMake(27.1, 34) controlPoint2:CGPointMake(27, 35.3)];
    //	[bezierPathProspect addCurveToPoint:CGPointMake(14.6, 43.2) controlPoint1:CGPointMake(18.2, 39.4) controlPoint2:CGPointMake(15.4, 42.2)];
    //	morph.toValue = bezierPathProspect;
    //	[_shapeLayers.firstObject addAnimation:morph forKey:nil];
}

@end
