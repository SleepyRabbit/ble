//
//  DeviceViewController.m
//  ble
//
//  Created by 侯恩星 on 2017/11/23.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "DeviceViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface DeviceViewController ()<UITableViewDataSource, UITabBarControllerDelegate, CBCentralManagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)onScan:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CBCentralManager *manager;
//用于保存被发现设备
@property (weak, nonatomic) NSMutableArray *discoverPeripherals;
//连接上的外部设备
@property (weak, nonatomic) CBPeripheral *_peripheral ;
@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.dataSource = self;
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    _label.text = @"Please start scan";
//    _tableView.rowHeight = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _discoverPeripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    CBPeripheral *peripheral = _discoverPeripherals [indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"设备名称 ：%@",peripheral.name];
//    if(indexPath.section == 0) {
//    }
//    else {
//    }
    return cell;
}

#pragma mark - <CBCentralManagerDelegate,CBPeripheralDelegate>

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            _label.text = @">>>CBCentralManagerStateUnknown";
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            _label.text = @">>>CBCentralManagerStateResetting";
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            _label.text = @">>>CBCentralManagerStateUnsupported";
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            _label.text = @">>>CBCentralManagerStateUnauthorized";
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            _label.text = @">>>CBCentralManagerStatePoweredOff";
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            _label.text = @">>>CBCentralManagerStatePoweredOn";

            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             */
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    BOOL isExisted = NO;
    for (CBPeripheral *myPeropheral in _discoverPeripherals) {
        if (myPeropheral.identifier == peripheral.identifier) {
            isExisted = YES;
        }
    }


    if (!isExisted) {
        [_discoverPeripherals addObject:peripheral];
        NSLog(@"%@",_discoverPeripherals);
    }
    [_tableView reloadData];
}

- (IBAction)onScan:(id)sender {
    NSLog(@"scan!");
    _label.text = @"scan";
    [_manager scanForPeripheralsWithServices:nil options:nil];
}
@end
