//
//  HLInputNumberViewController.h
//  herbalife
//
//  Created by Thomas Wolters on 30/01/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//
#import "FMInput.h"

@protocol FMInputNumberViewController

-(void)userDidSelectNumber:(NSNumber*)number forInput:(FMInput*)input;

@end

#import "CHLViewController.h"


@interface FMInputNumberViewController : CHLViewController
@property (nonatomic, weak) id <FMInputNumberViewController> delegateInputNumberView;
-(instancetype)initWithNumber:(NSNumber*)number range:(NSRange)range stepping:(NSNumber*)stepping title:(NSString*)title input:(FMInput*)input;

@end