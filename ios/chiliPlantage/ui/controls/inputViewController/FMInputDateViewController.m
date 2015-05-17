//
//  HLInputDateViewController.m
//  herbalife
//
//  Created by Thomas Wolters on 26/11/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMInputDateViewController.h"
#import "FMInputDateView.h"

@interface FMInputDateViewController () <FMInputDateViewDelegate>
@property (nonatomic, strong) FMInputDateView* viewInputDate;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, assign) BOOL withTime;
@end

@implementation FMInputDateViewController

-(instancetype)initWithDate:(NSDate*)date withTime:(BOOL)withTime title:(NSString*)title{
    self = [super init];
    _date = date;
    _withTime = withTime;
    self.title = title;
    return self;
}

-(void)loadView{
    self.viewInputDate = [[FMInputDateView alloc] initWithDate:_date withTime:_withTime];
    self.view = _viewInputDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewInputDate.delegateInputDateView = self;
}

-(void)userDidSelectBackWithDate:(NSDate *)date{
    [self saveDate:date];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveDate:(NSDate*)date{
    if (_withTime){
        self.date = date;
    }
    else{
        self.date = [self dateWithOutTime:date];
    }
    [_delegateInputDateView userDidSelectDate:_date];
}

-(NSDate *)dateWithOutTime:(NSDate *)datDate {
    NSDate* date = datDate;
    if( date == nil ) {
        date = [NSDate date];
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

@end
