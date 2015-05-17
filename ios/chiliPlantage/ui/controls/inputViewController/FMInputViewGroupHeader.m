//
//  HLInputViewGroupHeader.m
//  herbalife
//
//  Created by Thomas Wolters on 14/03/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import "FMInputViewGroupHeader.h"
#import "CHLControlsGenerator.h"

@interface FMInputViewGroupHeader()
@property (nonatomic, strong) UILabel* label;
@end

@implementation FMInputViewGroupHeader

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    _label = [CHLControlsGenerator labelForText:@""];

    _label.textColor = COLOR_TEXT;
    [self addSubview:_label];
    return self;
}

-(void)setTitle:(NSString *)title{
    _label.text = title;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _label.frame = (CGRect){LAYOUT_BORDER_DEFAULT,0,self.bounds.size.width-2*LAYOUT_BORDER_DEFAULT,self.bounds.size.height};
}
@end
