//
//  FMDateHelper.h
//  winzerApp
//
//  Created by Thomas Wolters on 6/25/13.
//  Updated by Thomas Wolters on 11/25/2014
//  Copyright (c) 2013 fluidmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDateHelper : NSObject

//sample format String: @"dd.MM.YYYY HH:mm"
+ (NSString *)dateToString:(NSDate *)date formatString:(NSString *)formatString;

+ (NSDate *)stringToDate:(NSString *)dateString formatString:(NSString *)formatString;

+(NSDate *)dateWithOutTime:(NSDate *)datDate;

+(NSPredicate*)predicateForDate:(NSDate*)date attributeName:(NSString*)attributeName;

@end
