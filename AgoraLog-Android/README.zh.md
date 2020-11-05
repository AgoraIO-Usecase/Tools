# AgoraLog   *[English](README.md)*

该 SDK 支持将日志输出到 Android Studio console， 控制台 与写入文件。可以创建多个 Logger 对象，输出各个对象所接收到的日志。各个对象之间相互独立。

## 支持的平台与语言
* 平台: Android
* 语言: Java/Kotlin

## 快速开始

**通过 Gradle 集成**

在工程根目录下的build.gradle文件中添加以下配置
``` gradle
allprojects {
		repositories {
			...
			maven { url 'https://jitpack.io' }
		}
	}
```
在app目录下的build.gradle文件中添加以下配置
``` kotlin
dependencies {
		implementation 'com.github.AgoraIO-Usecase:Tools:AgoraLog-Android-1.0.1'
	}
```
同步工程

**创建一个 AgoraLogger 对象**

``` Java
String folderPath = "Your log folder"
String filePrefix = "Prefix of your log file"
int number = 5
String tag = "Your tag"
AgoraConsolePrintType type = AgoraConsolePrintType.NONE

AgoraLogManager logger = AgoraLogManager(folderPath, filePrefix, maximumNumberOfFiles, tag, type)
```

* folderPath: 存放日志文件的文件夹，Framework会自动检查，如果不存在，会帮忙创建。但 **注意**，在本次组建的生命周期内不能被外部删除
* filePrefix: 日志文件的前缀，日志文件的命名格式为 "前缀+时间.log"
* maximumNumberOfFiles: 在该 "folderPath" 文件夹下，以 "filePrefix" 为前缀的日志文件所能存放的最大个数
* tag: 每行日志的tag
* type: 设置显示到console中的日志类型
* 注意: 该接口只管输出到 Android Studio console 与 控制台 的日志类型，并不影响日志写入。该 SDK 会把所有调输入的日志都写入文件

##### AgoraConsolePrintType
```
class AgoraConsolePrintType {
    NONE , INFO, WARNING, ERROR, ALL
}
```

* NONE: 什么都不输出
* INFO: 只输出为 info 类型的日志
* WARNING: 只输出为 warning 类型的日志
* ERROR: 只输出为 error 类型的日志
* ALL: 输出所有类型的日志



**打印日志**

```
enum AgoraLogType {
    case info, warning, error
}
```
* INFO: 正常信息
* WARNING: 警告信息
* ERROR: 错误信息

```
logger.log(String msg, AgoraLogType type)
```
* msg: 日志内容
* type: 日志类型

## 特殊说明
可以将 logger1 与 logger2 的文件夹路径设为一样的，但前缀不一样来区分日志文件。然后只要上传这个文件夹，就能够把 logger1 与 logger2 输出的日志都上传。
