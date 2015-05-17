//
//  HLInput.h
//  herbalife
//
//  Created by Thomas Wolters on 18/11/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, HLInputType) {
    HLInputTypeString = 1,
    HLInputTypeInt = 2,
    HLInputTypeFloat = 3,
    HLInputTypeDate = 4,
    
    HLInputTypeSwitch = 6,
    HLInputTypeEmail = 7,
    HLInputTypeDateTime = 9,
    HLInputTypeMinutes = 10
};

@interface FMInput : NSObject
@property (nonatomic, readonly) NSString* placeholder;
@property (nonatomic, readonly) NSString* invalidString;
@property (nonatomic, strong) NSObject* value;
@property (nonatomic, readonly) NSArray* switchLabels;
@property (nonatomic, assign, readonly) enum HLInputType type;
@property (nonatomic, readonly) NSString* key;
@property (nonatomic, assign) BOOL required;

@property (nonatomic, strong) NSObject* valueMinimum;
@property (nonatomic, strong) NSObject* valueMaximum;


-(instancetype)initSwitchWithKey:(NSString*)key switchLabels:(NSArray*)switchLabels invalidString:(NSString*)invalidString;
-(instancetype)initValueInputWithKey:(NSString*)key placeholder:(NSString*)placeholder type:(enum HLInputType)type invalidString:(NSString*)invalidString required:(BOOL)required;
@end
