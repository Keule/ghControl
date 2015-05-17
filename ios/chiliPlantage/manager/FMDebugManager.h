//
//  FMDebugManager.h
//  testANTPLUS
//
//  Created by Thomas Wolters on 02/09/14.
//  Copyright (c) 2014 fluidmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDebugManager : NSObject
+(void)showInformation:(NSString*)information title:(NSString*)title force:(BOOL)force;
@end
