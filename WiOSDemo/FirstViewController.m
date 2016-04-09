//
//  FirstViewController.m
//  WiOSDemo
//
//  Created by Wayne on 16/2/20.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "FirstViewController.h"
#import "WDemoCellInfo.h"
#import "AbstructCharacterBuilder.h"
#import "ConcreteCharacterBuilder.h"
#import "ChasingGameDirector.h"


@interface FirstViewController ()
@property(nonatomic, strong)NSMutableArray *imarrDataSource;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Design Patterns";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TeleplayPlayTableCell"];
    self.imarrDataSource = [[NSMutableArray alloc] init];
    [self.imarrDataSource addObjectsFromArray:@[
                                                WDemoCellMapSelector(@"生成器模式", doGeneratorClient)
                                                ]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imarrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCellIdentifier = @"TeleplayPlayTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellIdentifier forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strCellIdentifier];
    }
    cell.textLabel.text = WDemoGetCellTitle(self.imarrDataSource[indexPath.row]);
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WDemoDoCell([self.imarrDataSource objectAtIndex:indexPath.row]);
}

- (void)doGeneratorClient
{
    ChasingGameDirector *chasingGameDirector = [[ChasingGameDirector alloc] init];
    AbstructCharacterBuilder *characterBuilder = [[ConcreteCharacterBuilder alloc] init];
    Character *player1 = [chasingGameDirector createPlayer:characterBuilder];
    NSLog(@"player's protection:%f, strength:%f", player1.protection, player1.strength);
}

@end