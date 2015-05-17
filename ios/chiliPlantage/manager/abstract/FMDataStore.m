//
//  FMDataStore.m
//  babynames
//
//  Created by Thomas Wolters on 16/07/14.
//  Copyright (c) 2014 fluidmobile. All rights reserved.
//

#import "FMDataStore.h"

@implementation FMDataStore


-(void)saveToUserDefaults:(NSObject*)object key:(NSString*)key{
    if (object){
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    }
    else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(id)loadFromUserDefaults:(NSString*)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

-(void)clearAllPersistentData{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
