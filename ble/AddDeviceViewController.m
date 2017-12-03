//
//  AddDeviceViewController.m
//  ble
//
//  Created by 侯恩星 on 2017/11/29.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "AddDeviceViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface AddDeviceViewController ()<UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate> {
    CBCentralManager *manager;  //CentralManager
    CBPeripheral *selPeripheral;
    NSMutableArray *discoverPeripherals;
    /* discoverPeripherals {
        CBPeripheral *peripheral;
        NSNumber *rssi;
    }; */
}
- (IBAction)onScan:(id)sender;
- (IBAction)onStop:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *state;
@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    discoverPeripherals = [NSMutableArray array];
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UITableView delegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return discoverPeripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"peripheral";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    CBPeripheral *peripheral = [discoverPeripherals[indexPath.row] objectAtIndex:0];
    NSNumber *rssi = [discoverPeripherals[indexPath.row] objectAtIndex:1];
    cell.textLabel.text = [NSString stringWithFormat:@"设备名称 ：%@",peripheral.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@db", rssi];
    return cell;
}

#pragma mark <CoreBluetooth delegate>

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch(central.state) {
        case CBManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            _state.text = @">>>CBCentralManagerStateUnknown";
            break;
        case CBManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            _state.text = @">>>CBCentralManagerStateResetting";
            break;
        case CBManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            _state.text = @">>>CBCentralManagerStateUnsupported";
            break;
        case CBManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            _state.text = @">>>CBCentralManagerStateUnauthorized";
            break;
        case CBManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            _state.text = @">>>CBCentralManagerStatePoweredOff";
            break;
        case CBManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            _state.text = @">>>CBCentralManagerStatePoweredOn";
            [manager scanForPeripheralsWithServices:nil options:nil];
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {

//    NSLog(@"%@",peripheral);
//    NSLog(@"%@", RSSI);
    bool isExist = NO;
    int cnt = 0;
    for(NSMutableArray *mutableArray in discoverPeripherals) {
        CBPeripheral *myPeripheral = [mutableArray objectAtIndex:0];
        if(myPeripheral.identifier == peripheral.identifier) {
            [mutableArray replaceObjectAtIndex:1 withObject:RSSI];
            [discoverPeripherals replaceObjectAtIndex:cnt withObject:mutableArray];
            isExist = YES;
            break;
        }
        cnt++;
    }

    if(!isExist) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
        [array addObject:peripheral];
        [array addObject:RSSI];
        [discoverPeripherals addObject:array];
    }
//    NSLog(@"%@", discoverPeripherals);
    [_tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onScan:(id)sender {
    [manager scanForPeripheralsWithServices:nil options:nil];
}

- (IBAction)onStop:(id)sender {
    [manager stopScan];
}
@end
