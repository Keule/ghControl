//
//  CHLTaskGetConfig.m
//  chiliPlantage
//
//  Created by Thomas Wolters on 17/05/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "CHLTaskGetConfig.h"



@interface CHLTaskGetConfig() <FMApiTaskDelegate>
@property (nonatomic, copy) CHLTaskGetConfigSuccessBlock blockSuccess;
@property (nonatomic, copy) FMApiTaskFailBlock blockFail;
@end

@implementation CHLTaskGetConfig
-(instancetype)initCompletionBlock:(CHLTaskGetConfigSuccessBlock)completionBlock failBlock:(FMApiTaskFailBlock)failBlock{
    NSString* url = [NSString stringWithFormat:@"%@/settings",API_URL];
    
    self = [super initWithCredentials:nil headerAttributes:nil bodyPayload:nil delegate:self httpMethod:FMApiTaskHttpMethodGet apiUrl:url];
    _blockSuccess = completionBlock;
    _blockFail = failBlock;
    return self;
}



-(void)task:(FMApiTask*) LINT_SUPPRESS_UNUSED_ATTRIBUTE task didFinishWithResponse:(FMApiTaskResponse*)response{
    switch (response.status){
            
        case FMApiTaskResponseStatusSuccessCreated:
        case FMApiTaskResponseStatusSuccess:{
            _blockSuccess(response.attributes);
            break;
        }
        case FMApiTaskResponseUnprocessableEntity:
        case FMApiTaskResponseStatusFail:
        case FMApiTaskResponseForbidden:
            _blockFail(nil);
            break;
    }
}

-(void)task:(FMApiTask *) LINT_SUPPRESS_UNUSED_ATTRIBUTE task failedWithError:(NSError *)error{
    NSLog(@"ERROR: %@ %@", [self class], error);
    _blockFail(error);
}


@end

