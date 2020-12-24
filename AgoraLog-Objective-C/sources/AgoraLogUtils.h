//
//  AgoraLogUtils.h
//  AgoraLogger
//
//  Created by CavanSu on 2020/10/27.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "AgoraLogEnums.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - AgoraLogFileManager
@interface AgoraLogFileManager : DDLogFileManagerDefault
- (instancetype)initWithLogsDirectory:(NSString *)logsDirectory
                           withPrefix:(NSString *)prefix;
@end

#pragma mark - AgoraFileLogFormatter
@interface AgoraLogFormatter : DDContextWhitelistFilterLogFormatter
@end

#pragma mark - AgoraOSLogger
@interface AgoraOSLogger : DDOSLogger
@property (nonatomic, assign) AgoraConsolePrintType consoleType;
@end

NS_ASSUME_NONNULL_END
