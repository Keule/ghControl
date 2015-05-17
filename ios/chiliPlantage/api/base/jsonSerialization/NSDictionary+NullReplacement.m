//
//  NSDictionary+NullReplacement.m
//  Algel
//
//  Created by Thomas Wolters on 20/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"


@implementation NSDictionary (NullReplacement)

- (NSDictionary *)dictionaryByDeletingNullsWithBlanks {
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
//    const NSString *blank = @"";

    for (NSString *key in self) {
        id object = self [key];
   //     if (object == nul) [replaced setObject:blank forKey:key];
        if (object == nul) [replaced removeObjectForKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setObject:[object dictionaryByDeletingNullsWithBlanks] forKey:key];
        else if ([object isKindOfClass:[NSArray class]]) [replaced setObject:[object arrayByDeletingNullsWithBlanks] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

@end
