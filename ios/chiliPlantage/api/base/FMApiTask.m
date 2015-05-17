//
//  FMApiTask.m
//  Algel
//
//  Created by Thomas Wolters on 19/02/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#include <sys/utsname.h>

#import "FMApiTask.h"
#import "FMCredentials.h"
#import "FMApiTaskResponse.h"
#import "FMJSONSerialization.h"
#import "FMAlertViewHelper.h"
#import "CHLManagerLayer.h"
#import "FMDataStore.h"

@interface FMApiTask()
    @property (nonatomic, strong) FMCredentials *credential;
    @property  (nonatomic, strong) NSDictionary *dictHeader;
    @property  (nonatomic, strong) NSDictionary *dictBody;
    @property  (nonatomic, assign) enum FMApiTaskHttpMethod httpMethod;
    @property(nonatomic, strong) NSURLConnection *connection;
    @property(nonatomic, strong) NSMutableData *responseData;
    @property(nonatomic, assign) long httpResonseCode;
    @property  (nonatomic, weak) id <FMApiTaskDelegate> delegate;
    @property  (nonatomic, strong) NSString* apiUrl;
@end

@implementation FMApiTask

-(NSString*)httpMethodToString:(enum FMApiTaskHttpMethod)method{
    switch (method){
        case FMApiTaskHttpMethodPost:
            return @"POST";
        case FMApiTaskHttpMethodPut:
            return @"PUT";
        case FMApiTaskHttpMethodGet:
            return @"GET";
    }
    return nil;
}

-(instancetype)initWithCredentials:(FMCredentials*)credentials headerAttributes:(NSDictionary *)headerAttributes bodyPayload:(NSDictionary *)bodyPayload delegate:(id <FMApiTaskDelegate>)delegate httpMethod:(enum FMApiTaskHttpMethod)httpMethod apiUrl:(NSString*)url{
    self = [super init];
    _credential = credentials;
    
//    //TMP PW FAKE
//    if ([FMApiManager sharedInstance].userIsRegistered){
//        Profile* profile = [FMApiManager sharedInstance].userProfile;
//        
//        _credential = [[FMCredentials alloc] initWithUsername:profile.email password:[FMDataStore sharedInstance].password type:FMCredentialsTypeLoginCBFull];
//    }

    _dictHeader = headerAttributes;
    _dictBody = bodyPayload;
    _delegate = delegate;
    _httpMethod = httpMethod;
    _apiUrl = url;
    NSLog (@"BODY DICT %@", _dictBody);
    return self;
}

- (NSString *)platformCode {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return platform;
}

- (void)execute{
    self.responseData = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_apiUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];

    [request setHTTPMethod:[self httpMethodToString:_httpMethod]];


    request = [self registerHeadAttributes:_dictHeader forRequest:request];


    if (_credential){
        request =[self registerCredentials:_credential forRequest:request];
    }

    if (_dictBody){
        request =[self registerBodyAttributes:_dictBody forRequest:request];
    }

    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (NSMutableURLRequest*) registerCredentials:(FMCredentials *)credential forRequest:(NSMutableURLRequest *)request {

    NSString *authString = [NSString stringWithFormat:@"%@:%@", credential.username, credential.password];
    NSData *plainData = [authString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];

    [request setValue:[NSString stringWithFormat:@"Basic %@",base64String] forHTTPHeaderField:@"Authorization"];
    return request;
}


-(NSMutableURLRequest*) registerHeadAttributes:(NSDictionary *)headerAttributes forRequest:(NSMutableURLRequest *)request {
    for (NSString* key in [headerAttributes allKeys]){
        NSString* value = [headerAttributes valueForKey:key];
        [request setValue:value forHTTPHeaderField:key];
    }

    //set ContentType
    NSString *contentType = @"application/json";
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];

    //setAppToken
    NSString* appToken = API_TOKEN;
    [request setValue:appToken forHTTPHeaderField:@"X-Api-Token"];

    //set Client-Uid
    NSString* deviceUUid = [[CHLManagerLayer sharedInstance] deviceUUID];
    if (deviceUUid){
        [request setValue:deviceUUid forHTTPHeaderField:@"X-Device-Uuid"];
    }
    
    //set device data
    [request setValue: [self platformCode] forHTTPHeaderField:@"X-Device-Model"];
    [request setValue: @"apple" forHTTPHeaderField:@"X-Device-Manufacturer"];
    
    //set os data
    [request setValue:@"ios" forHTTPHeaderField:@"X-OS"];
    [request setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"X-OS-Version"];
    
    //set app data
    [request setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"X-App-Version"];
    [request setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] forHTTPHeaderField:@"X-App-Version-Int"];

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    [request setValue:[NSString stringWithFormat:@"%f",window.bounds.size.height] forHTTPHeaderField:@"X-Device-Resolution-Height"];
    [request setValue:[NSString stringWithFormat:@"%f",window.bounds.size.width] forHTTPHeaderField:@"X-Device-Resolution-Width"];
    
    NSString* token = [CHLManagerLayer sharedInstance].notificationToken;
    if (token&&token.length>0){
        [request setValue:token forHTTPHeaderField:@"X-Notification-Token"];
    }
    return request;
}

