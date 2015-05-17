//
// Created by Thomas Wolters on 10/01/14.
// Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import "FMAlertViewHelper.h"


@implementation FMAlertViewHelper

+(UIAlertView *)createAlertWithTitle:(NSString*)title message:(NSString*)message buttonTitles:(NSArray*)buttonTitles {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:title];
    [alert setMessage:message];
    for (NSString* title in buttonTitles){
        [alert addButtonWithTitle:title];
    }

    return alert;
}


@end