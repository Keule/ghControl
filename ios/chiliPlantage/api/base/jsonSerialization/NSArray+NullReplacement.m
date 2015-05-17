//
//  NSArray+NullReplacement.m
//  Algel
//
//  Created by Thomas Wolters on 20/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import "NSArray+NullReplacement.h"
#import "NSDictionary+NullReplacement.h"

@implementation NSArray (NullReplacement)

- (NSArray *)arrayByDeletingNullsWithBlanks  {
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
//    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul){
            //[replaced replaceObjectAtIndex:idx withObject:blank];
            [replaced removeObjectAtIndex:idx];
            idx--;
        }
        else if ([object isKindOfClass:[NSDictionary class]]){
            replaced[idx] = [object dictionaryByDeletingNullsWithBlanks];
        }
        else if ([object isKindOfClass:[NSArray class]]){
            replaced[idx] = [object arrayByDeletingNullsWithBlanks];
        }
    }
    return [replaced copy];
}

@end