//
//  FMViewController.m
//  XXX_PROJECTNAME_XXX
//
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "FMViewController.h"
#import "FLEXManager.h"

@interface FMViewController ()

@end

@implementation FMViewController

-(id)init{
    self = [super init];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    return self;
}




- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake && DEBUG_MODE)
    {
            [[FLEXManager sharedManager] showExplorer];
    }
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return  [[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:[[UIApplication sharedApplication] keyWindow]];
}

@end
