//
//  HLInputCell.h
//  herbalife
//
//  Created by Thomas Wolters on 03/09/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMInputCell.h"

@class FMInput;
#define CELL_INPUT_HEIGHT 62
#define CELL_INPUT_SINGLE_VALUE @"CELL_INPUT_SINGLE_VALUE"

@interface FMInputCellSingleValue : FMInputCell
+(float)minimumWidthForTitle:(NSString*)title invalidString:(NSString*)invalidString width:(float)width;

@end
