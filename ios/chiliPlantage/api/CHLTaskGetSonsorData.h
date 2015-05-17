//
//  CHLTaskGetSonsorData.h
//  chiliPlantage
//
//  Created by Thomas Wolters on 17/05/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "FMApiTask.h"


typedef void (^CHLTaskGetSonsorDataSuccessBlock)(NSArray* sensors);



@interface CHLTaskGetSonsorData : FMApiTask
-(instancetype)initCompletionBlock:(CHLTaskGetSonsorDataSuccessBlock)completionBlock failBlock:(FMApiTaskFailBlock)failBlock;
@end



