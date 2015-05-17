//
//  HLInputContactCell.m
//  herbalife
//
//  Created by Thomas Wolters on 18/11/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMInputCellObject.h"
#import "FMDateHelper.h"
#import "CHLControlsGenerator.h"

@interface FMInputCellObject()
@property (nonatomic, strong) UILabel* labelDescription;
@property (nonatomic, strong) UILabel* labelValue;

@property (nonatomic, strong) UIView* viewLine;
@end
@implementation FMInputCellObject


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    self.backgroundColor = COLOR_BACKGROUND;
    
    _labelDescription = [CHLControlsGenerator labelForText:@""];
    _labelDescription.textAlignment = NSTextAlignmentLeft;
    _labelDescription.textColor = [UIColor whiteColor];
    _labelDescription.font = FONT_TEXT_MINI;
    [self.contentView addSubview:_labelDescription];
    
    //        _labelValue = [HLControlsGenerator labelForText:@"..."];
    _labelValue = [CHLControlsGenerator labelForText:@""];
    _labelValue.textColor = [UIColor whiteColor];
    _labelValue.numberOfLines = 2;
    _labelValue.textColor = [UIColor lightTextColor];
    _labelValue.font = FONT_TEXT_SMALL;
    [self.contentView addSubview:_labelValue];
    
    _viewLine = [UIView new];
    _viewLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:_viewLine];
    return self;
}

-(void)prepareForReuse{
    [super prepareForReuse];
    _labelDescription.text = @"";
    _labelValue.text = @"";
 _labelValue.textColor = [UIColor lightTextColor];
}

-(void)layoutSubviews{
    _labelDescription.frame = (CGRect){0,0,self.bounds.size};
    [_labelDescription sizeToFit];
    _labelDescription.frame = (CGRect){LAYOUT_BORDER_DEFAULT,0,self.bounds.size.width - 2*LAYOUT_BORDER_DEFAULT ,_labelDescription.frame.size.height};
    _labelValue.frame = (CGRect){LAYOUT_BORDER_DEFAULT,[_labelDescription pointRightBottom].y,self.bounds.size.width - LAYOUT_BORDER_DEFAULT*2,30};
    _viewLine.frame = (CGRect){LAYOUT_BORDER_DEFAULT,_labelValue.pointRightBottom.y,self.bounds.size.width-2*LAYOUT_BORDER_DEFAULT,0.5f};
    
    
    self.labelValidation.frame = (CGRect){LAYOUT_BORDER_DEFAULT, self.bounds.size.height-10,self.bounds.size.width,10};
}
-(void)setInputDefinition:(FMInput*)input{
    self.input = input;
     _labelValue.textColor = [UIColor whiteColor];
    if (input.required){
        _labelDescription.text = [NSString stringWithFormat:@"%@ %@",input.placeholder, INPUT_REQUIRED_MARK ];
    }
    else{
        _labelDescription.text = input.placeholder;
    }

    if(input.value){
        switch (input.type) {
            case HLInputTypeDateTime:
                _labelValue.text = [FMDateHelper dateToString:((NSDate*)input.value) formatString:@"dd.MM.yyyy - HH:mm"];
                break;
            case HLInputTypeDate:
                _labelValue.text = [FMDateHelper dateToString:((NSDate*)input.value) formatString:@"dd.MM.yyyy"];
                break;
            case HLInputTypeMinutes:{
                NSNumber* minutes = (NSNumber*)input.value;
                _labelValue.text = [NSString stringWithFormat:@"%li", minutes.longValue];
            }
                break;
            default:
                NSAssert(NO, @"never reach");
                break;
        }
    }

}

@end