-(NSMutableURLRequest*) registerBodyAttributes:(NSDictionary *)bodyAttributes forRequest:(NSMutableURLRequest *)request {
    request.HTTPBody = [self dictionaryToJsonData:bodyAttributes];
    return request;
}


-(NSData*)dictionaryToJsonData:(NSDictionary*)dictionary{
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
     return jsonData;
}

- (void)connection:(NSURLConnection *) LINT_SUPPRESS_UNUSED_ATTRIBUTE connection didReceiveResponse:(NSURLResponse *)response {
    //cleanUp
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    self.httpResonseCode = [httpResponse statusCode];
    self.responseData = nil;

            NSDictionary *headerFieldsDict = [httpResponse allHeaderFields];
    if (![[CHLManagerLayer sharedInstance] deviceUUID]){

        NSString *deviceUUID = headerFieldsDict [@"X-Device-Uuid"];
        [[CHLManagerLayer sharedInstance] setDeviceUUID: deviceUUID];
    }
    
    NSString* cookie = [httpResponse.allHeaderFields objectForKey:@"Set-Cookie"];
    if(cookie&&cookie.length >0){
        [[CHLManagerLayer sharedInstance] setCookie:cookie];
    }
    
}

- (void)connection:(NSURLConnection *) LINT_SUPPRESS_UNUSED_ATTRIBUTE connection  didReceiveData:(NSData *)data {
    if(self.responseData){
        [self.responseData appendData:data];
    }
    else{
        self.responseData = [[NSMutableData alloc] initWithData:data];
    }
}

- (void)connection:(NSURLConnection *) LINT_SUPPRESS_UNUSED_ATTRIBUTE connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    if (error && error.description) {
        NSLog(@"Connection failed: %@", error.description);
    }
    [_delegate task:self failedWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *) LINT_SUPPRESS_UNUSED_ATTRIBUTE connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lu characters", (unsigned long) [self.responseData length]);
//    NSLog(@"receiveData %@", _responseString);
    NSLog(@"FINAL HTTP Status %li", _httpResonseCode);
    NSError *error;
    if (_httpResonseCode == FMApiTaskResponseStatusSuccess||_httpResonseCode == FMApiTaskResponseStatusSuccessCreated) {
        NSDictionary *res = [FMJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&error];
        if(error != nil)
            NSLog(@"error parsing json %@", error);

        FMApiTaskResponse *apiResponse = [[FMApiTaskResponse alloc] initWithStatus:(enum FMApiTaskResponseStatus)_httpResonseCode attributes:res];
        [_delegate task:self didFinishWithResponse:apiResponse];
        
    }
    else if (_httpResonseCode == FMApiTaskResponseUnprocessableEntity||_httpResonseCode == FMApiTaskResponseForbidden){
        NSDictionary *res = [FMJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"Unprocessable Entity %@",res);
        [self showAlertWithResponseCode:_httpResonseCode data:self.responseData url:_apiUrl];
        [_delegate task:self didFinishWithResponse:[[FMApiTaskResponse alloc] initWithStatus:(int)_httpResonseCode attributes:res]];
    }
    else{
        [self showAlertWithResponseCode:_httpResonseCode data:self.responseData url:_apiUrl];
        [_delegate task:self didFinishWithResponse:[FMApiTaskResponse initFailTask] ];
    }
}

-(void)showAlertWithResponseCode:(long)code data:(NSData*)data url:(NSString*)url{
    if (DEBUG_MODE){
        NSString* bodyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        [[FMAlertViewHelper createAlertWithTitle:url message:[NSString stringWithFormat:@"HTTP status: %li\n%@", code, bodyString] buttonTitles:@[@"OK"]] show]  ;
    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *) LINT_SUPPRESS_UNUSED_ATTRIBUTE connection willCacheResponse:(NSCachedURLResponse *) LINT_SUPPRESS_UNUSED_ATTRIBUTE cachedResponse {
    return nil;
}
@end
