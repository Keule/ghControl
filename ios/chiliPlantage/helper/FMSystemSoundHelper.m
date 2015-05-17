//
//  FMSystemSoundHelper.m
//  babynames
//
//  Created by Thomas Wolters on 20/10/14.
//  Copyright (c) 2014 fluidmobile. All rights reserved.
//

#import "FMSystemSoundHelper.h"
#import <AVFoundation/AVFoundation.h>

@implementation FMSystemSoundHelper


+(void)playSound{
    int systemSoundID = 1303;
    AudioServicesPlaySystemSound (systemSoundID);
}
@end
