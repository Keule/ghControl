//
//  FMTableViewHeader.h
//  herbalife
//
//  Created by Thomas Wolters on 08/02/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import "CHLView.h"
#define TABLE_VIEW_HEADER_TOP_VIEW_HEIGHT 80

@interface FMTableViewHeader : CHLView
- (instancetype)initWithMessage:(NSString*)message topView:(UIView*)view textColor:(UIColor*)textColor;

+(float)heightForHeaderWithMessage:(NSString*)message hasTopView:(BOOL)topView width:(float)width;
@end
