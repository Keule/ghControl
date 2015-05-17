//
//  HLProspectNewViewController.h
//  herbalife
//
//  Created by Thomas Wolters on 28/08/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "CHLViewController.h"
#import "FMInput.h"


@class HLDataCustomer;

#define INPUT_VIEW_CONTROLLER_ATTRIBUTE_GROUP_TITLE @"INPUT_VIEW_CONTROLLER_ATTRIBUTE_GROUP_TITLE"
#define INPUT_VIEW_CONTROLLER_ATTRIBUTE_GROUP_INPUTS @"INPUT_VIEW_CONTROLLER_ATTRIBUTE_GROUP_INPUTS"


@interface FMInputViewController : CHLViewController


@property (nonatomic, strong) NSObject* payloadObjectX;
@property (nonatomic, assign) BOOL showShareAppointment;
@property (nonatomic, assign) int tagForIdentification;
-(instancetype)initWithGroups:(NSArray*)groups title:(NSString*)title actionTitle:(NSString*)actionTitle tag:(NSString*)tag payload:(NSObject*)payload showTopNavigation:(BOOL)showTopNavigation columCount:(int)columnCount;

@end
