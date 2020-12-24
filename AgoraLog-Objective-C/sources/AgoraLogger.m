//
//  AgoraLogger.m
//  AgoraLog
//
//  Created by CavanSu on 2020/10/26.
//  Copyright © 2020 CavanSu. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>
#import "AgoraLogger.h"
#import "AgoraLogUtils.h"

@interface AgoraLogger ()
@property (nonatomic, strong) AgoraLogFormatter *logFormatter;
@property (nonatomic, strong) DDFileLogger *file;
@property (nonatomic, strong) AgoraOSLogger *os;

@property (nonatomic, assign) AgoraConsolePrintType consoleType;
@property (nonatomic, assign) NSInteger context;
@end

@implementation AgoraLogger
#pragma mark - Public
- (AgoraConsolePrintType)consoleType {
    return self.os.consoleType;
}

- (instancetype)initWithFolderPath:(NSString *)folderPath
                        filePrefix:(NSString *)filePrefix
              maximumNumberOfFiles:(NSInteger)number {
    if (self = [super init]) {
        self.consoleType = AgoraConsolePrintTypeNone;
        [self initLoggerWithFolder:folderPath
                        filePrefix:filePrefix
              maximumNumberOfFiles:number];
    }
    return self;
}

- (BOOL)setPrintOnConsoleType:(AgoraConsolePrintType)type {
    [DDLog removeLogger:self.os];
    self.os.consoleType = type;
    
    switch (type) {
        case AgoraConsolePrintTypeNone:
            break;
        case AgoraConsolePrintTypeAll:
            [DDLog addLogger:self.os withLevel:DDLogLevelAll];
            break;
        case AgoraConsolePrintTypeDebug:
            [DDLog addLogger:self.os withLevel:DDLogLevelDebug];
            break;
        case AgoraConsolePrintTypeInfo:
            [DDLog addLogger:self.os withLevel:DDLogLevelInfo];
            break;
        case AgoraConsolePrintTypeWarning:
            [DDLog addLogger:self.os withLevel:DDLogLevelWarning];
            break;
        case AgoraConsolePrintTypeError:
            [DDLog addLogger:self.os withLevel:DDLogLevelError];
            break;
        default:
            NSAssert(NO, @"Unavailable AgoraConsolePrintType");
            return NO;
            break;
    }
    
    return YES;
}

- (BOOL)log:(NSString *)text
       type:(AgoraLogType)type {
    DDLogLevel level;
    DDLogFlag flag;
    
    switch (type) {
        case AgoraLogTypeDebug:
            level = DDLogLevelDebug;
            flag = DDLogFlagDebug;
            break;
        case AgoraLogTypeInfo:
            level = DDLogLevelInfo;
            flag = DDLogFlagInfo;
            break;
        case AgoraLogTypeWarning:
            level = DDLogLevelWarning;
            flag = DDLogFlagWarning;
            break;
        case AgoraLogTypeError:
            level = DDLogLevelError;
            flag = DDLogFlagError;
            break;
        default:
            NSAssert(NO, @"Unavailable AgoraLogType");
            return NO;
            break;
    }
    
    [DDLog log:NO
         level:level
          flag:flag
       context:self.context
          file:__FILE__
      function:__PRETTY_FUNCTION__
          line:__LINE__
           tag:nil
        format:@"%@", text];
    
    return YES;
}

#pragma mark - Private
- (void)initLoggerWithFolder:(NSString *)folder
                  filePrefix:(NSString *)prefix
        maximumNumberOfFiles:(NSInteger)number {
    static NSInteger uniqueContextId = 1;
    
    self.context = uniqueContextId++;
    
    self.logFormatter = [[AgoraLogFormatter alloc] init];
    [self.logFormatter addToWhitelist:self.context];
    
    // file
    AgoraLogFileManager *fileManager = [[AgoraLogFileManager alloc] initWithLogsDirectory:folder
                                                                               withPrefix:prefix];
    self.file = [[DDFileLogger alloc] initWithLogFileManager:fileManager];
    self.file.doNotReuseLogFiles = YES;
    self.file.logFileManager.maximumNumberOfLogFiles = number;
    self.file.logFormatter = self.logFormatter;
    self.file.maximumFileSize = 1024 * 1024 * 5;
    self.file.rollingFrequency = 0;
    
    [DDLog addLogger:self.file
           withLevel:DDLogLevelInfo];
    
    // console.app and xcode's console
    self.os = [[AgoraOSLogger alloc] initWithSubsystem:nil
                                              category:nil];
    self.os.logFormatter = self.logFormatter;
}
@end

