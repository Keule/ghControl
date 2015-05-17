//
//  HLInputDateViewController.h
//  herbalife
//
//  Created by Thomas Wolters on 26/11/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "CHLViewController.h"

@protocol FMInputDateViewControllerDelegate

-(void)userDidSelectDate:(NSDate*)date;

@end

@interface FMInputDateViewController : CHLViewController
@property (nonatomic, weak) id <FMInputDateViewControllerDelegate> delegateInputDateView;
-(instancetype)initWithDate:(NSDate*)date withTime:(BOOL)withTime title:(NSString*)title;
@end
