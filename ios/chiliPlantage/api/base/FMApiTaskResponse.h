//
//  FMApiTaskResponse.h
//  Algel
//
//  Created by Thomas Wolters on 19/02/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

     enum FMApiTaskResponseStatus{
         FMApiTaskResponseStatusSuccess = 200,
         FMApiTaskResponseStatusSuccessCreated = 201,
         FMApiTaskResponseStatusFail = 404,
         FMApiTaskResponseUnprocessableEntity = 422,
         FMApiTaskResponseForbidden = 403
     };

@interface FMApiTaskResponse : NSObject
+(instancetype) initFailTask;
+(instancetype) initFailTaskWithAttributes:(NSDictionary*)dict;
-(instancetype) initWithStatus:(enum FMApiTaskResponseStatus)status attributes:(NSDictionary *)attributes;

    @property  (nonatomic, assign) enum FMApiTaskResponseStatus status;
    @property  (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) NSError* error;
@end
