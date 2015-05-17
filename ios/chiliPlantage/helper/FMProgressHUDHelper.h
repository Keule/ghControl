//
//  FMProgressHUDHelper.h
// KellerClient
//
//  Created by Thomas Wolters on 20/12/14.
//  Copyright (c) 2014 Thomas Wolters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMProgressHUDHelper : NSObject
+(void)showProgressHUDWithText:(NSString*)text onView:(UIView*)view;
+(void)showProgressHUDWithText:(NSString*)text onView:(UIView*)view duration:(double)duration;
@end
