//
//  FMApiTask.h
//  Algel
//
//  Created by Thomas Wolters on 19/02/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMApiTaskResponse.h"

typedef void (^FMApiTaskFailBlock)(NSError* error);

@class FMCredentials;

@class FMApiTask;

enum FMApiTaskHttpMethod{
    FMApiTaskHttpMethodPost = 1,
    FMApiTaskHttpMethodPut = 2,
    FMApiTaskHttpMethodGet = 3
};

@protocol FMApiTaskDelegate
    -(void)task:(FMApiTask*)task didFinishWithResponse:(FMApiTaskResponse*)response;
    -(void)task:(FMApiTask*)task failedWithError:(NSError*)error;
@end

@interface FMApiTask : NSObject

-(instancetype)initWithCredentials:(FMCredentials*)credentials headerAttributes:(NSDictionary *)headerAttributes bodyPayload:(NSDictionary *)bodyPayload delegate:(id <FMApiTaskDelegate>)delegate httpMethod:(enum FMApiTaskHttpMethod)httpMethod apiUrl:(NSString*)url;
-(void)execute;

@end
