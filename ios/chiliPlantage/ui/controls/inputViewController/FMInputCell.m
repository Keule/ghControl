//
//  HLInputCell.m
//  herbalife
//
//  Created by Thomas Wolters on 18/11/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMInputCell.h"

@implementation FMInputCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        _labelValidation = [UILabel new];
        _labelValidation.textColor = [UIColor redColor];
        _labelValidation.font = FONT_TEXT_MINI;
        [self addSubview:_labelValidation];
    }
    return self;
}



-(void)prepareForReuse{
    self.input = nil;
    self.labelValidation.text = @"";
    self.delegate = nil;
}

-(void)setInputDefinition:(FMInput*) LINT_SUPPRESS_UNUSED_ATTRIBUTE input{
    assert(@"never call");
}

-(void)setIsMarkedAsNotValid:(BOOL)isMarkedAsNotValid{
    _isMarkedAsNotValid = isMarkedAsNotValid;
    if (self.isMarkedAsNotValid){
        _labelValidation.text = self.input.invalidString;
    }
    else{
        _labelValidation.text = @"";
    }
}

@end
