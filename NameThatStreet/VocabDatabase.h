//
//  VocabDatabase.h
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VocabDatabase : NSObject {
    
}

+ (NSMutableArray *)loadVocabDocs;
+ (NSString *)nextDocPath;

@end
