//
//  DeviceViewController.m
//  ble
//
//  Created by 侯恩星 on 2017/11/23.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "DeviceViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface DeviceViewController ()<UITableViewDataSource, UITableViewDelegate, CBCentralManagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)onScan:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CBCentralManager *manager;
//用于保存被发现设备
@property (strong, nonatomic) NSMutableArray *discoverPeripherals;
//连接上的外部设备
@property (strong, nonatomic) CBPeripheral *selPeripheral ;
@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    _discoverPeripherals = [NSMutableArray array];
    _label.text = @"Scan";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select!");
    CBPeripheral *peripheral = _discoverPeripherals [indexPath.row];
    _selPeripheral = peripheral;
    [_manager connectPeripheral:_selPeripheral options:nil];
}

#pragma mark - <CBCentralManagerDelegate,CBPeripheralDelegate>

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
//        case CBCentralManagerStateUnknown:
        case CBManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            _label.text = @">>>CBCentralManagerStateUnknown";
            break;
        case CBManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            _label.text = @">>>CBCentralManagerStateResetting";
            break;
        case CBManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            _label.text = @">>>CBCentralManagerStateUnsupported";
            break;
        case CBManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            _label.text = @">>>CBCentralManagerStateUnauthorized";
            break;
        case CBManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            _label.text = @">>>CBCentralManagerStatePoweredOff";
            break;
        case CBManagerStatePoweredOn:
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

//连接到Peripherals-失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}

//连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"didConnectPeripheral!");
    _selPeripheral = peripheral;
    //外设寻找 services
    [peripheral discoverServices:nil];

    [peripheral setDelegate:self];
    self.title = peripheral.name ;
    [_manager stopScan];



//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"已经连接上 %@",peripheral.name] message:nil preferredStyle:UIAlertControllerStyleAlert];

//    [self presentViewController:alertController animated:YES completion:^{
//        [alertController dismissViewControllerAnimated:NO completion:^{
//            //连接上跳转
//            [self presentViewController:self.inputController animated:YES completion:nil];
//            self.inputController.imputValueBlock = ^(NSString *sendStr){
//                _sendString = sendStr;
//                NSString *str = _sendString;
//                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//                [self writeCharacteristic:peripheral characteristic:_characteristic value:data];
//            };
//        }];
//
//    }];

}

- (IBAction)onScan:(id)sender {
    NSLog(@"scan!");
    if([_btn.titleLabel.text isEqual:@"Scan"]) {
        [_btn setTitle:@"Stop" forState:UIControlStateNormal];
        [_manager scanForPeripheralsWithServices:nil options:nil];
    }
    else {
        [_btn setTitle:@"Scan" forState:UIControlStateNormal];
        [_manager stopScan];
    }
}
@end
