                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      //
//  MapViewController.h
//  NameThatStreet
//
//  Created by sally pang on 2016-04-16.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKAnnotation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    MKMapView *mapView;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
