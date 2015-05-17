//
//  FMUUIDGenerator.m
//  TITLE_ALGEL
//
//  Created by Thomas Wolters on 07/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import "FMUUIDGenerator.h"

@implementation FMUUIDGenerator
+ (NSString *)uuidString {
    // Returns a UUID

    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (__bridge_transfer NSString *) CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);

    return uuidString;
}
@end
