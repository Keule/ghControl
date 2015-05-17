//
//  FMDataStore.h
//  babynames
//
//  Created by Thomas Wolters on 16/07/14.
//  Copyright (c) 2014 fluidmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDataStore : NSObject

-(id)loadFromUserDefaults:(NSString*)key;
-(void)clearAllPersistentData;
-(void)saveToUserDefaults:(NSObject*)object key:(NSString*)key;
@end
