//
//  HLInputCell.m
//  herbalife
//
//  Created by Thomas Wolters on 03/09/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMInputCellSingleValue.h"
#import "CHLManagerLayer.h"
#import "FMInput.h"
#import "FMInputTextField.h"

#define LINE_HEIGHT 1.0
#define BOTTOM_OFFSET 15

enum HLInputCellState {
	HLInputCellStateBeforAnimating = 0,
	HLInputCellStateAfterAnimating = 1
};

@interface FMInputCellSingleValue () <UITextFieldDelegate>
    @property (nonatomic, strong) UIView* viewLine;
    @property (nonatomic, strong) FMInputTextField* textField;
    @property (nonatomic, assign) enum HLInputCellState state;


@end

#define TEXTFIELD_HEIGHT 50
@implementation FMInputCellSingleValue




- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.delegate userDidFinishEditInCell:self input:self.input value:textField.text];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = COLOR_BACKGROUND;
        
		_textField  = [[FMInputTextField alloc] initWithTitle:@"" isDark:YES];
		_textField.textField.delegate = self;
		[_textField.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
		[self.contentView addSubview:_textField];
	}
	return self;
}

-(void)prepareForReuse{
    [super prepareForReuse];
}

-(UIKeyboardType)keyboardtypeForInputType:(HLInputType)type{
    UIKeyboardType keyboardType;
    switch (type) {
        case HLInputTypeFloat:
            keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case HLInputTypeInt:
            keyboardType = UIKeyboardTypeNumberPad;
            break;
        case HLInputTypeString:
            keyboardType = UIKeyboardTypeAlphabet;
            break;
        case HLInputTypeEmail:
            keyboardType = UIKeyboardTypeEmailAddress;
            break;
        default:
            assert(@"never called");
            break;
    }
    return keyboardType;
}

-(NSString*)textForInput:(FMInput*)input{
    NSString* text;
    switch (input.type) {
        case HLInputTypeFloat:
            text = [NSString stringWithFormat:@"%1.1f",((NSNumber*)input.value).floatValue];
            break;
        case HLInputTypeInt:
            text = [NSString stringWithFormat:@"%li",[((NSNumber*)input.value) longValue]];
            break;
        case HLInputTypeString:
        case HLInputTypeEmail:
            text = (NSString*)input.value;
            break;
        default:
            assert(@"never called");
            break;
    }
    return text;
}

-(void)setInputDefinition:(FMInput*)input{
    self.input = input;
    
    NSString* title;
    if (input.required){
        title = [NSString stringWithFormat:@"%@ %@",input.placeholder, INPUT_REQUIRED_MARK ];
    }
    else{
        title = input.placeholder;
    }
    [_textField setTitle:title];
    
    _textField.textField.keyboardType = [self keyboardtypeForInputType:input.type];
    
    //create Bar buttons
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionResign)];
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_APP_TINT_COLOR} forState:UIControlStateNormal];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar.tintColor = [UIColor whiteColor];
    [toolbar setItems:@[flexibleSpace, barButtonItem]];
    
    _textField.textField.inputAccessoryView = toolbar;
    if (input.value){
        _textField.textField.text = [self textForInput:input];
    }
    else{
        _textField.textField.text = @"";
    }
}

-(void)layoutSubviews {
//	switch (self.state) {
//		case HLInputCellStateBeforAnimating:
//			_viewLine.frame = (CGRect) {self.bounds.size.width, self.bounds.size.height - LINE_HEIGHT - BOTTOM_OFFSET, self.bounds.size.width - 2 * LAYOUT_BORDER_DEFAULT, LINE_HEIGHT};
//			_textField.frame = (CGRect) {self.bounds.size.width, self.bounds.size.height - 30 - BOTTOM_OFFSET, self.bounds.size.width - 2 * LAYOUT_BORDER_DEFAULT, TEXTFIELD_HEIGHT};
//			break;
//
//		case HLInputCellStateAfterAnimating:
    _viewLine.frame = (CGRect) {LAYOUT_BORDER_DEFAULT, self.bounds.size.height - LINE_HEIGHT - BOTTOM_OFFSET, self.bounds.size.width - 2 * LAYOUT_BORDER_DEFAULT, LINE_HEIGHT};
    _textField.frame = (CGRect) {LAYOUT_BORDER_DEFAULT, 5, self.bounds.size.width - 2 * LAYOUT_BORDER_DEFAULT, TEXTFIELD_HEIGHT};
    
    self.labelValidation.frame = (CGRect){LAYOUT_BORDER_DEFAULT, self.bounds.size.height-10,self.bounds.size.width,10};
//			break;
//
//		default:
//			break;
//	}
}

-(void)textFieldDidChange:(UITextField*)textField {
    [self.delegate userDidChangeValue:textField.text key:self.input.key cell:self];
}

-(void)actionResign{
    [_textField.textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField {
	[textField resignFirstResponder];
	return YES;
}

+(float)minimumWidthForTitle:(NSString*)title invalidString:(NSString*)invalidString width:(float)width{
    float widthTitle = [self widthForText:title inWidth:width font:FONT_TEXT] + 2*LAYOUT_BORDER_DEFAULT;
    float widthInvalidString = [self widthForText:invalidString inWidth:width font:FONT_TEXT]  + 2*LAYOUT_BORDER_DEFAULT;
    return MAX(widthTitle, widthInvalidString);
    
}


@end
