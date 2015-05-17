//
//  FMProgressHUDHelper.m
// KellerClient
//
//  Created by Thomas Wolters on 20/12/14.
//  Copyright (c) 2014 Thomas Wolters. All rights reserved.
//

#import "FMProgressHUDHelper.h"
#import "MBProgressHUD.h"

@implementation FMProgressHUDHelper

+(void)showProgressHUDWithText:(NSString*)text onView:(UIView*)view duration:(double)duration{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:duration];
}

+(void)showProgressHUDWithText:(NSString*)text onView:(UIView*)view{
    [FMProgressHUDHelper showProgressHUDWithText:text onView:view duration:1.0f];

}
@end
