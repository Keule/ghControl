//
// Created by Thomas Wolters on 10/01/14.
// Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMAlertViewHelper : NSObject
+(UIAlertView *)createAlertWithTitle:(NSString*)title message:(NSString*)message buttonTitles:(NSArray*)buttonTitles;
@end