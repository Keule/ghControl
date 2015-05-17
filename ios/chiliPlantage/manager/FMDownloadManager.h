//
//  FMDownloadManager.h
//  Algel
//
//  Created by Thomas Wolters on 20/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDownloadManager : NSObject

-(void)downloadFileURL:(NSURL*)url withNotification:(NSString*)notification;
@end
