//
//  HLProspectNewView.h
//  herbalife
//
//  Created by Thomas Wolters on 28/08/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "CHLView.h"
#import "TPKeyboardAvoidingCollectionView.h"
@protocol FMInputViewDelegate
-(void)userDidSelectFinish;
-(void)userDidSelectBack;
-(BOOL)checkAllRequiredValuesAreValid;
@end

@interface FMInputView : CHLView
@property (nonatomic, strong) TPKeyboardAvoidingCollectionView* collectionView;
@property (nonatomic, weak) id <FMInputViewDelegate> delegateInputView;
-(id)initForBackMove:(BOOL)backMove title:(NSString*)title actionTitle:(NSString*)actionTitle showTopNavigation:(BOOL)showTopNavigation;
@end
