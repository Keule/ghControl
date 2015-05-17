//
//  CHLDebugViewController.m
//  chiliPlantage
//
//  Created by Thomas Wolters on 17/05/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "CHLDebugViewController.h"
#import "CHLDebugView.h"
#import "CHLSettingsListViewController.h"
#import "CHLStateListViewController.h"
#import "CHLTaskGetConfig.h"
#import "CHLTaskGetSonsorData.h"

#define CELL @"CELL"

@interface CHLDebugViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) CHLDebugView* viewDebug;
@property (nonatomic, strong) CHLTaskGetConfig* taskConfig;
@property (nonatomic, strong) CHLTaskGetSonsorData* taskSensorData;
@end

@implementation CHLDebugViewController

-(instancetype)init{
    self = [super init];

    return self;
}

-(void)loadView{
    self.viewDebug = [CHLDebugView new];
    self.view = self.viewDebug;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewDebug.tableView.delegate = self;
    self.viewDebug.tableView.dataSource = self;
    [self.viewDebug.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    NSString* text = @"";
    switch (indexPath.row) {
        case 0:
            text = @"state list";
            break;
        case 1:
            text = @"settings list";
            break;
    }
    cell.textLabel.text = text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            _taskSensorData = [[CHLTaskGetSonsorData alloc] initCompletionBlock:^(NSArray* sensors){
                CHLStateListViewController* controller = [[CHLStateListViewController alloc] initWithStates:sensors];
                [self.navigationController pushViewController:controller animated:YES];
                _taskSensorData = nil;
            } failBlock:^(NSError* error){
                NSString* errorDescription = error.description;
                NSLog(errorDescription);
                _taskSensorData = nil;
            }];
            [_taskSensorData execute];
        }
            break;
        case 1:
            _taskConfig = [[CHLTaskGetConfig alloc] initCompletionBlock:^(NSDictionary* settings){
                CHLSettingsListViewController* controller = [[CHLSettingsListViewController alloc] initWithSettings:settings];
                [self.navigationController pushViewController:controller animated:YES];
                _taskConfig = nil;
            } failBlock:^(NSError* error){
                
                _taskConfig = nil;
            }];
            [_taskConfig execute];
            break;
    }
}

@end
