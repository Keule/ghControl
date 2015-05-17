//
//  FMLazyLoadingImageView.m
//  Algel
//
//  Created by Thomas Wolters on 20/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//
#import "FMLazyLoadingImageView.h"
#import "FMUUIDGenerator.h"
#import "FMImageHelper.h"
#import "CHLManagerLayer.h"
#import "FMICloudHelper.h"

@interface FMLazyLoadingImageView()
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL* imageURL;
@property (nonatomic, strong) NSString* filePath;
@end

@implementation FMLazyLoadingImageView{
    UIActivityIndicatorView* _viewActivityIndicator;
}

- (id)init{
    self = [super init];
    if (self) {
        self.image = [FMImageHelper imageWithColor:[UIColor whiteColor]];
        _viewActivityIndicator = [UIActivityIndicatorView new];
        _viewActivityIndicator.color = COLOR_APP_TINT_COLOR;
        [self addSubview:_viewActivityIndicator];

        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setImageUrl:(NSURL*)imageURL{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.image = nil;
    [self setNeedsLayout];
    if (imageURL){
        [_viewActivityIndicator startAnimating];
        
        //TODO check if image here
        NSString* theFileName = [imageURL.description lastPathComponent];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,    NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];

        self.filePath = [documentsDirectory stringByAppendingPathComponent:theFileName ];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:_filePath]){
            self.url = imageURL;
            
            NSString *notificationString = [FMUUIDGenerator uuidString];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNewImage:) name:notificationString object:nil];
            [[CHLManagerLayer sharedInstance] downloadFileURL:imageURL withNotification:notificationString];

        }
        else{
            [[NSNotificationCenter defaultCenter] removeObserver:self];

            
            
            self.image = [self imageForFilePath:_filePath];
            [self removeActivityIndicator];
            
            [self returnSizeForImage:self.image];
            self.filePath = nil;
        }
    }
}



-(void)returnSizeForImage:(UIImage*)image{
    [_delegate loadedWithSize:image.size];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _viewActivityIndicator.frame = (CGRect){0,0,44,44};

    _viewActivityIndicator.center = (CGPoint){self.bounds.size.width/2,self.bounds.size.height/2};
}

-(void)actionNewImage:(NSNotification*)notification{
    NSData* data = [notification.userInfo objectForKey:@"data"];
    if (data){

        

        BOOL success = [data writeToFile:_filePath atomically:NO];
        if (success == NO){
            NSLog(@"fuck");
        }
        else{
            [FMICloudHelper addSkipBackupiCloudAttributeToItemAtURL:[NSURL URLWithString:_filePath]];
        }

        UIImage* image = [self imageForFilePath:_filePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setImage:image];
            self.filePath = nil;
            [self removeActivityIndicator];
            [self returnSizeForImage:image];
        });
    }
}

-(void)removeActivityIndicator{
    [_viewActivityIndicator stopAnimating];
    [_viewActivityIndicator removeFromSuperview];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(UIImage*)imageForFilePath:(NSString*)filePath{
    UIImage* image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}



@end
