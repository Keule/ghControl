//
//  FMDebugManager.m
//  testANTPLUS
//
//  Created by Thomas Wolters on 02/09/14.
//  Copyright (c) 2014 fluidmobile. All rights reserved.
//

#define DEBUG_ON NO
#import "FMDebugManager.h"

@implementation FMDebugManager

+(void)showInformation:(NSString*)information title:(NSString*)title force:(BOOL)force {
	if (DEBUG_ON || (force && NO)) {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:information delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	}
}

@end
