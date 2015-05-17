
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "CHLControlsGenerator.h"
#import "FMNavigationController.h"

@implementation CHLControlsGenerator

+(FMTableView*)tableView{
    FMTableView* tableView = [FMTableView new];
    tableView.tableFooterView = [UIView new];
    return tableView;
}

+(UIButton*)buttonWithTarget:(NSObject*)target selector:(SEL)selector title:(NSString*)title{
    UIButton* button = [UIButton new];
    if (target && selector){
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+(UILabel*)labelForText:(NSString*)text{
    UILabel* label = [UILabel new];
    label.text = text;
    return label;
}

+(UITextField*)textfield{
    UITextField* textField = [UITextField new];
    return textField;
}

+(UINavigationController*)navigationControllerWithRootViewController:(UIViewController*)rootViewController{
    UINavigationController* navController = [[FMNavigationController alloc] initWithRootViewController:rootViewController];
    return navController;
}

@end
