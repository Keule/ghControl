//
//  FMTableView.h
//  XXX_PROJECTNAME_XXX
//
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMTableView : UITableView
+(float)heightForHeaderWithMessage:(NSString*)message hasTopView:(BOOL)topView width:(float)width;
+ (UIView*)headerViewWithMessage:(NSString*)message topView:(UIView*)view textColor:(UIColor*)textColor;
@end
