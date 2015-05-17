//
//  FMICloudHelper.m
//  herbalife
//
//  Created by Thomas Wolters on 11/03/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import "FMICloudHelper.h"

@implementation FMICloudHelper


+ (BOOL)addSkipBackupiCloudAttributeToItemAtURL:(NSURL *)URL{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[URL path]] == YES){
        NSError *error = nil;
        BOOL success = [URL setResourceValue:@(YES)
                                      forKey:NSURLIsExcludedFromBackupKey error:&error];
        if (!success) {
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    }
    return NO;
}



@end
