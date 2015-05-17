//
//  FMCredentials.h
//  TITLE_ALGEL
//
//  Created by Thomas Wolters on 19/12/13.
//  Copyright (c) 2013 Fluidmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

enum FMCredentialType {
    FMCredentialsTypeLoginCBTemp = 1,
    FMCredentialsTypeLoginCBFull = 2,
    FMCredentialsTypeLoginWebservice = 3
};

@interface FMCredentials : NSObject
@property(nonatomic, strong, readonly) NSString *username;
@property(nonatomic, strong, readonly) NSString *password;
@property(nonatomic, assign, readonly) enum FMCredentialType type;

- (id)initWithUsername:(NSString *)username password:(NSString *)password type:(enum FMCredentialType)type;
@end
