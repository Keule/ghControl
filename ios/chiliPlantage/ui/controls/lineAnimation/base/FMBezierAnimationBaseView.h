//
//  FMBezierSingleAnimationView.h
//  herbalife
//
//  Created by Thomas Wolters on 27/08/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMBezierAnimationBaseView : UIView
@property (nonatomic, assign) enum FMBezierSingleAnimationViewState state;
-(instancetype)initWithBezierPathes:(NSArray*)bezierPathes targetSize:(CGSize)targetSize strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor lineWidth:(float)lineWidth image:(UIImage*)image;
-(instancetype)initWithBezierPathes:(NSArray*)bezierPathes targetSize:(CGSize)targetSize strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor lineWidth:(float)lineWidth;
-(instancetype)initWithBezierPathes:(NSArray*)bezierPathes targetSize:(CGSize)targetSize strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor lineWidth:(float)lineWidth withColorGradient:(NSArray*)colors;

-(void)setAnimationForState:(enum FMBezierSingleAnimationViewState)state fromState:(enum FMBezierSingleAnimationViewState)fromState timing:(NSArray*)timings keyPathValues:(NSDictionary*)keyPathValues forBezierID:(int)bezierID;

-(void)setState:(enum FMBezierSingleAnimationViewState)state animated:(BOOL)animated duration:(float)duration startIn:(float)startIn;


//DO NOT IMPLEMENT IN THIS ELEMENT
-(id)initWithXFrame:(CGRect)frame strokeColor:(UIColor*)strokeColor fillColor:(UIColor*)fillColor;

//overwrite, otherwise error!!
-(CGSize)dimension;
@end
