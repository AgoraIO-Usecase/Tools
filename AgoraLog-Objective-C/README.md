# AgoraLog

该 Framework 支持将日志输出到 Xcode console， Console.app 与写入文件。可以创建多个 Logger 对象，输出各个对象所接收到的日志。各个对象之间相互独立。

## 支持的平台与语言
* 平台: iOS, OSX
* 语言: Objective-C, Swift

## 快速开始

**通过 CocoaPods 集成**

```
//iOS
platform :ios, '10.0'
pod 'AgoraLog'
```

```
//OSX
platform :osx, '10.12'
pod 'AgoraLog'
```

**导入 Framework**

```
//OC
#import <AgoraLog/AgoraLogger.h>
```

```
//Swift
import AgoraLog 
```

**创建一个 AgoraLogger 对象**

```
let folderPath = "Your log folder"
let filePrefix = "Prefix of your log file"
let number = 5

let logger = AgoraLogger(folderPath: folderPath,
                         filePrefix: filePrefix,
                         maximumNumberOfFiles: number)
```

* folderPath: 存放日志文件的文件夹，Framework会自动检查，如果不存在，会帮忙创建。但 **注意**，在本次组建的生命周期内不能被外部删除
* filePrefix: 日志文件的前缀，日志文件的命名格式为 "前缀+时间.log"
* maximumNumberOfFiles: 在该 "folderPath" 文件夹下，以 "filePrefix" 为前缀的日志文件所能存放的最大个数

**设置 Xcode 的控制台与 Console.app 的输出类型**

```
enum AgoraConsolePrintType {
    case all, info, warning, error, none
}
```

* all: 输出所有类型的日志
* info: 只输出为 info 类型的日志
* warning: 只输出为 warning 类型的日志
* error: 只输出为 error 类型的日志
* none: 什么都不输出

```
logger.setPrintOnConsoleType(type: AgoraConsolePrintType)
```

* type: 设置类型
* 注意: 该接口只管输出到 Xcode 的控制台与 Console.app 的日志类型，并不影响日志写入。该 Framework 会把所有调输入的日志都写入文件

**将日志输入 Framework**

```
enum AgoraLogType {
    case info, warning, error
}
```
* info: 正常信息
* warning: 警告信息
* error: 错误信息

```
logger.log(text: String, type: AgoraLogType)
```
* text: 日志内容
* type: 日志类型

## 特殊说明
可以将 logger1 与 logger2 的文件夹路径设为一样的，但前缀不一样来区分日志文件。然后只要上传这个文件夹，就能够把 logger1 与 logger2 输出的日志都上传。
