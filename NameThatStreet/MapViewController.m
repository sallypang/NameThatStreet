//
//  MapViewController.m
//  NameThatStreet
//
//  Created by sally pang on 2016-04-16.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "MapViewController.h"
#import "AddressAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    mapView.showsBuildings = YES;
    
    [mapView setScrollEnabled:YES];
    [mapView setZoomEnabled:YES];
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = 47.640071;
    annotationCoord.longitude = -122.129598;
    
    AddressAnnotation *annotationPoint = [[AddressAnnotation alloc] initWithName:@"Hey" address:@"No" coordinate:annotationCoord];
    
    [mapView addAnnotation:annotationPoint];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - MKMapViewDelegate

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.05f, 0.05)) animated:YES];
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier= @"identifier";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pinView.pinTintColor = [UIColor purpleColor];
        pinView.animatesDrop = YES;
    }
    
    return pinView;
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
}

@end
