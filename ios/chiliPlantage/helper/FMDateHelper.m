//
//  FMDateHelper.m
//  winzerApp
//
//  Created by Thomas Wolters on 6/25/13.
//  Copyright (c) 2013 fluidmobile. All rights reserved.
//
#import "FMDateHelper.h"

@implementation FMDateHelper
+ (NSString *)dateToString:(NSDate *)date formatString:(NSString *)formatString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    return [dateFormat stringFromDate:date];
}

//http://stackoverflow.com/questions/6456626/what-format-string-do-i-use-for-milliseconds-in-date-strings-on-iphone
//http://www.unicode.org/reports/tr35/tr35-25.html
+ (NSDate *)stringToDate:(NSString *)dateString formatString:(NSString *)formatString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSDate *date = [dateFormat dateFromString:dateString];
    return date;
}

+(NSDate *)dateWithOutTime:(NSDate *)datDate {
    NSDate* date = datDate;
    if( date == nil ) {
        date = [NSDate date];
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+(NSPredicate*)predicateForDate:(NSDate*)date attributeName:(NSString*)attributeName{
    NSDate *startDate = [FMDateHelper dateWithOutTime:date];

    NSDateComponents *oneDay = [NSDateComponents new];
    oneDay.day = 1;

    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:oneDay toDate:date options:0];
    NSString* formatString = [NSString stringWithFormat:@"(%@ >= %@) AND (%@ < %@)",attributeName,@"%@", attributeName, @"%@" ];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:formatString, startDate, endDate];
    
    return predicate;
}

@end
