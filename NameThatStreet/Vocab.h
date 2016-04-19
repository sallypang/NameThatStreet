//
//  Vocab.h
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vocab : NSObject <NSCoding> {
    NSString *_name;
    NSString *_translatedName;
}

@property (copy) NSString *name;
@property (copy) NSString *translatedName;

- (id)initWithName:(NSString *)name :(NSString *)translatedName;

@end
