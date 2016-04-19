//
//  Vocab.h
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vocab : NSObject <NSCoding>

@property (nonnull, nonatomic, strong) NSString *name;
@property (nullable, nonatomic, strong) NSString *translatedName;

- (id)initWithName:(NSString *)name;

@end
