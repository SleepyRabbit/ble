//
//  AddDeviceViewController.m
//  ble
//
//  Created by 侯恩星 on 2017/11/29.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "AddDeviceViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface AddDeviceViewController ()<UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate, CBPeripheralDelegate> {
    CBCentralManager *manager;  //CentralManager
    CBPeripheral *selPeripheral;
    NSMutableArray *discoverPeripherals; //discoverPeripherals是一个二维数组，格式如下
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

    _tableView.delegate = self;   //代理
    _tableView.dataSource = self;       //数据源
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];     //去掉对于的cell

    discoverPeripherals = [NSMutableArray array];  //初始化
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];  //初始化CBCentralManager
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selPeripheral = [discoverPeripherals[indexPath.row] objectAtIndex:0];
//    NSLog(@"%@", selPeripheral);
    [manager connectPeripheral:selPeripheral options:nil];      //连接设备
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

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接成功！");
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"设备连接成功！" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"设备连接成功！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
    [manager stopScan];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"蓝牙设备%@已经断开！" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"蓝牙设备%@已经断开",[peripheral name]] message:@"请重新扫描" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
//    [alertView show];
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
