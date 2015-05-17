//
//  Pr0BezierViewGenerator.m
// KellerClient
//
//  Created by Thomas Wolters on 03/04/15.
//  Copyright (c) 2015 Thomas Wolters. All rights reserved.
//

#import "CHLBezierViewGenerator.h"
#import "FMBezierAnimationView.h"

@implementation CHLBezierViewGenerator

+(FMBezierAnimationView*) LINT_SUPPRESS_NON_COMMENTED_LINES animationViewTemplateForTargetSize:(CGSize)sizeTarget strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor state:(FMBezierSingleAnimationViewState)state{
    
    UIBezierPath* bezier114Path = UIBezierPath.bezierPath;
    [bezier114Path moveToPoint: CGPointMake(22.3, 24.1)];
    [bezier114Path addCurveToPoint: CGPointMake(26.9, 19.5) controlPoint1: CGPointMake(23.7, 24.1) controlPoint2: CGPointMake(26.9, 22.3)];
    [bezier114Path addCurveToPoint: CGPointMake(26.9, 16.8) controlPoint1: CGPointMake(28.3, 19.5) controlPoint2: CGPointMake(28.3, 16.8)];
    [bezier114Path addLineToPoint: CGPointMake(26.4, 14.5)];
    [bezier114Path addCurveToPoint: CGPointMake(22.3, 12.7) controlPoint1: CGPointMake(22.7, 14.5) controlPoint2: CGPointMake(22.7, 13.1)];
    [bezier114Path addCurveToPoint: CGPointMake(18.2, 14.5) controlPoint1: CGPointMake(21.8, 13.2) controlPoint2: CGPointMake(21.8, 14.5)];
    [bezier114Path addLineToPoint: CGPointMake(17.7, 16.8)];
    [bezier114Path addCurveToPoint: CGPointMake(17.7, 19.5) controlPoint1: CGPointMake(16.3, 16.8) controlPoint2: CGPointMake(16.3, 19.5)];
    [bezier114Path addCurveToPoint: CGPointMake(22.3, 24.1) controlPoint1: CGPointMake(17.7, 22.3) controlPoint2: CGPointMake(20.9, 24.1)];
    [bezier114Path closePath];
    bezier114Path.lineCapStyle = kCGLineCapRound;
    bezier114Path.lineJoinStyle = kCGLineJoinRound;
    
    UIBezierPath* bezier116Path = UIBezierPath.bezierPath;
    [bezier116Path moveToPoint: CGPointMake(27.8, 17.3)];
    [bezier116Path addLineToPoint: CGPointMake(28.3, 14.1)];
    [bezier116Path addCurveToPoint: CGPointMake(22.4, 9.5) controlPoint1: CGPointMake(28.3, 14.1) controlPoint2: CGPointMake(28.8, 9.5)];
    [bezier116Path addCurveToPoint: CGPointMake(16.5, 14.1) controlPoint1: CGPointMake(16, 9.5) controlPoint2: CGPointMake(16.5, 14.1)];
    [bezier116Path addLineToPoint: CGPointMake(17, 17.3)];
    bezier116Path.lineCapStyle = kCGLineCapRound;
    
    UIBezierPath* bezier118Path = UIBezierPath.bezierPath;
    [bezier118Path moveToPoint: CGPointMake(19.8, 23.1)];
    [bezier118Path addLineToPoint: CGPointMake(14.2, 24.8)];
    [bezier118Path addCurveToPoint: CGPointMake(11.8, 28.2) controlPoint1: CGPointMake(12.8, 25.3) controlPoint2: CGPointMake(11.8, 26.7)];
    [bezier118Path addLineToPoint: CGPointMake(11.8, 30.5)];
    [bezier118Path addLineToPoint: CGPointMake(32.8, 30.5)];
    [bezier118Path addLineToPoint: CGPointMake(32.8, 28.2)];
    [bezier118Path addCurveToPoint: CGPointMake(30.4, 24.8) controlPoint1: CGPointMake(32.8, 26.7) controlPoint2: CGPointMake(31.9, 25.3)];
    [bezier118Path addLineToPoint: CGPointMake(24.8, 23.1)];
    bezier118Path.lineCapStyle = kCGLineCapRound;
    
    UIBezierPath* bezier120Path = UIBezierPath.bezierPath;
    [bezier120Path moveToPoint: CGPointMake(19.6, 17.7)];
    [bezier120Path addCurveToPoint: CGPointMake(20.5, 17.2) controlPoint1: CGPointMake(19.6, 17.2) controlPoint2: CGPointMake(20, 17.2)];
    [bezier120Path addCurveToPoint: CGPointMake(21.4, 17.7) controlPoint1: CGPointMake(21, 17.2) controlPoint2: CGPointMake(21.4, 17.2)];
    bezier120Path.lineCapStyle = kCGLineCapRound;
    
    UIBezierPath* bezier122Path = UIBezierPath.bezierPath;
    [bezier122Path moveToPoint: CGPointMake(23.2, 17.7)];
    [bezier122Path addCurveToPoint: CGPointMake(24.1, 17.2) controlPoint1: CGPointMake(23.2, 17.2) controlPoint2: CGPointMake(23.6, 17.2)];
    [bezier122Path addCurveToPoint: CGPointMake(25, 17.7) controlPoint1: CGPointMake(24.6, 17.2) controlPoint2: CGPointMake(25, 17.2)];
    bezier122Path.lineCapStyle = kCGLineCapRound;
    
    UIBezierPath* oval14Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.3, 0, 44, 44)];
    
    NSArray* bezierPathes =@[bezier114Path,bezier116Path,bezier118Path,bezier120Path,bezier122Path,oval14Path];
    CGSize sizeOriginal = (CGSize){44,44};
    
    return [FMBezierViewGenerator viewForSizeTarget:sizeTarget strokeColor:strokeColor fillColor:fillColor bezierPathes:bezierPathes sizeOriginal:sizeOriginal state:state];
}

@end
