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
    
    NSLog(@"%f", mapView.region.center.latitude);
    NSLog(@"%f", mapView.region.center.longitude);
    
    mapView.delegate = self;

    CLLocationCoordinate2D newCoordinate = CLLocationCoordinate2DMake(37.775490, -122.417963); // Uber HQ
    MKCoordinateSpan newSpan = MKCoordinateSpanMake(0.001, 0.0005);
    MKCoordinateRegion newRegion = MKCoordinateRegionMake(newCoordinate, newSpan);
    // mapView.region = newRegion; - This is an alternative to the following, from earlier in the exercise.
    
    mapView.region = [mapView regionThatFits:newRegion]; // Try entering various numbers to MKCoordinateSpanMake and see what happens, vs. mapView.region = newRegion. 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"After region change, latitude: %f", mapView.region.center.latitude);
    NSLog(@"After region change, longitude%f", mapView.region.center.longitude);
    
    NSLog(@"Span latitude delta after region change: %f", mapView.region.span.latitudeDelta);
    NSLog(@"Span longitude delta after region change: %f", mapView.region.span.longitudeDelta);
}

@end
