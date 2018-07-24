//
//  ViewController.m
//  GSImageViewPopupExample
//
//  Created by Ganpat on 17/07/18.
//  Copyright © 2018 OmShanti. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"

@interface ViewController () <UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.imgView.image = [UIImage imageNamed:@"boy.png"];
    cell.imgView.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}

@end
