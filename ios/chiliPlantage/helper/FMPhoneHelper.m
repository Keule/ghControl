//
//  FMTelefonHelper.m
//  winzerApp
//
//  Created by Thomas Wolters on 6/24/13.
//  Copyright (c) 2013 fluidmobile. All rights reserved.
//

#import "FMPhoneHelper.h"

@implementation FMPhoneHelper
+ (void)callNumber:(NSString *)numberString {
	NSString *phoneStr = @"telprompt://";
	if (numberString.length > 0) {
		NSString *cleanString = [numberString stringByReplacingOccurrencesOfString:@" " withString:@""];
		phoneStr = [phoneStr stringByAppendingFormat:@"%@", cleanString];
		NSURL *phoneURL = [NSURL URLWithString:phoneStr];
		[[UIApplication sharedApplication] openURL:phoneURL];
	}
}

@end
