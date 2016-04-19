//
//  Vocab.m
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "Vocab.h"

@implementation Vocab

@synthesize name = _name;
@synthesize translatedName = _translatedName;

- (id)initWithName:(NSString*)name :(NSString*)translatedName {
    self = [super init];
    
    if (self) {
        _name = [name copy];
        _translatedName = [translatedName copy];
    }
    return self;
}

- (void)dealloc {
    _name = nil;
}

#pragma mark - NSCoding

#define kNameKey @"NameKey"
#define kTranslatedNameKey @"TranslatedNameKey"

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:kNameKey];
    [encoder encodeObject:_translatedName forKey:kTranslatedNameKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *name = [decoder decodeObjectForKey:kNameKey];
    NSString *translatedName = [decoder decodeObjectForKey:kTranslatedNameKey];
    return [self initWithName:name :translatedName];
}

@end
