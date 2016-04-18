//
//  AddressAnnotation.m
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-18.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation

@synthesize coordinate;
@synthesize title;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:(NSString *)placeName {
    self = [super init];
    if (self) {
        coordinate = location;
        title = placeName;        
    }
    
    return self;
}

@end
