//
//  HLSwitchCell.m
//  herbalife
//
//  Created by Thomas Wolters on 19/09/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMInputCellSwitch.h"
#import "CHLManagerLayer.h"

#define LINE_HEIGHT 1.0
#define BOTTOM_OFFSET 15

enum HLInputCellState {
    HLInputCellStateBeforAnimating = 0,
    HLInputCellStateAfterAnimating = 1
};

@interface FMInputCellSwitch ()
    @property (nonatomic, strong) UISegmentedControl* viewSwitch;
    @property (nonatomic, assign) enum HLInputCellState state;
@end

#define TEXTFIELD_HEIGHT 30

@implementation FMInputCellSwitch

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        [self.contentView addSubview:_viewSwitch];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _viewSwitch.frame = (CGRect) {LAYOUT_BORDER_DEFAULT, 10, self.bounds.size.width - 2 * LAYOUT_BORDER_DEFAULT, TEXTFIELD_HEIGHT};
    self.labelValidation.frame = (CGRect){LAYOUT_BORDER_DEFAULT, self.bounds.size.height-10,self.bounds.size.width,10};
}

-(void)valueChanged:(UISegmentedControl*)segmentedControl {
    [self.delegate userDidChangeValue:@(segmentedControl.selectedSegmentIndex) key:self.input.key cell:self];
}


-(void)setInputDefinition:(FMInput*)input{
    self.input = input;
    if (_viewSwitch){
        [_viewSwitch removeFromSuperview];
    }
    self.viewSwitch = [[UISegmentedControl alloc] initWithItems:input.switchLabels];
    if (input.value){
        [_viewSwitch setSelectedSegmentIndex:((NSNumber*)self.input.value).integerValue];
    }
    _viewSwitch.tintColor = [UIColor whiteColor];
    [_viewSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_viewSwitch];
    if (input.value){
        NSNumber* number = (NSNumber*)input.value;
        _viewSwitch.selectedSegmentIndex = [number integerValue];
    }
    else{
        _viewSwitch.selectedSegmentIndex = 0;
    }

    [self setNeedsLayout];
}

@end
