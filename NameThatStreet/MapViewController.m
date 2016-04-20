//
//  MapViewController.m
//  NameThatStreet
//
//  Created by sally pang on 2016-04-16.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "MapViewController.h"
#import "AddressAnnotation.h"
#import "VocabTableViewController.h"
#import "VocabDoc.h"
#import "AddVocabViewController.h"

@interface MapViewController ()

@property (nonatomic) BOOL *firstLaunch;

@end

@implementation MapViewController

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLaunch = YES;
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
    [mapView setShowsPointsOfInterest:YES];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.minimumPressDuration = 1.0;
    [mapView addGestureRecognizer:gesture];
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

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (self.firstLaunch) {
        [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.05f, 0.05)) animated:YES];
    }
    self.firstLaunch = NO;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
}

- (void)handleGesture:(UIGestureRecognizer *)gesture {
    if (gesture.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    CGPoint point = [gesture locationInView:mapView];
    CLLocationCoordinate2D coord = [mapView convertPoint:point toCoordinateFromView:mapView];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            [self presentLocationViewController:placemark.name];
        } else {
            NSLog(@"Could not locate");
        }

    }];
}

- (void)presentLocationViewController:(NSString *)placemark {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:placemark message:@"Would you like to save this word?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self performSegueWithIdentifier:@"AddVocabSegue" sender:self];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                   }];

    [alert addAction:save];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
