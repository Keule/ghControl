//
//  FMInputTextField.h
//  herbalife
//
//  Created by Thomas Wolters on 21/01/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import "CHLView.h"

@interface FMInputTextField : CHLView
@property (nonatomic, strong) UITextField* textField;
-(instancetype)initWithTitle:(NSString*)title isDark:(BOOL)dark;
-(void)setTitle:(NSString*)title;
@end
