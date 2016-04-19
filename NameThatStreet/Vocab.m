//
//  Vocab.m
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "Vocab.h"

@implementation Vocab

- (id)initWithName:(NSString *)name; {
    self = [super init];
    
    if (self) {
        _name = name;
    }
    return self;
}

@end
