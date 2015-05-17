//
//  HLInputNumberViewController.m
//  herbalife
//
//  Created by Thomas Wolters on 30/01/15.
//  Copyright (c) 2015 herbalife. All rights reserved.
//

#import "FMInputNumberViewController.h"
#import "FMInputNumberView.h"

@interface FMInputNumberViewController () <FMInputNumberViewDelegate>
@property (nonatomic, strong) NSNumber* number;
@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) NSNumber* stepping;
@property (nonatomic, strong) FMInputNumberView* viewInputNumber;
@property (nonatomic, strong) FMInput* input;

@end

@implementation FMInputNumberViewController

-(instancetype)initWithNumber:(NSNumber*)number range:(NSRange)range stepping:(NSNumber*)stepping title:(NSString*)title input:(FMInput*)input{
    self = [super init];
    _number = number;
    _input = input;
    _range = range;
    _stepping = stepping;
    self.title = title;
    return self;
}

-(void)loadView{
    self.viewInputNumber = [[FMInputNumberView alloc] initWithNumber:_number range:_range stepping:_stepping title:self.title];
    self.view = _viewInputNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewInputNumber.delegateNumberInput = self;
}

-(void)userDidFinishWithNumber:(NSNumber*)number{
    [self.delegateInputNumberView userDidSelectNumber:number forInput:_input];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_viewInputNumber selectPreselectedRow];
}

@end
