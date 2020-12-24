//
//  AgoraLogEnums.h
//  AgoraLogger
//
//  Created by CavanSu on 2020/10/27.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AgoraConsolePrintType) {
    AgoraConsolePrintTypeNone = 0,
    AgoraConsolePrintTypeDebug = 1,
    AgoraConsolePrintTypeInfo = 2,
    AgoraConsolePrintTypeWarning = 4,
    AgoraConsolePrintTypeError = 8,
    AgoraConsolePrintTypeAll = 15
};

typedef NS_ENUM(NSInteger, AgoraLogType) {
    AgoraLogTypeDebug = 0,
    AgoraLogTypeInfo = 1,
    AgoraLogTypeWarning = 2,
    AgoraLogTypeError = 3
};
