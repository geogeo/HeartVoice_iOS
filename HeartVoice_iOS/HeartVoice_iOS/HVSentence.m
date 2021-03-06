//
//  HVSentence.m
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/30/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import "HVSentence.h"



@implementation HVSentence

- (void ) initDB{
    _doc = PATH_OF_DOCUMENT;
    _path = [_doc stringByAppendingPathComponent:@"user.sqlite"];
    
    FMDatabase * db = [FMDatabase databaseWithPath:_path];
    NSFileManager * fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:_path] == NO) {
        if ([db open]) {
            //create table
            NSString *sqlCreate = @"CREATE TABLE 'Sentences' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'sentence')";
            BOOL resCreate = [db executeUpdate:sqlCreate];
            if (!resCreate) {
                NSLog(@"error when creating db table");
            } else {
                NSLog(@"success to creating db table");
            }
        
            //add sentences
            NSString * sqlAdd = @"insert into Sentences (sentence) values(?) ";
            [db executeUpdate:sqlAdd,  @"第一句话"];
            [db executeUpdate:sqlAdd,  @"第二句话"];
            [db executeUpdate:sqlAdd,  @"第三句话"];
            [db executeUpdate:sqlAdd,  @"第四句话"];
            BOOL resAdd = [db executeUpdate:sqlAdd,  @"第五句话"];

            if (!resAdd) {
                NSLog(@"error to insert data");
            } else {
                NSLog(@"success to insert data");
            }
        
            //db close
            [db close];
        
        } else {
            NSLog(@"error when open db");
        }
    }
}

- (NSMutableArray *) getSentencesList{
    NSMutableArray *sentencesList = [[NSMutableArray alloc] init];
    
    FMDatabase * db = [FMDatabase databaseWithPath:_path];
    if ([db open]) {
        NSString * sql = @"select * from Sentences";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString * sentence = [rs stringForColumn:@"sentence"];
            [sentencesList addObject:sentence];
        }
        [db close];
    }
    
    return sentencesList;
}


- (void) addSentence: (NSString*) sentence{

    FMDatabase * db = [FMDatabase databaseWithPath:_path];
    if ([db open]) {
        NSString * sql = @"insert into Sentences (sentence) values(?) ";
        [db executeUpdate:sql, sentence];
        [db close];
    }
    
    NSLog(@"add sentence to model");
}


- (void) removeSentence: (NSString *) sentence{
    NSLog(@"remove begin");
    FMDatabase * db = [FMDatabase databaseWithPath:_path];
    //FMDatabase * tempDb = [FMDatabase databaseWithPath:NULL];
    //[tempDb open];
    
    
    if ([db open]) {
        
        //NSString * getTempDb = @"select ROW_NUMBER() over(order by ID)  as rowid,* from Sentences";
        //FMResultSet * rs = [db executeQuery:getTempDb];
        
        NSString * sqlDelete = [NSString stringWithFormat:@"delete from Sentences where sentence = '%@'",sentence];
        BOOL res =[db executeUpdate:sqlDelete];
        if (!res) {
            NSLog(@"error when delete db table");
        } else {
            NSLog(@"success to delete db table");
        }
        [db close];
    }
    
}

@end
