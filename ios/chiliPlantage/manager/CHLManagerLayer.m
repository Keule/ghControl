
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "CHLManagerLayer.h"
#import "FMDownloadManager.h"

@interface CHLManagerLayer()
@property (nonatomic, strong) FMDownloadManager* managerDownload;
@end

@implementation CHLManagerLayer


+(CHLManagerLayer*)sharedInstance {
    static CHLManagerLayer* sharedInstance;
    @synchronized(self)
    {
        if (!sharedInstance) sharedInstance = [[CHLManagerLayer alloc] init];
        return sharedInstance;
    }
}

-(FMDownloadManager*)managerDownload{
    if (!_managerDownload){
        _managerDownload = [FMDownloadManager new];
    }
    return _managerDownload;
}

-(void)downloadFileURL:(NSURL*)url withNotification:(NSString*)notification{
    [self.managerDownload downloadFileURL:url withNotification:notification];
}

@end
