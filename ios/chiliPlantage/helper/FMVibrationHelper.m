//
//  FMVibrationHelper.m
//  HabitSeed
//
//  Created by TW on 5/9/13.
//  Copyright (c) 2013 fluidmobile. All rights reserved.
//

#import "FMVibrationHelper.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation FMVibrationHelper
//  NOTE: You need to import the AudioToolbox for access to the vibrate

//  The function:
+(void)vibrate {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
