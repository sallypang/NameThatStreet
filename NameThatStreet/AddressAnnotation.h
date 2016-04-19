//
//  AddressAnnotation.h
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-18.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject <MKAnnotation>

- (id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
