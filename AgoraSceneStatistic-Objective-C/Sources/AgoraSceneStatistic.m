//
//  AgoraSceneStatistic.m
//  Sample
//
//  Created by Cavan on 2021/3/10.
//

#import "AgoraSceneStatistic.h"
#import <Armin/Armin-Swift.h>
#import <CommonCrypto/CommonDigest.h>

#pragma mark - Extension
@interface NSDate (AgoraSceneStatistic)
- (NSInteger)agora_scene_statistic_timestamp;
@end

@implementation NSDate (AgoraSceneStatistic)
- (NSInteger)agora_scene_statistic_timestamp {
    return self.timeIntervalSince1970 * 1000;
}
@end

@interface NSString (AgoraSceneStatistic)
- (NSString *)get_agora_scene_statistic_md5;
@end

@implementation NSString (AgoraSceneStatistic)
- (NSString *)get_agora_scene_statistic_md5 {
    const char* original_str = [self UTF8String];
    
    unsigned char digist[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str,
           (uint)strlen(original_str),
           digist);
    
    NSMutableString *output = [NSMutableString string];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digist[i]];
    }
    
    return output;
}
@end

#pragma mark - Models
@implementation AgoraUserRatingValue
- (instancetype)initWithType:(AgoraUserRatingType)type
                       value:(CGFloat)value {
    if (self = [super init]) {
        self.type = type;
        self.value = value;
    }
    return self;
}
@end

@interface AgoraSceneStatisticContext ()
- (BOOL)isLegal;
@end

@implementation AgoraSceneStatisticContext
- (BOOL)isLegal {
    if (self.os.length > 0) {
        return NO;
    }
    
    if (self.device.length > 0) {
        return NO;
    }
    
    if (self.app.length > 0) {
        return NO;
    }
    
    if (self.useCase.length > 0) {
        return NO;
    }
    
    if (self.userId.length > 0) {
        return NO;
    }
    
    if (self.sessionId.length > 0) {
        return NO;
    }
    
    return YES;
}
@end
 
#pragma mark - AgoraSceneStatistic
@interface AgoraSceneStatistic () <ArLogTubeOC>
@property (nonatomic, strong) ArminOC *client;
@end

@implementation AgoraSceneStatistic
- (int)userRating:(NSArray<AgoraUserRatingValue *> *)values
          comment:(NSString *)comment
          success:(void (^) (void))success
             fail:(void (^) (NSInteger))fail {
    if (self.context && self.context.isLegal) {
        return -1;
    }
    
    NSInteger timestamp = [NSDate date].agora_scene_statistic_timestamp;
    NSString *sign = [NSString stringWithFormat:@"src=%@&ts=%ld", self.context.app, timestamp];
    
    // evaluation
    NSMutableDictionary *evaluation = [NSMutableDictionary dictionary];
    evaluation[@"app"] = self.context.app;
    evaluation[@"device"] = self.context.device;
    evaluation[@"os"] = self.context.os;
    evaluation[@"user_case"] = self.context.useCase;
    evaluation[@"user_id"] = self.context.userId;
    evaluation[@"session_id"] = self.context.sessionId;
    evaluation[@"time"] = @(timestamp);
    
    // rating
    NSMutableDictionary *rating = [NSMutableDictionary dictionary];
    
    for (AgoraUserRatingValue *ratingValue in values) {
        NSString *key = [self getRatingTypeTextWithType:ratingValue.type];
        CGFloat value = ratingValue.value;
        rating[key] = @(value);
    }
    
    evaluation[@"rating"] = rating;
    evaluation[@"comment"] = comment;
    
    // parameters
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"src"] = self.context.app;
    parameters[@"ts"] = @(timestamp);
    parameters[@"sign"] = sign.get_agora_scene_statistic_md5;
    parameters[@"evaluation"] = evaluation;
    
    NSString *url = @"https://evaluation.bj2.agoralab.co/v1/evaluation/report";
    NSDictionary *header = nil;
    
    ArRequestEventOC *event = [[ArRequestEventOC alloc] initWithName:@"user-rating"];
    ArRequestTypeJsonObjectOC *type = [[ArRequestTypeJsonObjectOC alloc] initWithMethod:ArHTTPMethodOCPost
                                                                                    url:url];
    ArRequestTaskOC *task = [[ArRequestTaskOC alloc] initWithEvent:event
                                                              type:type
                                                           timeout:10
                                                            header:header
                                                        parameters:parameters];
    [self.client requestWithTask:task
             responseOnMainQueue:YES
          successCallbackContent:ArResponseTypeOCBlank
                         success:^(ArResponseOC * _Nonnull response) {
        if (success) {
            success();
        }
    } fail:^NSTimeInterval(ArErrorOC * _Nonnull error) {
        if (fail) {
            fail(error.code);
        }
        return -1;
    }];
    
    return 0;
}

#pragma mark - ArLogTubeOC
- (void)logWithInfo:(NSString *)info
              extra:(NSString *)extra {
    [self log:@"info"
      content:info
        extra:extra];
}

- (void)logWithWarning:(NSString *)warning
                 extra:(NSString *)extra {
    [self log:@"warning"
      content:warning
        extra:extra];
}

- (void)logWithError:(ArErrorOC *)error
               extra:(NSString *)extra {
    [self log:@"error"
      content:error.description
        extra:extra];
}

- (void)log:(NSString *)type
    content:(NSString *)content
      extra:(NSString *)extra {
#if DEBUG
    NSLog(@"---------------------------------------------");
    NSLog(@"AgoraSceneStatistic %@: %@", type, content);
    if (extra.length > 0) {
        NSLog(@"extra: %@", extra);
    }
    NSLog(@"---------------------------------------------");
#endif
}

#pragma mark - Private
- (NSString *)getRatingTypeTextWithType:(AgoraUserRatingType)type {
    switch (type) {
        case AgoraUserRatingTypeCallQuality:
            return @"call_quality";
            break;
        case AgoraUserRatingTypeFunctionCompleteness:
            return @"function_completeness";
            break;
        case AgoraUserRatingTypeGeneralExperience:
            return @"general_experience";
            break;
    }
}

- (ArminOC *)client {
    if (!_client) {
        _client = [[ArminOC alloc] initWithDelegate:nil
                                            logTube:self];
    }
    return _client;
}
@end




