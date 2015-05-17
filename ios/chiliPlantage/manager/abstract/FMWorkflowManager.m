//
//  FMWorkflowManager.m
//  babynames
//
//  Created by Thomas Wolters on 16/07/14.
//  Copyright (c) 2014 fluidmobile. All rights reserved.
//

#import "FMWorkFlowManager.h"

#import "SWRevealViewController.h"



@implementation FMWorkFlowManager

//+ (FMWorkFlowManager *)sharedInstance {
//    static FMWorkFlowManager *sharedInstance;
//    @synchronized (self) {
//        if (!sharedInstance) sharedInstance = [[FMWorkFlowManager alloc] init];
//        
//        return sharedInstance;
//    }
//}

-(UIViewController *)initialViewController{
    return nil;
}

//SAMPLE
//- (UIViewController *)presentControllerUserSettingsOnViewController:(UIViewController *)viewController {
//    UIViewController *viewControllerNext = [FMUserSettingsViewController new];
//    return [self presentViewController:viewControllerNext onViewController:viewController];
//}

- (UIViewController *)presentViewController:(UIViewController *)vcNew onViewController:(UIViewController *)vcBase {
    if (vcBase && vcNew) {
        if ([vcNew isKindOfClass:[UINavigationController class]] || [vcNew isKindOfClass:[UITabBarController class]] || [vcNew isKindOfClass:[SWRevealViewController class]] ) {
            [vcBase presentViewController:vcNew animated:YES completion:nil];
        }
        else {
            [vcBase.navigationController pushViewController:vcNew animated:YES];
        }
    }
    return vcNew;
}



@end
