//
//  SimpleLogger.m
//  ProjectProblem
//
//  Created by Yaakov Gamliel on 7/31/16.
//  Copyright © 2016 Michael. All rights reserved.
//

#import "SimpleLogger.h"

@implementation SimpleLogger

+ (void)logWithMessage:(NSString *)message {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"fileLog"];
    NSString *logLine = message;
    
    dispatch_queue_t myQueue = dispatch_queue_create("LoggingQueue",NULL);
    dispatch_async(myQueue, ^{
        NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:appFile];
        if (!fileHandler) {
            [[NSFileManager defaultManager] createFileAtPath:appFile contents:nil attributes:nil];
            fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:appFile];
        }
        [fileHandler seekToEndOfFile];
        [fileHandler writeData:[logLine dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandler closeFile];        
    });
}

@end
