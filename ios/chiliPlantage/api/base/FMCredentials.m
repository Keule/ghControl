//
//  FMCredentials.m
//  TITLE_ALGEL
//
//  Created by Thomas Wolters on 19/12/13.
//  Copyright (c) 2013 Fluidmobile. All rights reserved.
//

#import "FMCredentials.h"

#define KEY_TYPE @"type"
#define KEY_USERNAME @"username"
#define KEY_PASSWORD @"password"

@implementation FMCredentials

- (id)initWithUsername:(NSString *)username password:(NSString *)password type:(enum FMCredentialType)type {
    self = [super init];
    _username = username;
    _password = password;
    _type = type;
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:[NSNumber numberWithInt:self.type] forKey:KEY_TYPE];
    [encoder encodeObject:_username forKey:KEY_USERNAME];
    [encoder encodeObject:_password forKey:KEY_PASSWORD];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    _password = [decoder decodeObjectForKey:KEY_PASSWORD];
    _username = [decoder decodeObjectForKey:KEY_USERNAME];
    _type = (int) [[decoder decodeObjectForKey:KEY_TYPE] integerValue];
    return self;
}

@end
