//
//  AddressAnnotation.h
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-18.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
}

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:(NSString *)placeName;

@end
