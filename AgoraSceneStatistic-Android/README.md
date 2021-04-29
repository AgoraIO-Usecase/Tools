# AgoraSceneStatistic *[简体中文](README.zh.md)*

The SDK supports outputting user rating to agora statistic platform

## Supported platforms and languages
* platform: Android
* languages: Java/Kotlin

## Quick start

**Integration through Gradle**

In the project root directory build.gradle Add the following configuration to the file
``` gradle
allprojects {
		repositories {
			mavenCentral()
		}
	}
```
In the app directory build.gradle Add the following configuration to the file
``` kotlin
dependencies {
		implementation 'io.github.agoraio-usecase.tools:statistic:1.0.1'
	}
```
Sync project.

**Create AgoraSceneStatistic object**

``` Java
AgoraSceneStatistic agoraSceneStatistic = new AgoraSceneStatistic();
agoraSceneStatistic.setContent(new AgoraSceneStatisticContext(context, userId, scene, roomId))
        .userRating(new AgoraUserRatingValue(callQuality, functionCompleteness, generalExperience),
                comment,
                null,
                error -> {});
```
