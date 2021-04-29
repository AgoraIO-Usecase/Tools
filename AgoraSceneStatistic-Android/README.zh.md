# AgoraSceneStatistic   *[English](README.md)*

该 SDK 支持将用户评分上传到agora统计平台上

## 支持的平台与语言
* 平台: Android
* 语言: Java/Kotlin

## 快速开始

**通过 Gradle 集成**

在工程根目录下的build.gradle文件中添加以下配置
``` gradle
allprojects {
		repositories {
			mavenCentral()
		}
	}
```
在app目录下的build.gradle文件中添加以下配置
``` kotlin
dependencies {
		implementation 'io.github.agoraio-usecase.statistic:1.0.1'
	}
```
同步工程

**创建一个 AgoraSceneStatistic 对象**

``` Java
AgoraSceneStatistic agoraSceneStatistic = new AgoraSceneStatistic();
agoraSceneStatistic.setContent(new AgoraSceneStatisticContext(context, userId, scene, roomId))
        .userRating(new AgoraUserRatingValue(callQuality, functionCompleteness, generalExperience),
                comment,
                null,
                error -> {});
```

* context: Android上下文环境
* userId: 用户id
* roomId: 房间id
* scene: 使用场景
* callQuality: 通话质量评分，0~5
* functionCompleteness: 功能完整性评分，0~5
* generalExperience: 用户体验评分，0~5
* comment: 用户评论

