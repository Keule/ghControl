//
//  FMTableView.m
//  XXX_PROJECTNAME_XXX
//
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "FMTableView.h"
#import "FMTableViewHeader.h"

@implementation FMTableView

+(float)heightForHeaderWithMessage:(NSString*)message hasTopView:(BOOL)topView width:(float)width{
    return [FMTableViewHeader heightForHeaderWithMessage:message hasTopView:topView width:width];
}

+ (UIView*)headerViewWithMessage:(NSString*)message topView:(UIView*)view textColor:(UIColor*)textColor{
    UIView* header = [[FMTableViewHeader alloc] initWithMessage:message topView:view textColor:textColor];
    return header;
}


@end
