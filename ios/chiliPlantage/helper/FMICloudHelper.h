//
//  FMICloudHelper.h
//  herbalife
//
//  Created by Thomas Wolters on 11/03/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMICloudHelper : NSObject
+ (BOOL)addSkipBackupiCloudAttributeToItemAtURL:(NSURL *)URL;
@end
