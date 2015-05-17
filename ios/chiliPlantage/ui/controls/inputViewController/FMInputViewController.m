//
//  HLProspectNewViewController.m
//  herbalife
//
//  Created by Thomas Wolters on 28/08/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//
#import "FMInputViewController.h"
#import "FMInputView.h"
#import "FMInput.h"
#import "FMInputCellSingleValue.h"
#import "FMInputCellSwitch.h"
#import "FMInputDateViewController.h"
#import "FMInputCellObject.h"

#import "FMAlertViewHelper.h"
#import "FMInputNumberViewController.h"
#import "FMMailHelper.h"
#import "FMDateHelper.h"
#import "FMInputGroup.h"

#import "FMInputViewGroupHeader.h"
#import "FMNavigationController.h"
#import "CHLWorkFlowManager.h"

@interface FMInputViewController () <FMInputViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, FMInputCellDelegate, FMInputDateViewControllerDelegate, UIAlertViewDelegate, FMInputNumberViewController>
    @property (nonatomic, strong) FMInputView* viewInput;
@property (nonatomic, strong) NSArray* groups;
    @property (nonatomic, strong) NSString* titleAction;
    @property (nonatomic, strong) NSString* tag;
    @property (nonatomic, assign) BOOL showTopNavigation;
    @property (nonatomic, assign) BOOL validateCellsImmediately;

@property (nonatomic, assign) BOOL valueChanged;
@property (nonatomic, strong) FMMailHelper* mailHelper;
@property (nonatomic, assign) int columnCount;
@end

typedef NS_ENUM(NSUInteger, HLInputAlertViewType) {
HLInputAlertViewTypeAppointmentInvite = 1,
HLInputAlertViewTypeSaveInput = 2
};



@implementation FMInputViewController

-(instancetype)init{
    assert(@"DONT CALL!!");
    return nil;
}

-(void)userDidSelectNumber:(NSNumber*)number forInput:(FMInput*)input{
    self.valueChanged = YES;
    if (input.type == HLInputTypeMinutes){
        input.value = (NSObject*)number;
        [_viewInput.collectionView reloadData];
    }
}


-(instancetype)initWithGroups:(NSArray*)groups title:(NSString*)title actionTitle:(NSString*)actionTitle tag:(NSString*)tag payload:(NSObject*)payload showTopNavigation:(BOOL)showTopNavigation columCount:(int)columnCount{
	self = [super init];
	if (self) {
        _showTopNavigation = showTopNavigation;
		_groups = groups;
        _titleAction = actionTitle;
        _tag  = tag;
        _payloadObjectX = payload;
        _columnCount = columnCount;
        if(FM_IS_IPAD){
            _columnCount = MAX(_columnCount, 2);
        }
        self.title = title;
	}
	return self;
}

-(void)loadView {
    self.viewInput = [[FMInputView alloc] initForBackMove:NO title:self.title actionTitle:_titleAction showTopNavigation:_showTopNavigation];
	self.view = _viewInput;
}

