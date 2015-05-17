//
//  FMHttpTaskDownloadFile.m
//  Algel
//
//  Created by Thomas Wolters on 20/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import "FMHttpTaskDownloadFile.h"

@implementation FMHttpTaskDownloadFile{
    NSURLSessionDownloadTask * _downloadTask;
}
-(instancetype)initWithDownloadFileURL:(NSURL*)url withNotification:(NSString*)notification{
    self = [super init];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:nil];

    _downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * location, NSURLResponse *response, NSError *error){
        NSData *data = [NSData dataWithContentsOfURL:location];

        if (data){
            [_delegate taskFinishedWithData:data notification:notification];
        }
        else{
            [_delegate taskFinishedError:error notification:notification];
        }
    }];

    return self;
}

-(void)execute{
   [_downloadTask resume];
}


@end
