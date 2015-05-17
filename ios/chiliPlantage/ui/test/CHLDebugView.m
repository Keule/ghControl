//
//  CHLDebugView.m
//  chiliPlantage
//
//  Created by Thomas Wolters on 17/05/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "CHLDebugView.h"

@implementation CHLDebugView

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _tableView = [CHLControlsGenerator tableView];
    [self addSubview:_tableView];
    return self;
}

-(void)layoutSubviews{
    _tableView.frame = self.bounds;
}

@end
