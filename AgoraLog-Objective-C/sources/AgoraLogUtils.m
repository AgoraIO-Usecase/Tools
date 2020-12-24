//
//  AgoraLogUtils.m
//  AgoraLogger
//
//  Created by CavanSu on 2020/10/27.
//

#import "AgoraLogUtils.h"

#pragma mark - AgoraLogFileManager
@interface AgoraLogFileManager ()
@property (nonatomic, copy) NSString *filePrefex;
@end

@implementation AgoraLogFileManager
- (instancetype)initWithLogsDirectory:(NSString *)logsDirectory withPrefix:(NSString *)prefix {
    if (self = [super initWithLogsDirectory:logsDirectory]) {
        self.filePrefex = prefix;
    }
    return self;
}

- (NSString *)newLogFileName {
    NSString *appName = self.filePrefex;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];;
    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@_%@.log", appName, formattedDate];
}

- (BOOL)isLogFile:(NSString *)fileName {
    NSString *appName = self.filePrefex;
    
    // We need to add a space to the name as otherwise we could match applications that have the name prefix.
    BOOL hasProperPrefix = [fileName hasPrefix:[appName stringByAppendingString:@"_"]];
    BOOL hasProperSuffix = [fileName hasSuffix:@".log"];
    
    return (hasProperPrefix && hasProperSuffix);
}
@end

#pragma mark - AgoraFileLogFormatter
@interface AgoraLogFormatter ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation AgoraLogFormatter
- (instancetype)init {
    if (self = [super init]) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    }
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *mesaage = [super formatLogMessage:logMessage];
    
    if (mesaage) {
        NSString *logLevel;
        switch (logMessage->_flag) {
            case DDLogFlagDebug    : logLevel = @"DEBUG";   break;
            case DDLogFlagInfo     : logLevel = @"INFO";    break;
            case DDLogFlagWarning  : logLevel = @"WARNING"; break;
            case DDLogFlagError    : logLevel = @"ERROR";   break;
            default                : logLevel = @"V";       break;
        }
        
        NSDate *date = logMessage->_timestamp;
        NSString *dateString = [self.dateFormatter stringFromDate:date];
        return [NSString stringWithFormat:@"%@ %@ | %@", dateString, logLevel, logMessage->_message];
    } else {
        return nil;
    }
}
@end

@implementation AgoraOSLogger
- (instancetype)initWithSubsystem:(NSString *)subsystem
                         category:(NSString *)category {
    self = [super initWithSubsystem:subsystem category:category];
    
    if (self) {
        self.consoleType = AgoraConsolePrintTypeNone;
    }
    return self;
}

- (void)logMessage:(DDLogMessage *)logMessage {
    switch (logMessage.flag) {
        case DDLogFlagDebug:
            if (self.consoleType & AgoraConsolePrintTypeDebug) {
                [super logMessage:logMessage];
            }
            break;
        case DDLogFlagInfo:
            if (self.consoleType & AgoraConsolePrintTypeInfo) {
                [super logMessage:logMessage];
            }
            break;
        case DDLogFlagWarning:
            if (self.consoleType & AgoraConsolePrintTypeWarning) {
                [super logMessage:logMessage];
            }
            break;
        case DDLogFlagError:
            if (self.consoleType & AgoraConsolePrintTypeError) {
                [super logMessage:logMessage];
            }
            break;
        default:
            break;
    }
    
    
//    if (self.consoleType == AgoraConsolePrintTypeAll) {
//        [super logMessage:logMessage];
//    } else if (self.consoleType == AgoraConsolePrintTypeNone) {
//        [super logMessage:logMessage];
//    } else {
//        switch (logMessage.flag) {
//            case DDLogFlagInfo:
//                if (self.consoleType == AgoraConsolePrintTypeInfo) {
//                    [super logMessage:logMessage];
//                }
//                break;
//            case DDLogFlagWarning:
//                if (self.consoleType == AgoraConsolePrintTypeWarning) {
//                    [super logMessage:logMessage];
//                }
//                break;
//            case DDLogFlagError:
//                if (self.consoleType == AgoraConsolePrintTypeError) {
//                    [super logMessage:logMessage];
//                }
//                break;
//            default:
//                break;
//        }
//    }
}
@end
