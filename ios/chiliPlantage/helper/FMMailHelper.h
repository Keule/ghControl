//
//  FMMailHelper.h
//  HabitSeed
//
//  Created by TW on 4/24/13.
//  Copyright (c) 2013 fluidmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FMMailCompleteBlock)();

@interface FMMailHelper : NSObject
- (void)mailOnViewController:(UIViewController *)viewController subject:(NSString *)subject toRecipients:(NSArray *)recipients completeAlertMessage:(NSString *)completeAlertMessage completeAlertTitle:(NSString *)completeAlertTitle completeBlock:(FMMailCompleteBlock)completeBlock;

- (void)mailOnViewController:(UIViewController *)viewController subject:(NSString *)subject toRecipients:(NSArray *)recipients completeAlertMessage:(NSString *)completeAlertMessage completeAlertTitle:(NSString *)completeAlertTitle body:(NSString *)body html:(BOOL)html completeBlock:(FMMailCompleteBlock)completeBlock;
@end
