//
//  HLInputCell.h
//  herbalife
//
//  Created by Thomas Wolters on 18/11/14.
//  Copyright (c) 2014 herbalife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMInput.h"
@class FMInputCell;
@protocol FMInputCellDelegate

-(void)userDidChangeValue:(NSObject*)value key:(NSString*)key cell:(FMInputCell*)cell;
-(void)userDidFinishEditInCell:(FMInputCell*)cell input:(FMInput*)input value:(NSObject*)value;

@end

@interface FMInputCell : UICollectionViewCell
@property (nonatomic, weak) id <FMInputCellDelegate> delegate;
@property (nonatomic, strong) FMInput* input;
@property (nonatomic, assign) BOOL isMarkedAsNotValid;
@property (nonatomic, strong) UILabel* labelValidation;


-(void)setInputDefinition:(FMInput*)input;

@end
