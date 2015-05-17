//
//  FMHttpTaskDownloadFile.h
//  Algel
//
//  Created by Thomas Wolters on 20/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol FMHttpTaskDownloadImageDelegate
-(void)taskFinishedWithData:(NSData*)data notification:(NSString*)notification;
-(void)taskFinishedError:(NSError*)error notification:(NSString*)notification;
@end

@interface FMHttpTaskDownloadFile : NSObject
@property (nonatomic, strong) id <FMHttpTaskDownloadImageDelegate> delegate;
-(instancetype)initWithDownloadFileURL:(NSURL*)url withNotification:(NSString*)notification;
-(void)execute;
@end
