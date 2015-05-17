//
//  HLInputGroup.h
//  herbalife
//
//  Created by Thomas Wolters on 14/03/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMInputGroup : NSObject
@property (nonatomic, strong) NSArray* inputs;
@property (nonatomic, strong) NSString* title;

+(FMInputGroup*)inputGroupWithInputs:(NSArray*)inputs title:(NSString*)title;
@end
