//
//  FMNavigationController.m
//  urichProductCatalog
//
//  Created by Thomas Wolters on 27/10/14.
//  Copyright (c) 2014 fluidmobile. All rights reserved.
//

#import "FMNavigationController.h"

@implementation FMNavigationController


-(NSUInteger)supportedInterfaceOrientations{
    return  [[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:[[UIApplication sharedApplication] keyWindow]];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
