//
//  GMScoresViewController.m
//  GuitarMaster
//
//  Created by null on 15/5/27.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import "GMScoresViewController.h"

@implementation GMScoresViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.controller reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableDataController:(OllaController *)controller didSelectAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"com.segue.play" sender:nil];
}

@end
