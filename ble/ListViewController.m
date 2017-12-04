//
//  ListViewController.m
//  ble
//
//  Created by 侯恩星 on 2017/12/4.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "ListViewController.h"
#import "CustomerCell.h"

@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _tableView.delegate = self;                                         //tableView delegate
    _tableView.dataSource = self;                                       //tableView dataSource
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;  //Single separator line
//    _tableView.backgroundColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:203/255.0 alpha:1.0];
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"listcell";

//    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
//    if(!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//    }

    CustomerCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) {
        cell = [[CustomerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }

    cell.layer.cornerRadius = 8;
    cell.layer.masksToBounds = YES;
    cell.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch(indexPath.row) {
        case 0:
            cell.textLabel.text = @"编辑纸条";
            cell.imageView.image = [UIImage imageNamed:@"paper.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            cell.textLabel.text = @"打印照片";
            cell.imageView.image = [UIImage imageNamed:@"photo.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            cell.textLabel.text = @"便利贴";
            cell.imageView.image = [UIImage imageNamed:@"sticky.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            cell.textLabel.text = @"代办清单";
            cell.imageView.image = [UIImage imageNamed:@"list.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 4:
            cell.textLabel.text = @"文本打印";
            cell.imageView.image = [UIImage imageNamed:@"note.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 5:
            cell.textLabel.text = @"网页打印";
            cell.imageView.image = [UIImage imageNamed:@"web.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            break;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];   //cell被选中后颜色底色迅速消失
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
