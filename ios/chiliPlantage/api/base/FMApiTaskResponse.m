//
//  FMApiTaskResponse.m
//  Algel
//
//  Created by Thomas Wolters on 19/02/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import "FMApiTaskResponse.h"

@implementation FMApiTaskResponse

+(instancetype) initFailTaskWithAttributes:(NSDictionary*)attributes{
    return [[FMApiTaskResponse  alloc] initWithStatus:FMApiTaskResponseStatusFail attributes:attributes];
}
+(instancetype) initFailTask{
    return [FMApiTaskResponse  initFailTaskWithAttributes:nil];
}
-(instancetype) initWithStatus:(enum FMApiTaskResponseStatus)status attributes:(NSDictionary *)attributes{
    self = [super init];
    _status = status;
    _attributes = attributes;
    return self;
}
@end
