//
//  FMInputTextField.m
//  herbalife
//
//  Created by Thomas Wolters on 21/01/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import "FMInputTextField.h"


@interface FMInputTextField()
@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UIView* viewLine;
@end


@implementation FMInputTextField

-(instancetype)initWithTitle:(NSString*)title isDark:(BOOL)dark{
    self = [super init];
    
    UIColor* textColor;
    UIColor* lineColor;
    if (dark == YES){
        textColor = [UIColor whiteColor];
        lineColor = textColor;
    }
    else{
        textColor = COLOR_TEXT;
        lineColor = COLOR_TEXT;
    }
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionSelectTextField:)];
    [self addGestureRecognizer:tapGesture];
    
    _label = [CHLControlsGenerator labelForText:title];
    _label.font = FONT_TEXT_MINI;
    _label.textColor = textColor;
    [self addSubview:_label];
    
    _textField = [[UITextField alloc] init];
    _textField.textColor = textColor;
    _textField.tintColor = textColor;
    _textField.font = FONT_TEXT;
//    _textField.placeholder = @"...";
    [self addSubview:_textField];
    
    _viewLine = [UIView new];
    _viewLine.backgroundColor = lineColor;
    [self addSubview:_viewLine];
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _label.frame = (CGRect){0,0,self.bounds.size};
    [_label sizeToFit];
    _label.frame = (CGRect){0,0,self.bounds.size.width ,_label.frame.size.height};
    _textField.frame = (CGRect){0,[_label pointRightBottom].y,self.bounds.size.width,30};
    _viewLine.frame = (CGRect){0,_textField.pointRightBottom.y,self.bounds.size.width,0.5f};
    NSLog(@"%f", _viewLine.frame.origin.y);
}

-(void)actionSelectTextField:(id) LINT_SUPPRESS_UNUSED_ATTRIBUTE sender{
    [_textField becomeFirstResponder];
}

-(void)setTitle:(NSString*)title{
    _label.text = title;
}
@end
