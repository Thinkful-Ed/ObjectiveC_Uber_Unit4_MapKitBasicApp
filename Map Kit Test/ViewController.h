//
//  ViewController.h
//  Map Kit Test
//
//  Created by Piotr Prosol on 7/16/15.
//  Copyright (c) 2015 Piotr Prosol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;

@end

