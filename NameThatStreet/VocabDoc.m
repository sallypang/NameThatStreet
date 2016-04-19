//
//  VocabDoc.m
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "VocabDoc.h"
#import "Vocab.h"
#import "VocabDatabase.h"

#define kDataKey @"Data"
#define KDataFile @"data.plist"


@implementation VocabDoc

@synthesize data = _data;
@synthesize docPath = _docPath;

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

- (id)initWithDocPath:(NSString *)docPath {
    if ((self = [super init])) {
        _docPath = [docPath copy];
    }
    return self;
}

- (id)initWithName:(NSString *)name :(NSString *)translatedName {
    if ((self = [super init])) {
        _data = [[Vocab alloc] initWithName:name :translatedName];
    }
    return self;
}

- (void)dealloc {
    _data = nil;
    _docPath = nil;
}

- (BOOL)createDataPath {
    if (_docPath == nil) {
        self.docPath = [VocabDatabase nextDocPath];
    }
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
}

- (Vocab *)data {
    if (_data != nil) {
        return _data;
    }
    NSString *dataPath = [_docPath stringByAppendingPathComponent:KDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath];
    if (codedData == nil) {
        return nil;
    }
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    _data = [unarchiver decodeObjectForKey:kDataKey];
    [unarchiver finishDecoding];
    return _data;
}

- (void)saveData {
    if (_data == nil) {
        return;
    }
    [self createDataPath];
    NSString *dataPath = [_docPath stringByAppendingPathComponent:KDataFile];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_data forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
}

- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_docPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}

@end
