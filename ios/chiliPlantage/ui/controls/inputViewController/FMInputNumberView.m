//
//  HLInputNumberView.m
//  herbalife
//
//  Created by Thomas Wolters on 30/01/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//
#import "FMInputNumberView.h"

@interface FMInputNumberView() <UIPickerViewDelegate, UIPickerViewDataSource>
    @property (nonatomic, strong) NSNumber* number;
    @property (nonatomic, assign) NSRange range;
    @property (nonatomic, strong) NSNumber* stepping;
@property (nonatomic, strong) UIButton* buttonDone;
@property (nonatomic, strong) NSString* title;
@end

@implementation FMInputNumberView

-(instancetype)initWithNumber:(NSNumber*)number range:(NSRange)range stepping:(NSNumber*)stepping title:(NSString*)title{
    self = [super init];
    _title = title;
    self.backgroundColor = [UIColor whiteColor];
    _pickerView = [UIPickerView new];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    
    _range = range;
    _number = number;
    _stepping = stepping;
    
    _buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    //TODO: localize
    [_buttonDone setTitle:NSLocalizedString(@"input.button.action.save", @"input.button.action.save") forState:UIControlStateNormal];
    [_buttonDone setBackgroundColor:COLOR_BACKGROUND];
    [_buttonDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonDone addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
    _buttonDone.titleLabel.font = FONT_BUTTON;
    [self addSubview:_buttonDone];
    
    
    return self;
}

-(void)layoutSubviews{
    _pickerView.frame = (CGRect){0,100,self.bounds.size.width,216};
    _buttonDone.frame = (CGRect){0,self.bounds.size.height-HEIGHT_BOTTOM_BAR,self.bounds.size.width, HEIGHT_BOTTOM_BAR};
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *) LINT_SUPPRESS_UNUSED_ATTRIBUTE pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *) LINT_SUPPRESS_UNUSED_ATTRIBUTE pickerView numberOfRowsInComponent:(NSInteger) LINT_SUPPRESS_UNUSED_ATTRIBUTE component{
    return (int)((_range.length - _range.location) / _stepping.integerValue);
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *) LINT_SUPPRESS_UNUSED_ATTRIBUTE pickerView titleForRow:(NSInteger)row forComponent:(NSInteger) LINT_SUPPRESS_UNUSED_ATTRIBUTE component{
    return [NSString stringWithFormat:@"%li %@",[[self numberForRow:row] longValue], _title];
}

-(void)actionSave:(id) LINT_SUPPRESS_UNUSED_ATTRIBUTE sender{
    [_delegateNumberInput userDidFinishWithNumber:[self numberForRow:[_pickerView selectedRowInComponent:0]]];
}

-(NSNumber*)numberForRow:(NSInteger)row{
    return [NSNumber numberWithLong:(_range.location + (row+1) * _stepping.integerValue)];
}

-(void)selectPreselectedRow{
    if (_number){
        long row = (_number.longValue - _range.location) / _stepping.longValue;
        [_pickerView selectRow:row-1 inComponent:0 animated:YES];
    }

}

@end
