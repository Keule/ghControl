//
//  HLProspectNewView.m
//  herbalife
//
//  Created by Thomas Wolters on 28/08/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import "FMInputView.h"


@interface FMInputView ()
@property (nonatomic, strong) UIView* viewTop;
@property (nonatomic, strong) UILabel* labelAddUser;
@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UIView* viewBottemButton;
@property (nonatomic, assign) BOOL isBackMove;
@end

#define ICON_DIMENSION 44

@implementation FMInputView
-(id)initForBackMove:(BOOL) LINT_SUPPRESS_UNUSED_ATTRIBUTE backMove{
    NSAssert(NO,@"never call!");
    return nil;
}

-(id)initForBackMove:(BOOL)backMove title:(NSString*)title actionTitle:(NSString*)actionTitle showTopNavigation:(BOOL)showTopNavigation {
	self = [super init];
	if (!self) {
        return nil;
	}
    self.backgroundColor = [UIColor whiteColor];
    if (showTopNavigation){
        _viewTop = [[UIView alloc] init];
        _viewTop.backgroundColor = COLOR_APP_TINT_COLOR;
        
        _isBackMove = backMove;
        
        _labelTitle = [CHLControlsGenerator labelForText:title];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.layer.opacity = 0;
        [_viewTop addSubview:_labelTitle];
        
        [self addSubview:_viewTop];
    }
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[TPKeyboardAvoidingCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = COLOR_BACKGROUND;
    [self addSubview:_collectionView];
    
    _viewBottemButton = [UIView new];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionDidSelectAddUser:)];
    [_viewBottemButton addGestureRecognizer:tapGesture];
    _viewBottemButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_viewBottemButton];
    
    
    _labelAddUser = [CHLControlsGenerator labelForText:actionTitle];
    _labelAddUser.textAlignment = NSTextAlignmentRight;
    _labelAddUser.layer.opacity = 0;
    [_viewBottemButton addSubview:_labelAddUser];
	return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
	CGRect frame = (CGRect) {0, 0, self.bounds.size.width, self.bounds.size.height - HEIGHT_BOTTOM_BAR};
		_viewTop.frame = frame;


		float nextX = LAYOUT_BORDER_DEFAULT;
		_labelTitle.frame = (CGRect) {nextX, LAYOUT_BORDER_DEFAULT + 10, self.bounds.size.width - nextX - ICON_DIMENSION - 2 * LAYOUT_BORDER_DEFAULT, 25};

    float nextY = 0;
    if (_labelTitle){
        nextY = _labelTitle.pointRightBottom.y + LAYOUT_BORDER_DEFAULT;
    }

		frame = (CGRect) {0, nextY, self.bounds.size.width, self.bounds.size.height - nextY-HEIGHT_BOTTOM_BAR};
		_collectionView.frame = frame;
        _viewBottemButton.frame = (CGRect){0,[_collectionView pointRightBottom].y,self.bounds.size.width,HEIGHT_BOTTOM_BAR};


        
        _labelAddUser.frame = (CGRect) {LAYOUT_BORDER_DEFAULT,LAYOUT_BORDER_DEFAULT,LAYOUT_BORDER_DEFAULT*1.5f,44};

}

-(void)animateIn {
	[_labelTitle animateProperty:@"opacity" from:@0 to:@1 withDuration:1 delay:0.3 customTimingFunction:CustomTimingFunctionQuintOut competion:nil];
	[_labelAddUser animateProperty:@"opacity" from:@0 to:@1 withDuration:1 delay:0.3 customTimingFunction:CustomTimingFunctionQuintOut competion:nil];

	if (_isBackMove) {
		[_viewTop animateRectFrom:_viewTop.frame to:(CGRect) {0, 0, self.bounds.size.width, self.bounds.size.height - HEIGHT_BOTTOM_BAR} withDuration:0.5 delay:0 customTimingFunction:CustomTimingFunctionLinear competion:nil];
	}
}

-(void)animateBackIn {
	[self animateIn];
}

-(void)animateOut {
	[self animateOutWithBack:NO];
}

-(void)animateOutWithBack:(BOOL)back {

	float duration = 0.35;

	[_collectionView animateProperty:@"opacity" from:@(_collectionView.layer.opacity) to:@0 withDuration:duration delay:0 customTimingFunction:CustomTimingFunctionQuintOut competion: ^{
//        self.state = HLViewStateOut;
	    if (back) {
            [_delegateInputView userDidSelectBack];
		}
	    else {
	        [_delegateInputView userDidSelectFinish];
		}

	}];

	[_labelTitle animateProperty:@"opacity" from:@1 to:@0 withDuration:duration delay:0 customTimingFunction:CustomTimingFunctionCircOut competion:nil];
    [_labelAddUser animateProperty:@"opacity" from:@1 to:@0 withDuration:duration delay:0 customTimingFunction:CustomTimingFunctionCircOut competion:nil];
    
	if (!back) {
		[_viewTop animateRectFrom:_viewTop.frame to:self.bounds withDuration:duration delay:0 customTimingFunction:CustomTimingFunctionQuintInOut competion:nil];
	}
}

-(void)actionDidSelectAddUser:(id)sender {
	UITapGestureRecognizer* tapGesture = (UITapGestureRecognizer*)sender;

	if ([tapGesture locationInView:self].y > _viewTop.pointRightBottom.y) {
        if ([_delegateInputView checkAllRequiredValuesAreValid] == YES){
            [self animateOut];
        }
        else{
            [_collectionView reloadData];
        }
	}
}

-(void)animateBackOut {
	[self animateOutWithBack:YES];
}

-(void)actionBack:(id) LINT_SUPPRESS_UNUSED_ATTRIBUTE sender {
	[self animateBackOut];
}

@end
