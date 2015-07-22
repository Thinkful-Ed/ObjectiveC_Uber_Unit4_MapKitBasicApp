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

NSString *const kNewYorkTitle = @"New York City";
NSString *const kBostonTitle = @"Boston";
NSString *const kDCTitle = @"Washington D.C.";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect fullScreenBounds = [[UIScreen mainScreen] bounds];
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, fullScreenBounds.size.width, fullScreenBounds.size.height)];
    [self.view addSubview:self.mapView];
    
    NSLog(@"%@", NSStringFromCGRect(self.mapView.bounds));
    
    NSLog(@"%f", self.mapView.region.center.latitude);
    NSLog(@"%f", self.mapView.region.center.longitude);
    
    self.mapView.delegate = self;

    CLLocationCoordinate2D newCoordinate = CLLocationCoordinate2DMake(37.775490, -122.417963); // Uber HQ
    MKCoordinateSpan newSpan = MKCoordinateSpanMake(0.001, 0.0005);
    MKCoordinateRegion newRegion = MKCoordinateRegionMake(newCoordinate, newSpan);
    // mapView.region = newRegion; - This is an alternative to the following, from earlier in the exercise.
    
    self.mapView.region = [self.mapView regionThatFits:newRegion]; // Try entering various numbers to MKCoordinateSpanMake and see what happens, vs. mapView.region = newRegion.
    
    [self.mapView addAnnotations:[self createArrayOfCities]];
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    
    [self setResponseForUserTapAndHoldOnMapView];
}

- (NSArray *)createArrayOfCities {
    CLLocationCoordinate2D bostonCoordinate = CLLocationCoordinate2DMake(42.358280, -71.060966);
    CLLocationCoordinate2D newYorkCoordinate = CLLocationCoordinate2DMake(40.769626, -73.924905);
    CLLocationCoordinate2D dcCoordinate = CLLocationCoordinate2DMake(38.888930, -77.027307);
    
    MKPointAnnotation *bostonPoint = [[MKPointAnnotation alloc] init];
    bostonPoint.title = kBostonTitle;
    bostonPoint.subtitle = @"Population: 646,000";
    bostonPoint.coordinate = bostonCoordinate;
    
    MKPointAnnotation *newYorkPoint = [[MKPointAnnotation alloc] init];
    newYorkPoint.title = kNewYorkTitle;
    newYorkPoint.subtitle = @"Population: 8,400,000";
    newYorkPoint.coordinate = newYorkCoordinate;
    
    MKPointAnnotation *dcPoint = [[MKPointAnnotation alloc] init];
    dcPoint.title = kDCTitle;
    dcPoint.subtitle = @"Population: 659,000";
    dcPoint.coordinate = dcCoordinate;
    
    return @[bostonPoint, newYorkPoint, dcPoint];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"After region change, latitude: %f", mapView.region.center.latitude);
    NSLog(@"After region change, longitude%f", mapView.region.center.longitude);
    
    NSLog(@"Span latitude delta after region change: %f", mapView.region.span.latitudeDelta);
    NSLog(@"Span longitude delta after region change: %f", mapView.region.span.longitudeDelta);
}

- (void)setResponseForUserTapAndHoldOnMapView {
    UILongPressGestureRecognizer *tapAndHoldRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dropPinAtUserTouch:)];
    [self.mapView addGestureRecognizer:tapAndHoldRecognizer];
}
                                                                                                                                    
- (void)dropPinAtUserTouch:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint locationTouched = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchedCoordinate = [self.mapView convertPoint:locationTouched toCoordinateFromView:self.mapView];
    MKPointAnnotation *pointTouched = [[MKPointAnnotation alloc] init];
    pointTouched.coordinate = touchedCoordinate;
    [self.mapView addAnnotation:pointTouched];
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView *pinView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            // 4. Customize the pin!
            pinView.pinColor = MKPinAnnotationColorPurple;
            pinView.canShowCallout = YES;
            //Customize the callout
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = rightButton;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKPointAnnotation *pointAnnotation = annotation;
        if ([pointAnnotation.title isEqualToString:kNewYorkTitle]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://en.wikipedia.org/wiki/New_York_City"]];
        } else if ([pointAnnotation.title isEqualToString:kBostonTitle]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://en.wikipedia.org/wiki/Boston"]];
        } else if ([pointAnnotation.title isEqualToString:kDCTitle]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://en.wikipedia.org/wiki/Washington,_D.C."]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
