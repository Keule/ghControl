
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "CHLWorkflowManager.h"

#import "CHLDebugViewController.h"
#import "FMNavigationController.h"

@implementation CHLWorkflowManager

+(CHLWorkflowManager*)sharedInstance {
    static CHLWorkflowManager* sharedInstance;
    @synchronized(self)
    {
        if (!sharedInstance) sharedInstance = [[CHLWorkflowManager alloc] init];
        return sharedInstance;
    }
}

-(UIViewController *)initialViewController{

    return [[FMNavigationController alloc] initWithRootViewController:[CHLDebugViewController new]];
}
@end
