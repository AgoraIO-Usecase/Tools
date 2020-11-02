//
//  AgoraLogEnums.h
//  AgoraLogger
//
//  Created by CavanSu on 2020/10/27.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AgoraConsolePrintType) {
    AgoraConsolePrintTypeNone = 0,
    AgoraConsolePrintTypeInfo = 1,
    AgoraConsolePrintTypeWarning = 2,
    AgoraConsolePrintTypeError = 3,
    AgoraConsolePrintTypeAll = 4
};

typedef NS_ENUM(NSInteger, AgoraLogType) {
    AgoraLogTypeInfo = 0,
    AgoraLogTypeWarning = 1,
    AgoraLogTypeError = 2
};
