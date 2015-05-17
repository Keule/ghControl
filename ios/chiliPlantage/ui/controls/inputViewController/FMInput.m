//
//  HLInput.m
//  herbalife
//
//  Created by Thomas Wolters on 18/11/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMInput.h"

@implementation FMInput


-(instancetype)initWithKey:(NSString*)key type:(enum HLInputType)type invalidString:(NSString*)invalidString required:(BOOL)required{
    self = [super init];
    _type = type;
    _key = key;
    _invalidString = invalidString;
    _required = required;
    return self;
}

-(instancetype)initSwitchWithKey:(NSString*)key switchLabels:(NSArray*)switchLabels invalidString:(NSString*)invalidString{
    self = [self initWithKey:key type:HLInputTypeSwitch invalidString:invalidString required:YES];
    _switchLabels = switchLabels;
    return self;
}

-(instancetype)initValueInputWithKey:(NSString*)key placeholder:(NSString*)placeholder type:(enum HLInputType)type invalidString:(NSString*)invalidString required:(BOOL)required{
    self = [self initWithKey:key type:type invalidString:invalidString required:required];
    _placeholder = placeholder;
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"key: %@ value %@", self.key, self.value];
}

-(NSString *)debugDescription{
    return self.description;
}

@end