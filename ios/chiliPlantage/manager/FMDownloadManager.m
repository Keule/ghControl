//
//  FMDownloadManager.m
//  Algel
//
//  Created by Thomas Wolters on 20/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import "FMDownloadManager.h"
#import "FMHttpTaskDownloadFile.h"


@interface FMDownloadManager() <FMHttpTaskDownloadImageDelegate>
@property (nonatomic, strong) NSMutableDictionary* tasks;
@end
@implementation FMDownloadManager
-(void)downloadFileURL:(NSURL*)url withNotification:(NSString*)notification{
    FMHttpTaskDownloadFile* taskDownload = [[FMHttpTaskDownloadFile alloc] initWithDownloadFileURL:url withNotification:notification];
    [self.tasks setObject:taskDownload forKey:notification];
    taskDownload.delegate = self;
    [taskDownload execute];
}

-(NSMutableDictionary *)tasks{
    if (!_tasks){
        _tasks = [@{} mutableCopy];
    }
    return _tasks;
}

-(void)taskFinishedWithData:(NSData*)data notification:(NSString*)notification{
    [_tasks removeObjectForKey:notification];
    NSLog (@"fertig");
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil userInfo:@{@"data":data}];
}

-(void)taskFinishedError:(NSError*) LINT_SUPPRESS_UNUSED_ATTRIBUTE error notification:(NSString*)notification{
    [_tasks removeObjectForKey:notification];
//    NSDictionary* userInfo;
//    if (error){
//        userInfo = @{@"error":error};
//    }
   // [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil userInfo:userInfo];
}
@end
