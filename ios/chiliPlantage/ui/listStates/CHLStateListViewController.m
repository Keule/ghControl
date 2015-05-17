//
//  CHLStateListViewController.m
//  chiliPlantage
//
//  Created by Thomas Wolters on 17/05/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "CHLStateListViewController.h"
#import "CHLStateListView.h"
#import "CHLStateCell.h"
@interface CHLStateListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) CHLStateListView* viewListState;
@property (nonatomic, strong) NSArray* states;
@end

@implementation CHLStateListViewController

-(instancetype)initWithStates:(NSArray*)states{
    self = [super init];
    _states = states;
    return self;
}

-(void)loadView{
    self.viewListState = [CHLStateListView new];
    self.view = self.viewListState;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewListState.tableView.delegate = self;
    self.viewListState.tableView.dataSource = self;
    [self.viewListState.tableView registerClass:[CHLStateCell class] forCellReuseIdentifier:CELL_STATE];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_states count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHLStateCell* cell = [tableView dequeueReusableCellWithIdentifier:CELL_STATE];
    NSDictionary* dict = _states[indexPath.row];

    cell.textLabel.text = dict[@"createdAt"];
    cell.detailTextLabel.text = dict[@"createdAt"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_STATE_HEIGHT;
}

@end
