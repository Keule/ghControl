//
//  HLInputNumberView.h
//  herbalife
//
//  Created by Thomas Wolters on 30/01/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import "CHLView.h"

@protocol FMInputNumberViewDelegate

-(void)userDidFinishWithNumber:(NSNumber*)number;

@end

@interface FMInputNumberView : CHLView
@property (nonatomic, strong) UIPickerView* pickerView;
@property (nonatomic, weak) id <FMInputNumberViewDelegate> delegateNumberInput;
-(instancetype)initWithNumber:(NSNumber*)number range:(NSRange)range stepping:(NSNumber*)stepping title:(NSString*)title;
-(void)selectPreselectedRow;
@end
