//
//  CHLTaskGetConfig.h
//  chiliPlantage
//
//  Created by Thomas Wolters on 17/05/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "FMApiTask.h"




typedef void (^CHLTaskGetConfigSuccessBlock)(NSDictionary* settings);



@interface CHLTaskGetConfig : FMApiTask
-(instancetype)initCompletionBlock:(CHLTaskGetConfigSuccessBlock)completionBlock failBlock:(FMApiTaskFailBlock)failBlock;
@end



