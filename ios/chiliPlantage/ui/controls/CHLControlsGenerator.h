
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTableView.h"
@interface CHLControlsGenerator : NSObject

+(FMTableView*)tableView;
+(UIButton*)buttonWithTarget:(NSObject*)target selector:(SEL)selector title:(NSString*)title;
+(UILabel*)labelForText:(NSString*)text;
+(UITextField*)textfield;
+(UINavigationController*)navigationControllerWithRootViewController:(UIViewController*)rootViewController;
@end
