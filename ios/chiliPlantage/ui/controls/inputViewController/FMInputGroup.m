//
//  HLInputGroup.m
//  herbalife
//
//  Created by Thomas Wolters on 14/03/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import "FMInputGroup.h"

@implementation FMInputGroup


+(FMInputGroup*)inputGroupWithInputs:(NSArray*)inputs title:(NSString*)title{
    FMInputGroup* inputGroup = [FMInputGroup new];
    inputGroup.title = title;
    inputGroup.inputs = inputs;
    return inputGroup;
}
@end
