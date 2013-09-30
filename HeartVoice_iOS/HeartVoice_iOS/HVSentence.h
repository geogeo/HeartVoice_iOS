//
//  HVSentence.h
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/30/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface HVSentence : NSObject{
    NSString * _doc;
    NSString * _path;
}

- (void) initDB;

- (NSMutableArray *) getSentencesList;

- (void) addSentence: (NSString*) sentence;

- (void) removeSentence: (NSString *) index;

@end
