//
//  CHLTaskGetSonsorData.m
//  chiliPlantage
//
//  Created by Thomas Wolters on 17/05/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "CHLTaskGetSonsorData.h"

@interface CHLTaskGetSonsorData() <FMApiTaskDelegate>
@property (nonatomic, copy) CHLTaskGetSonsorDataSuccessBlock blockSuccess;
@property (nonatomic, copy) FMApiTaskFailBlock blockFail;
@end

@implementation CHLTaskGetSonsorData
-(instancetype)initCompletionBlock:(CHLTaskGetSonsorDataSuccessBlock)completionBlock failBlock:(FMApiTaskFailBlock)failBlock{
    NSString* url = [NSString stringWithFormat:@"%@/states",API_URL];

    self = [super initWithCredentials:nil headerAttributes:nil bodyPayload:nil delegate:self httpMethod:FMApiTaskHttpMethodGet apiUrl:url];
    _blockSuccess = completionBlock;
    _blockFail = failBlock;
return self;
}



-(void)task:(FMApiTask*) LINT_SUPPRESS_UNUSED_ATTRIBUTE task didFinishWithResponse:(FMApiTaskResponse*)response{
    switch (response.status){
            
        case FMApiTaskResponseStatusSuccessCreated:
        case FMApiTaskResponseStatusSuccess:{
            _blockSuccess((NSArray*)response.attributes);
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


