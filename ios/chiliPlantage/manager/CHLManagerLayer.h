
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "FMManagerLayer.h"

@interface CHLManagerLayer : FMManagerLayer
@property (nonatomic, strong) NSString* cookie;
@property (nonatomic, strong) NSString* deviceUUID;
@property (nonatomic, strong) NSString* notificationToken;

+(CHLManagerLayer*)sharedInstance;
-(void)downloadFileURL:(NSURL*)url withNotification:(NSString*)notification;
@end
