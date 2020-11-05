# AgoraLog *[简体中文](README.zh.md)*

The SDK supports outputting logs to Android studio console, console and writing files. Multiple logger objects can be created to output the logs received by each object. Objects are independent of each other.

## Supported platforms and languages
* platform: Android
* languages: Java/Kotlin

## Quick start

**Integration through Gradle**

In the project root directory build.gradle Add the following configuration to the file
``` gradle
allprojects {
		repositories {
			...
			maven { url 'https://jitpack.io' }
		}
	}
```
In the app directory build.gradle Add the following configuration to the file
``` kotlin
dependencies {
		implementation 'com.github.AgoraIO-Usecase:Tools:AgoraLog-Android-1.0.1'
	}
```
Sync project.

**Create AgorLogger object**

``` Java
String folderPath = "Your log folder"
String filePrefix = "Prefix of your log file"
int number = 5
String tag = "Your tag"
AgoraConsolePrintType type = AgoraConsolePrintType.NONE

AgoraLogManager logger = AgoraLogManager(folderPath, filePrefix, maximumNumberOfFiles, tag, type)
```

* folderPath: The framework will automatically check the folder where the log files are stored. If it does not exist, it will help to create it. but **Attention**，it cannot be deleted externally in the life cycle of this build
* filePrefix: The prefix of the log file. The naming format of the log file is "prefix + time. Log"
* maximumNumberOfFiles: The maximum number of log files prefixed with "fileprefix" in the "folderpath" folder
* tag: Tag of each log line
* type: Set the type of log to display in the console
* Attention: This interface only outputs log types to Android studio console and console.app, and does not affect log writing. The SDK will write all log calls to a file

##### AgoraConsolePrintType
```
class AgoraConsolePrintType {
    NONE , INFO, WARNING, ERROR, ALL
}
```

* NONE: Nothing output
* INFO: Output only logs of type info
* WARNING: Only logs of type warning are output
* ERROR: Output only logs of type error
* ALL: Output all types of logs



**Print log**

```
enum AgoraLogType {
    case info, warning, error
}
```
* INFO: Normal information
* WARNING: Warning message
* ERROR: Error message

```
logger.log(String msg, AgoraLogType type)
```
* msg: Log content
* type: Log type

## Special instructions
Log files can be distinguished by setting the folder path of logger1 and logger2 to the same, but with different prefixes. Then, as long as you upload this folder, you can upload the logs output by logger1 and logger2.
