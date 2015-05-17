//
//  FMLazyLoadingImageView.h
//  Algel
//
//  Created by Thomas Wolters on 20/01/14.
//  Copyright (c) 2014 Fluidmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  FMLazyLoadingImageViewDelegate
-(void)loadedWithSize:(CGSize)size;
@end

@interface FMLazyLoadingImageView : UIImageView
@property (nonatomic, weak) id <FMLazyLoadingImageViewDelegate> delegate;
-(void)removeNotification;

-(void)setImageUrl:(NSURL*)imageURL;



@end
