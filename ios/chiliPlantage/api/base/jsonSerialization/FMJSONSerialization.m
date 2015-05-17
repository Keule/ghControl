//
//  FMJSONSerialization.m
//  Algel
//
//  Created by Thomas Wolters on 20/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import "FMJSONSerialization.h"
#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"

@implementation FMJSONSerialization
+(id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing *)error{
    NSObject* object = [NSJSONSerialization JSONObjectWithData:data options:opt error:error];

    if ([object isKindOfClass:[NSArray class]]){
        return [((NSArray*)object) arrayByDeletingNullsWithBlanks];
    }

    return [((NSDictionary*)object) dictionaryByDeletingNullsWithBlanks];
}


@end
