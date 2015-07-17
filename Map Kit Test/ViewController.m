//
//  ViewController.m
//  Map Kit Test
//
//  Created by Piotr Prosol on 7/16/15.
//  Copyright (c) 2015 Piotr Prosol. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect fullScreenBounds = [[UIScreen mainScreen] bounds];
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, fullScreenBounds.size.width, fullScreenBounds.size.height)];
    [self.view addSubview:mapView];
    
    NSLog(@"%@", NSStringFromCGRect(mapView.bounds));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