-(void)viewDidLoad {
	[super viewDidLoad];

	_viewInput.delegateInputView = self;
    
	_viewInput.collectionView.delegate = self;
	_viewInput.collectionView.dataSource = self;
    
    [_viewInput.collectionView registerClass:[FMInputCellSingleValue class] forCellWithReuseIdentifier:CELL_INPUT_SINGLE_VALUE];
    [_viewInput.collectionView registerClass:[FMInputCellSwitch class] forCellWithReuseIdentifier:CELL_SWITCH];
    [_viewInput.collectionView registerClass:[FMInputCellObject class] forCellWithReuseIdentifier:CELL_OBJECT];
    [_viewInput.collectionView registerClass:[FMInputViewGroupHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELL_GRID_INPUT_GROUP_HEADER];
    
//        UIImage* imageBack;    
//    if (self.showBurgerButton){
//        imageBack = [[UIImage imageNamed:@"icon-topbar-burger"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    }
//    else{
//        imageBack = [[UIImage imageNamed:@"icon-topbar-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    }
//    UIBarButtonItem* bbi = [[UIBarButtonItem alloc] initWithImage:imageBack style:UIBarButtonItemStylePlain target:self action:@selector(actionBackPreparation:)];
//    bbi.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = bbi;
}

-(BOOL)checkAllRequiredValuesAreValid{
    self.validateCellsImmediately = YES;
    for (FMInputGroup* group in _groups){
        for (FMInput* input in group.inputs){
            if (input.required == YES){
                BOOL valid = [self checkValue:input.value forInput:input];
                if (valid == NO){
                    return NO;
                }
            }
        }
    }
    return  YES;
}



-(void)userDidSelectFinish {
    [self finishInput];
}

-(void)finishInput{
    //TODO: implement finish task
}

-(void)userDidSelectBack {
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)userDidChangeValue:(NSObject*)value key:(NSString*)key cell:(FMInputCell*)cell{
    self.valueChanged = YES;
    for (FMInputGroup* group in _groups){
        for(FMInput* input in group.inputs){
            if ([input.key isEqualToString:key]){
                [self setValue:value forInput:input inCell:cell];
                return;
            }
        }
    }
}

-(void)setValue:(NSObject*)value forInput:(FMInput*)input{
    switch (input.type) {
        case HLInputTypeString:
        case HLInputTypeEmail:
        case HLInputTypeDate:
        case HLInputTypeDateTime:
        case HLInputTypeMinutes:
        case HLInputTypeSwitch:
            input.value = value;
            break;
        case HLInputTypeFloat:
            input.value = @([[(NSString*)value stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue]);
            break;
        case HLInputTypeInt:{
            NSNumber* number = @([((NSString*)value) integerValue]);
            input.value = number;
        }
            break;
    }
}

-(void)setValue:(NSObject*)value forInput:(FMInput*)input inCell:(FMInputCell*)cell{
    if ([self checkValue:value forInput:input] == YES){
        if (cell.isMarkedAsNotValid == YES){
            cell.isMarkedAsNotValid = NO;
        }
        [self setValue:value forInput:input];
    }
}

-(BOOL) LINT_SUPPRESS_CYCLOMATIC_COMPLEXITY checkValue:(NSObject*)value forInput:(FMInput*)input{
    if (!(input.required == YES || input.valueMaximum || input.valueMinimum)){
        return YES;
    }

    switch (input.type) {
        case HLInputTypeDate:
        case HLInputTypeDateTime:
            if (!value && input.required){
                    return  NO;
            }
            break;
        case HLInputTypeString:
        case HLInputTypeEmail:{
            NSString* string = (NSString*)value;
                if ((!string||string.length == 0) && input.required){
                        return  NO;
                }
            }
            break;
        case HLInputTypeMinutes:
        case HLInputTypeInt:
        case HLInputTypeFloat:
            return [self validateNumericInput:input value:(NSNumber*)value];
        case HLInputTypeSwitch:
            break;
    }
    return YES;
}

-(BOOL)validateNumericInput:(FMInput*)input value:(NSNumber*)numberValue{

    if (numberValue){
        if (numberValue.floatValue == 0 && input.required){
            return  NO;
        }
        if (input.valueMinimum){
            NSNumber* minimum = (NSNumber*)input.valueMinimum;
            if (numberValue.floatValue < minimum.floatValue){
                return NO;
            }
        }
        if (input.valueMaximum){
            NSNumber* maximum = (NSNumber*)input.valueMaximum;
            if (numberValue.floatValue > maximum.floatValue){
                return NO;
            }
        }
    }
    else{
        if (input.required){
            return  NO;
        }
    }
    return YES;
}

-(void)userDidFinishEditInCell:(FMInputCell*)cell input:(FMInput*)input value:(NSObject*)value{
    //TODO: check if cell is Valid
    if ([self checkValue:value forInput:input] == NO){
        cell.isMarkedAsNotValid = YES;
    }
}

#pragma mark HLInputDateViewControllerDelegate
-(void)userDidSelectDate:(NSDate*)date{
    self.valueChanged = YES;
    for (FMInputGroup* group in _groups){
        for (FMInput* input in group.inputs){
            if (input.type == HLInputTypeDate||input.type == HLInputTypeDateTime){
                input.value = date;
                [_viewInput.collectionView reloadData];
            }
        }
    }
}



-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark collectionView
- (NSInteger)collectionView:(UICollectionView *) LINT_SUPPRESS_UNUSED_ATTRIBUTE collectionView numberOfItemsInSection:(NSInteger)section{
    FMInputGroup* group = _groups[section];
    return [group.inputs count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *) LINT_SUPPRESS_UNUSED_ATTRIBUTE collectionView{
    return [_groups count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *) LINT_SUPPRESS_UNUSED_ATTRIBUTE collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FMInputCell* cell;
    
    FMInput* input = [self inputForIndexPath:indexPath];
    switch (input.type) {
        case HLInputTypeString:
        case HLInputTypeFloat:
        case HLInputTypeEmail:
        case HLInputTypeInt:{
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INPUT_SINGLE_VALUE forIndexPath:indexPath];
        }
            break;
        case HLInputTypeSwitch:{
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_SWITCH forIndexPath:indexPath];
        }
            break;
        case HLInputTypeDateTime:
        case HLInputTypeMinutes:
        case HLInputTypeDate:{
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_OBJECT forIndexPath:indexPath];
        }
            break;
    }
    [cell setInputDefinition:input];
    
    [self checkForValidationMark:input forCell:cell];
    
    cell.delegate = self;
    return cell;
}

