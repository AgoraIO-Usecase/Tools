//
//  AgoraSceneStatistic.h
//  Sample
//
//  Created by Cavan on 2021/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AgoraUserRatingType) {
    AgoraUserRatingTypeCallQuality = 0,
    AgoraUserRatingTypeFunctionCompleteness = 1,
    AgoraUserRatingTypeGeneralExperience = 2,
};

@interface AgoraUserRatingValue : NSObject
@property (nonatomic, assign) AgoraUserRatingType type;
@property (nonatomic, assign) CGFloat value;

- (instancetype)initWithType:(AgoraUserRatingType)type
                       value:(CGFloat)value;
@end

@interface AgoraSceneStatisticContext : NSObject
@property (nonatomic, copy) NSString *os;
@property (nonatomic, copy) NSString *device;
@property (nonatomic, copy) NSString *app;
@property (nonatomic, copy) NSString *useCase;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *sessionId;
@end

@interface AgoraSceneStatistic : NSObject
@property (nonatomic, strong) AgoraSceneStatisticContext *context;

- (int)userRating:(NSArray<AgoraUserRatingValue *> *)values
          comment:(NSString *)comment
          success:(void (^) (void))success
             fail:(void (^) (NSInteger))fail;
@end

NS_ASSUME_NONNULL_END
