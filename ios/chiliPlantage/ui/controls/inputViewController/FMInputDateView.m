//
//  HLInputDateView.m
//  herbalife
//
//  Created by Thomas Wolters on 26/11/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMInputDateView.h"

@interface FMInputDateView()
@property (nonatomic, strong) UIButton* buttonDone;
@end


@implementation FMInputDateView

-(instancetype)initWithDate:(NSDate*)date withTime:(BOOL)withTime{
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    _datePicker = [UIDatePicker new];
    if (withTime == NO){
        self.datePicker.datePickerMode = UIDatePickerModeDate;
    }
    else{
        self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    if(date){
        [self.datePicker setDate:date];
    }


    [self addSubview:self.datePicker];
    
    _buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    //TODO: localize
    [self.buttonDone setTitle:NSLocalizedString(@"input.button.action.save",@"input.button.action.save") forState:UIControlStateNormal];
    [self.buttonDone setBackgroundColor:COLOR_BACKGROUND];
    [self.buttonDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonDone addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonDone.titleLabel.font = FONT_TITLE;
    [self addSubview:self.buttonDone];
    
    return self;
}

-(void)layoutSubviews{
    _datePicker.frame = (CGRect){0,100,self.bounds.size.width,216};
    
    _buttonDone.frame = (CGRect){0,self.bounds.size.height-HEIGHT_BOTTOM_BAR,self.bounds.size.width,HEIGHT_BOTTOM_BAR};
}

-(void)actionSave:(id) LINT_SUPPRESS_UNUSED_ATTRIBUTE sender{
    
    [_delegateInputDateView userDidSelectBackWithDate:_datePicker.date];
}

@end
