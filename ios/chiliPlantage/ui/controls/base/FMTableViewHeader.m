//
//  FMTableViewHeader.m
//  herbalife
//
//  Created by Thomas Wolters on 08/02/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import "FMTableViewHeader.h"


#define FONT HL_FONT_BUTTON
#define PADDING_LABEL LAYOUT_BORDER_DEFAULT * 3


@interface FMTableViewHeader()
    @property (nonatomic, strong) UILabel* label;
    @property (nonatomic, strong) UIView* viewTop;
@end

@implementation FMTableViewHeader

- (instancetype)initWithMessage:(NSString*)message topView:(UIView*)view textColor:(UIColor*)textColor {
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    _viewTop = view;
    [self addSubview:_viewTop];
    
    if (message&&message.length > 0){
        _label = [CHLControlsGenerator labelForText:message];
        _label.font = FONT_TEXT;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
        _label.textColor = textColor ? textColor : COLOR_TEXT;
        [self addSubview:_label];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _viewTop.frame = (CGRect){(self.bounds.size.width-TABLE_VIEW_HEADER_TOP_VIEW_HEIGHT)/2,PADDING_LABEL,TABLE_VIEW_HEADER_TOP_VIEW_HEIGHT,TABLE_VIEW_HEADER_TOP_VIEW_HEIGHT};
    _label.frame = (CGRect){PADDING_LABEL,LAYOUT_BORDER_DEFAULT+(_viewTop?_viewTop.pointRightBottom.y:PADDING_LABEL),self.bounds.size.width-2*PADDING_LABEL,4000};
    [_label sizeToFit];
    _label.center = (CGPoint){self.bounds.size.width/2,_label.center.y};
}

+(float)heightForHeaderWithMessage:(NSString*)message hasTopView:(BOOL)topView width:(float)width{
    float height = 0;
    if (topView == YES){
        height += PADDING_LABEL + TABLE_VIEW_HEADER_TOP_VIEW_HEIGHT;
    }
    
    if (message&& message.length > 0){
        height += (topView == YES ? LAYOUT_BORDER_DEFAULT:PADDING_LABEL) + [FMTableViewHeader heightForText:message inWidth:(width-2*PADDING_LABEL) font:FONT_TEXT];
    }
    return height;
}

+(float)heightForText:(NSString*)text inWidth:(float)width font:(UIFont*)font{
    return [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                           attributes:@{
                                        NSFontAttributeName :font
                                        }
                              context:nil].size.height;
}

@end
