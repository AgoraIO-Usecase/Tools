//
//  AgoraLogger.h
//  AgoraLog
//
//  Created by CavanSu on 2020/10/26.
//  Copyright © 2020 CavanSu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgoraLogEnums.h"

NS_ASSUME_NONNULL_BEGIN

@interface AgoraLogger : NSObject
@property (readonly, nonatomic, assign) AgoraConsolePrintType consoleType;

- (instancetype)initWithFolderPath:(NSString *)folderPath
                        filePrefix:(NSString *)filePrefix
              maximumNumberOfFiles:(NSInteger)number;
- (BOOL)setPrintOnConsoleType:(AgoraConsolePrintType)type;
- (BOOL)log:(NSString *)text
       type:(AgoraLogType)type;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
