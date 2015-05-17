//
//  HLInputDateView.h
//  herbalife
//
//  Created by Thomas Wolters on 26/11/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "CHLView.h"


@protocol FMInputDateViewDelegate
-(void)userDidSelectBackWithDate:(NSDate*)date;
@end


@interface FMInputDateView : CHLView
@property (nonatomic, weak) id <FMInputDateViewDelegate> delegateInputDateView;
@property (nonatomic, strong) UIDatePicker* datePicker;
-(instancetype)initWithDate:(NSDate*)date withTime:(BOOL)withTime;
@end
