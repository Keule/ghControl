//
//  FMWorkflowManager.h
//  babynames
//
//  Created by Thomas Wolters on 16/07/14.
//  Copyright (c) 2014 fluidmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMWorkFlowManager : NSObject
//+ (FMWorkFlowManager *)sharedInstance;
- (UIViewController *)presentViewController:(UIViewController *)vcNew onViewController:(UIViewController *)vcBase;
- (UIViewController *)initialViewController;
@end
