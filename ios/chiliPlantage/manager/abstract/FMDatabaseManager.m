////
////  FMDatabaseManager.m
////  babynames
////
////  Created by Thomas Wolters on 25/07/14.
////  Copyright (c) 2014 fluidmobile. All rights reserved.
////
//
//#import "FMDatabaseManager.h"
//#import "BNMappingHelper.h"
//#import "FMVibrationHelper.h"
//#import "FMInfoPopOverViewController.h"
//#import "FMSystemSoundHelper.h"
//
//@interface FMDatabaseManager() <FMRestPostTaskDelegate, FMSynchronisationTaskDelegate>
//@property (nonatomic, strong) FMSynchronisationTask* syncTask;
//@property (nonatomic, strong) FMRestPostTask* postTask;
//@property (nonatomic, strong) RKObjectManager* objectManager;
//@property (nonatomic, strong) FMInfoPopOverViewController* popOverVC;
//@end
//
//@implementation FMDatabaseManager
//
//
//-(void)setupCoreDataWithModelName:(NSString*)modelName{
//    //CoreData
//    #define SEED_DB_NAME @"RKSeedDatabase"
//    
//    if (!(modelName&& modelName.length >0)){
//        assert(@"Modelname not set!");
//    }
//
//    NSError *error = nil;
//    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:modelName ofType:@"momd"]];
//    // NOTE: Due to an iOS 5 bug, the managed object model returned is immutable.
//    NSManagedObjectModel* managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
//    _managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
//    [_managedObjectStore createPersistentStoreCoordinator];
//    
//    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", modelName]];
//    NSString *seedPath = [[NSBundle mainBundle] pathForResource:SEED_DB_NAME ofType:@"sqlite"];
//    #ifdef RESTKIT_GENERATE_SEED_DB
//        seedPath = nil;
//    #endif
//    
//    NSPersistentStore *persistentStore = [_managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
//    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
//    
//    RKValueTransformer *stringToDateTransformation = [RKBlockValueTransformer valueTransformerWithValidationBlock:^BOOL(__unsafe_unretained Class sourceClass, __unsafe_unretained Class destinationClass) {
//        // We transform a `NSString` into another `NSString`
//        return ([sourceClass isSubclassOfClass:[NSString class]] && [destinationClass isSubclassOfClass:[NSDate class]]);
//    } transformationBlock:^BOOL(id inputValue, __autoreleasing id *outputValue, Class outputValueClass, NSError *__autoreleasing *error) {
//        // Validate the input and output
//        RKValueTransformerTestInputValueIsKindOfClass(inputValue, [NSString class], error);
//        RKValueTransformerTestOutputValueClassIsSubclassOfClass(outputValueClass, [NSDate class], error);
//        
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:DATE_FORMAT_STRING];
//        NSDate *date = [dateFormat dateFromString:inputValue];
//        // Perform the transformation
//        *outputValue = date;
//        return YES;
//    }];
//    
//    [[RKValueTransformer defaultValueTransformer] addValueTransformer:stringToDateTransformation];
//    
//    RKValueTransformer *DateToStringTransformation = [RKBlockValueTransformer valueTransformerWithValidationBlock:^BOOL(__unsafe_unretained Class sourceClass, __unsafe_unretained Class destinationClass) {
//        // We transform a `NSString` into another `NSString`
//        return ([sourceClass isSubclassOfClass:[NSDate class]] && [destinationClass isSubclassOfClass:[NSString class]]);
//    } transformationBlock:^BOOL(id inputValue, __autoreleasing id *outputValue, Class outputValueClass, NSError *__autoreleasing *error) {
//        // Validate the input and output
//        RKValueTransformerTestInputValueIsKindOfClass(inputValue, [NSString class], error);
//        RKValueTransformerTestOutputValueClassIsSubclassOfClass(outputValueClass, [NSDate class], error);
//        
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:DATE_FORMAT_STRING];
//        
//        *outputValue = [dateFormat stringFromDate:inputValue];
//        return YES;
//    }];
//    
//    [[RKValueTransformer defaultValueTransformer] addValueTransformer:DateToStringTransformation];
//    //Logging
//    if (DEBUG_MODE){
//        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
//        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
//    }
//    
//    // Create the managed object contexts
//    [_managedObjectStore createManagedObjectContexts];
//    _managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:_managedObjectStore.persistentStoreManagedObjectContext];
//    
//    //      RKManagedObjectStore *managedObjectStore = [RKManagedObjectStore defaultStore];
//    NSManagedObjectContext* context = [_managedObjectStore mainQueueManagedObjectContext];
//    _managedObjectContext = context;
//}
//
//-(void)extremSave{
//    NSManagedObjectContext* context = self.managedObjectContext;
//    if (!context) {
//        NSLog(@"NO CONTEXT!");
//        return;
//    }
//    
//    NSError * error;
//    BOOL success = [context save:&error];
//    if (error || !success) {
//        NSLog(@"success: %@ - error: %@", success ? @"true" : @"false", error);
//    }
//    
//    [context performSelectorOnMainThread:@selector(save:) withObject:nil waitUntilDone:YES];
//    [context performSelector:@selector(save:) withObject:nil afterDelay:1.0];
//    [context setStalenessInterval:6.0];
//    while (context) {
//        [context performBlock:^(){
//            NSError * error;
//            bool success =  [context save:&error];
//            if (error || !success)
//                NSLog(@"success: %@ - error: %@", success ? @"true" : @"false", error);
//            
//        }];
//        context = context.parentContext;
//    }
//    NSLog(@"successful save!");
//}
//
//-(void)updateMappings:(NSMutableArray*)mappings{
//    _syncTask = [[FMSynchronisationTask alloc] initWithMappings:mappings finishSuccessNotification:NOTIFICATION_CHILD_UPDATE];
//    _syncTask.delegate = self;
//    [_syncTask execute];
//}
//
//-(void)uploadObject:(id)object withMappingDict:(NSDictionary*)mappingDict class:(Class)class postType:(enum FMPostTaskType)type objectID:(long)objectID notificationSuccess:(NSString*)notificiationSuccess notificationFail:(NSString*)notificationFail{
//    NSString* urlExtension = [mappingDict valueForKey:KEY_URL_EXTENSION];
//    if (type == FMPostTaskTypePatch||type == FMPostTaskTypeDelete){
//        urlExtension = [NSString stringWithFormat:@"%@/%li.json",  [mappingDict valueForKey:KEY_URL_EXTENSION_PATCH], objectID];
//    }
//    _postTask = [[FMRestPostTask alloc] initWith:[mappingDict valueForKey:KEY_MAPPING] url:[NSURL URLWithString:API_URL_FLUIDMOBILE_BACKEND] object:object type:type class:class urlExtension:urlExtension jsonRootKeyPath:[mappingDict valueForKey:KEY_JSON_KEY_PASS] notificationSuccess:notificiationSuccess notificationFail:notificationFail];
//    _postTask.delegate = self;
//    [_postTask execute];
//}
//
//-(void)putObject:(id)object withMappingDict:(NSDictionary*)mappingDict class:(Class)class objectID:(long)objectID  notificationSuccess:(NSString*)notificiationSuccess notificationFail:(NSString*)notificationFail{
//    [self uploadObject:object withMappingDict:mappingDict class:class postType:FMPostTaskTypePatch objectID:objectID notificationSuccess:notificiationSuccess notificationFail:notificationFail];
//}
//
//-(void)postObject:(id)object withMappingDict:(NSDictionary*)mappingDict class:(Class)class notificationSuccess:(NSString*)notificiationSuccess notificationFail:(NSString*)notificationFail{
//    [self uploadObject:object withMappingDict:mappingDict class:class postType:FMPostTaskTypePost objectID:0 notificationSuccess:notificiationSuccess notificationFail:notificationFail];
//}
//
//#pragma mark RestPostDelegate
//-(void)taskFinishedSuccessful{
//    [self extremSave];
//    if (DEBUG_MODE){
//        if (FM_IS_IPAD){
//            [FMSystemSoundHelper playSound];
//
//        }
//        else{
//            [FMSystemSoundHelper playSound];
////            [FMVibrationHelper vibrate];
//        }
//
////        _popOverVC = [[FMInfoPopOverViewController alloc] initWithTitle:@"ok" information:@"saved" seconds:0.3];
//
//        [_popOverVC show];
//    }
//}
//-(void)taskFinishedWithError:(NSError*)error{
//    if (DEBUG_MODE){
//        _popOverVC = [[FMInfoPopOverViewController alloc] initWithTitle:@"ok" information:error.description closeButton:@"OK"];
//        _popOverVC.showShareOption = YES;
//        [_popOverVC show];
//    }
//}
//
//#pragma mark SyncTaskDelegate
//-(void)syncTaskFinishedWithSuccess{
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DATABASE_UPDATED object:nil];
//}
//
//-(void)syncTaskFinishedWithError:(NSError*)error{
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DATABASE_UPDATED object:nil];
//}
//
//-(void)createSeedDB{
//    assert(@"DO NOT CALL DIRECT!!");
////    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"babynames" ofType:@"momd"]];
////    // NOTE: Due to an iOS 5 bug, the managed object model returned is immutable.
////    NSManagedObjectModel* managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
////    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
////    NSError *error = nil;
////    BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error);
////    if (! success) {
////        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
////    }
////    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"StoreXYZ.sqlite"];
////    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:@{ @"journal_mode": @"DELETE"} error:&error];
////    if (! persistentStore) {
////        RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
////    }
////    [managedObjectStore createManagedObjectContexts];
////    
////   RKEntityMapping* originMapping =    [[BNMappingHelper originMappingWithObjectStore:managedObjectStore] objectForKey:KEY_MAPPING];
////    
////    RKEntityMapping* firstNameMapping =    [[BNMappingHelper firstNameMappingWithObjectStore:managedObjectStore] objectForKey:KEY_MAPPING];
////    
////    
////    NSString *seedPath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"RKSeedDatabase.sqlite"];
////    RKManagedObjectImporter *importer = [[RKManagedObjectImporter alloc] initWithManagedObjectModel:managedObjectStore.managedObjectModel storePath:seedPath];
////    
////    // Import the files "articles.json" from the Main Bundle using our RKEntityMapping
////    // JSON looks like {"articles": [ {"title": "Article 1", "body": "Text", "author": "Blake" ]}
////
////
////    long count = [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"origins" ofType:@"json"]
////                              withMapping:originMapping
////                                  keyPath:nil
////                                    error:&error];
////    
////
////    count = [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"first_names" ofType:@"json"]
////                                          withMapping:firstNameMapping
////                                              keyPath:nil
////                                                error:&error];
////
////    success = [importer finishImporting:&error];
////    if (success) {
////        [importer logSeedingInfo];
////    }
//}
//
//
//
//-(NSArray*)getElementsForEntityDescription:(NSString*)entityDescriptionString orderBy:(NSString*)orderBy predicate:(NSPredicate*)predicate{
//    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityDescriptionString inManagedObjectContext:self.managedObjectContext];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDescription];
//    
//    if (orderBy&&orderBy.length>0){
//        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:orderBy ascending:YES];
//        [request setSortDescriptors:@[sortDescriptor]];
//    }
//    
//    if (predicate){
//        [request setPredicate:predicate];
//    }
//    
//    NSError *error;
//    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
//    return array;
//}
//
//-(void) flushDatabase{
//    NSError* error;
//    BOOL result =  [_managedObjectStore resetPersistentStores:&error];
//    if (result){
//
//    }
//    [self extremSave];
//}
//
//@end
