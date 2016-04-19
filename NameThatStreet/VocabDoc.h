//
//  VocabDoc.h
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Vocab;

@interface VocabDoc : NSObject {
    Vocab *_data;
    NSString *_docPath;
}

@property (retain) Vocab *data;
@property (copy) NSString *docPath;

- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (id)initWithName:(NSString *)name :(NSString *)translatedName;
- (void)saveData;
- (void)deleteDoc;

@end
