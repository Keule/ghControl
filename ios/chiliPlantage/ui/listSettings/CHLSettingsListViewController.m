//
//  CHLSettingsListViewController.m
//  chiliPlantage
//
//  Created by Thomas Wolters on 17/05/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "CHLSettingsListViewController.h"
#import "CHLSettingCell.h"
#import "CHLSettingsListView.h"



@interface CHLSettingsListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) CHLSettingsListView* viewListStettings;
@property (nonatomic, strong) NSDictionary* settings;
@property (nonatomic, strong) NSArray* keys;

@end

@implementation CHLSettingsListViewController

-(instancetype)initWithSettings:(NSDictionary*)settings{
    self = [super init];
    _settings = settings;
    _keys = [settings allKeys];
    return self;
}

-(void)loadView{
    self.viewListStettings = [CHLSettingsListView new];
    self.view = self.viewListStettings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewListStettings.tableView.delegate = self;
    self.viewListStettings.tableView.dataSource = self;
    [self.viewListStettings.tableView registerClass:[CHLSettingCell class] forCellReuseIdentifier:CELL_SETTINGS];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_keys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHLSettingCell* cell = [tableView dequeueReusableCellWithIdentifier:CELL_SETTINGS];
    NSString* key = _keys[indexPath.row];
    cell.textLabel.text = key;
    NSNumber* number = _settings[key];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"wert %i", [number intValue]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_SETTINGS_HEIGHT;
}

@end