-(void)checkForValidationMark:(FMInput*)input forCell:(FMInputCell*)cell{
    if (_validateCellsImmediately == YES && [self checkValue:input.value forInput:input] == NO){
        cell.isMarkedAsNotValid = YES;
    }
}

-(FMInput*)inputForIndexPath:(NSIndexPath*)indexPath{
    FMInputGroup* group = _groups[indexPath.section];
    FMInput* input = [group.inputs objectAtIndex:indexPath.row];
    return input;
}
- (CGSize) LINT_SUPPRESS_CYCLOMATIC_COMPLEXITY collectionView:(UICollectionView *) LINT_SUPPRESS_UNUSED_ATTRIBUTE collectionView layout:(UICollectionViewLayout*) LINT_SUPPRESS_UNUSED_ATTRIBUTE collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float height = 0;
    float minWidth = 0;
    
    FMInput* input = [self inputForIndexPath:indexPath];
    switch (input.type) {
        case HLInputTypeString:
        case HLInputTypeFloat:
        case HLInputTypeEmail:
        case HLInputTypeInt:{
            minWidth = [FMInputCellSingleValue minimumWidthForTitle:input.placeholder invalidString:input.invalidString  width:self.view.frame.size.width];
            
            height = CELL_INPUT_HEIGHT;
        }
            break;
        case HLInputTypeSwitch:{
            height = CELL_SWITCH_HEIGHT;
        }
            break;
        case HLInputTypeDateTime:
        case HLInputTypeMinutes:
        case HLInputTypeDate:{
            height = CELL_OBJECT_HEIGHT;
        }
            break;
    }
    CGSize size;
    float columWidth = ((self.view.frame.size.width))/_columnCount;
    
    if (minWidth == 0 || _columnCount == 1 || minWidth < columWidth){
        return size = (CGSize){columWidth,height};
    }

    NSLog(@"columwidth %1.2f minWidth %1.2f", columWidth, minWidth);
    for (int i = 1; i<=_columnCount;i++){
        if (minWidth < i*columWidth){
            return size = (CGSize){columWidth*i,height};
        }
    }
    return size = (CGSize){self.view.frame.size.width,height};


}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    FMInput* input = [self inputForIndexPath:indexPath];
    switch (input.type) {
        case HLInputTypeString:
        case HLInputTypeFloat:
        case HLInputTypeEmail:
        case HLInputTypeInt:
        case HLInputTypeSwitch:
            return;
        case HLInputTypeDate:{
            FMInputDateViewController* inputDateViewController = [[FMInputDateViewController alloc] initWithDate:(NSDate*)input.value  withTime:NO title:input.placeholder];
            inputDateViewController.delegateInputDateView = self;
            [self.navigationController pushViewController:inputDateViewController animated:YES];
        }
            break;
        case HLInputTypeDateTime:{
            FMInputDateViewController* inputDateViewController = [[FMInputDateViewController alloc] initWithDate:(NSDate*)input.value withTime:YES title:input.placeholder];
            inputDateViewController.delegateInputDateView = self;
            [self.navigationController pushViewController:inputDateViewController animated:YES];
        }
            break;

        case HLInputTypeMinutes:{
            FMInputNumberViewController* inputNumberViewController = [[FMInputNumberViewController alloc] initWithNumber:(NSNumber*)input.value  range:(NSRange){0,240} stepping:@5 title:@"Minutes" input:input];
            inputNumberViewController.delegateInputNumberView = self;
            [self.navigationController pushViewController:inputNumberViewController animated:YES];
        }
            break;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        FMInputViewGroupHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELL_GRID_INPUT_GROUP_HEADER forIndexPath:indexPath];
        FMInputGroup* group = _groups[indexPath.section];
        [headerView setTitle:group.title];
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *) LINT_SUPPRESS_UNUSED_ATTRIBUTE collectionView layout:(UICollectionViewLayout*) LINT_SUPPRESS_UNUSED_ATTRIBUTE collectionViewLayout referenceSizeForHeaderInSection:(NSInteger) LINT_SUPPRESS_UNUSED_ATTRIBUTE section{
    if (_groups && _groups.count > 1){
        return (CGSize){self.view.bounds.size.width,44};
    }
    return CGSizeZero;
}
@end
