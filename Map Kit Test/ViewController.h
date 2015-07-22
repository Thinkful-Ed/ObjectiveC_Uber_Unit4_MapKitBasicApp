//
//  ViewController.h
//  Map Kit Test
//
//  Created by Piotr Prosol on 7/16/15.
//  Copyright (c) 2015 Piotr Prosol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKPointAnnotation *pointHere;
@end

