//
//  HippoManager.m
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/16.
//  Copyright © 2019 xlkd 24. All rights reserved.
//

#import "HippoManager.h"

@interface HippoManager ()
@property (nonatomic, strong) GCDTimer  *gcdTimer;
@property (nonatomic,copy)void (^chooseBtnViewBlock)(float mood,float food,float exp,float clean,NSInteger shitNumber);
@property (nonatomic, strong) GCDTimer  *currentimer;

@end

@implementation HippoManager

static HippoManager* _instance = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance ;
}

- (void)createSqlite {
    HippoModel *model = [[HippoToolManager shareInstance] readData];
    if (model == nil) {

        [[HippoToolManager shareInstance] createSqlite];
        [[HippoToolManager shareInstance] insertDataId:@"1" actionTime:[[HippoToolManager shareInstance] getCurrentTiem] changeExpTime:[[HippoToolManager shareInstance] getCurrentTiem] changeMoodTime:[[HippoToolManager shareInstance] getCurrentTiem] food:1.0 exp:1.0 mood:1.0 clean:1.0 shitNumber:0 downStatus:@"0" changeShitTime:[[HippoToolManager shareInstance] getCurrentTiem]];
        
    }
}

#pragma mark - GCDTimer

- (void)configDataWithGcdTimerSuccess:(void (^)(float mood,float food,float exp,float clean,NSInteger shitNumber))success {
    __weak __typeof(self) weakSelf = self;
    self.gcdTimer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    self.chooseBtnViewBlock = success;
    [self.gcdTimer event:^{
        //
        [weakSelf configDataWithModel:[[HippoToolManager shareInstance] getCurrentTiem]];
        
    } timeInterval:NSEC_PER_SEC * 1.0];
    
    [self.gcdTimer start];
}

- (void)configDataWithGifWoth:(NSInteger)time timerSuccess:(void (^)(void))gifSuccess {
    NSInteger secondsCountDown = time;
    __weak __typeof(self) weakSelf = self;
    __block NSInteger timeout = secondsCountDown;
    self.currentimer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.currentimer event:^{
        //
        if(timeout <= 0){
            [weakSelf.currentimer destroy];
            weakSelf.currentimer = nil;
            gifSuccess();
        } else {
            timeout--;
        }
        
    } timeInterval:NSEC_PER_SEC * 1.0 delay:timeout];
    
    [self.currentimer start];
}

- (HippoModel *)configDataWithModel {
    HippoModel *model = [[HippoToolManager shareInstance] readData];
    if (model == nil) {
        //不存在了
        [[HippoManager shareInstance] createSqlite];
        HippoModel *changeModel = [[HippoToolManager shareInstance] readData];
        return changeModel;
    } else {
        return model;
    }
}


- (SummerOrderStatus)configDataNormalWithUI {
    HippoModel *model =  [[HippoManager shareInstance] configDataWithModel];
    
    int16_t shitNumber = model.shitNumber;
    
    NSString *endDownStatus = model.downStatus;
    if ([endDownStatus isEqualToString:@"1"] && shitNumber > 0) {

        return GETDOWNSHIT;
    } else if ([endDownStatus isEqualToString:@"1"] && shitNumber == 0) {

        return GETDOWN;
    } else if (shitNumber > 0) {
 
        return ACTIVESHIT;
    } else {
    
        return ACTIVE;
    }
    
}



- (void)configDataWithModel:(NSString *)time {
    HippoModel *model = [[HippoManager shareInstance] configDataWithModel];

    float moodNumber = model.mood;
    float foodNumber = model.food;
    float expNumber = model.exp;
    float cleanNumber = model.clean;
    int16_t shitNumber = model.shitNumber;
    long int shitNumberTime = [time integerValue] - [model.changeShitTime integerValue];
    long int moodNumberTime = [time integerValue] - [model.changeMoodTime integerValue];
    long int actionNumberTime = [time integerValue] - [model.actionTime integerValue];
    long int expNumberTime = [time integerValue] - [model.changeExpTime integerValue];
    long int cleanNumberTime = [time integerValue] - [model.changeCleanTime integerValue];
    
    NSString *endDownStatus = model.downStatus;
    NSString *endExpNumberTime = model.changeExpTime;
    NSString *endMoodNumberTime = model.changeMoodTime;
    NSString *endActionNumberTime = model.actionTime;
    NSString *endShitTime = model.changeShitTime;
    NSString *endCleanNumberTime = model.changeCleanTime;
    
    if (cleanNumber == 0.00) {
        endCleanNumberTime = time;
    }else{
        int extInt = (int)cleanNumberTime;
        int number = extInt / HippoCleanTime;
        if (number > 0) {
            
            float cleanChangeNumber = 0.1 * (float)number;
            if (cleanNumber > cleanChangeNumber) {
                
                cleanNumber = cleanNumber - cleanChangeNumber;
            } else {
                
                cleanNumber = 0;
            }
            endCleanNumberTime = time;
        }
    }

    if (expNumber == 0.0) {

        endExpNumberTime = time;
    } else {
        int extInt = (int)expNumberTime;
        int number = extInt / HippoExpTime;
        if (number > 0) {

            float expChangeNumber = 0.1 * (float)number;
            if (expNumber > expChangeNumber) {

                expNumber = expNumber - expChangeNumber;
            } else {

                expNumber = 0;
            }
            endExpNumberTime = time;
        }
    }

    if (moodNumber == 0.0) {

        int number = (int)moodNumberTime / HippoShitTime;
        if (number > 0) {

            int entNumber = shitNumber + number;
            shitNumber = entNumber;
            endMoodNumberTime = time;
        }
        endShitTime = time;
    } else {
        if (shitNumber > HippoShitNumer) {

            int number = (int)shitNumberTime / HippoMoodTime;
            if (number > 0) {
             
                float moodChangeNumber = 0.1 * (float)number;
                if (moodNumber > moodChangeNumber) {
                    
                    moodNumber = moodNumber - moodChangeNumber;
                } else {
                    
                    moodNumber = 0;
                }
                endShitTime = time;
            }
        }
        int number = (int)moodNumberTime / HippoShitTime;
        if (number > 0) {
  
            int entNumber = shitNumber + number;
            if (entNumber == HippoShitNumer + 1) {
                shitNumber = entNumber;
                endMoodNumberTime = time;
                endShitTime = time;
            } else if (entNumber < HippoShitNumer + 1) {
                shitNumber = entNumber;
                endMoodNumberTime = time;
            } else {
                if (shitNumber <= HippoShitNumer) {
      
                    float endMoodNumber = [self configCurrenShit:shitNumber shitNewNumber:number];
                    moodNumber = moodNumber - endMoodNumber;
                    if (moodNumber < 0.0) {
                        moodNumber = 0.0;
                    }
                    endShitTime = time;
                }
                shitNumber = entNumber;
                endMoodNumberTime = time;
            }
        }
    }

    int number = (int)actionNumberTime / HippoDownTime;
    if (number > 0 ) {
        endActionNumberTime = time;
        endDownStatus = @"1";
    }

    [[HippoToolManager shareInstance] updateDataId:@"1" actionTime:endActionNumberTime changeExpTime:endExpNumberTime changeMoodTime:endMoodNumberTime food:foodNumber exp:expNumber mood:moodNumber clean:cleanNumber shitNumber:shitNumber downStatus:endDownStatus changeShitTime:endShitTime];
    if (self.chooseBtnViewBlock) {
        self.chooseBtnViewBlock(moodNumber,foodNumber,expNumber,cleanNumber,shitNumber);
    }

}

- (void)configDataWithClearShitSuccess:(void (^)(float mood,float food,float exp,float clean))clearShitSuccess {
    HippoModel *model = [[HippoManager shareInstance] configDataWithModel];
    float moodNumber = model.mood;
    float foodNumber = model.food;
    float expNumber = model.exp;
    float cleanNumber = model.clean;
    int16_t shitNumber = model.shitNumber;
    NSString *endDownStatus = model.downStatus;
    NSString *endExpNumberTime = model.changeExpTime;
    NSString *endMoodNumberTime = model.changeMoodTime;
    NSString *endActionNumberTime = model.actionTime;
    NSString *endShitTime = model.changeShitTime;
    shitNumber = 0;
    endShitTime = [[HippoToolManager shareInstance] getCurrentTiem];
    endMoodNumberTime = [[HippoToolManager shareInstance] getCurrentTiem];
    
    if (cleanNumber <= 0 || expNumber < 0.1) {
        
    } else {
        cleanNumber = 1.0;
        expNumber = expNumber - 0.1;
    }
    
    [[HippoToolManager shareInstance] updateDataId:@"1" actionTime:endActionNumberTime changeExpTime:endExpNumberTime changeMoodTime:endMoodNumberTime food:foodNumber exp:expNumber mood:moodNumber clean:cleanNumber shitNumber:shitNumber downStatus:endDownStatus changeShitTime:endShitTime];
    clearShitSuccess(moodNumber,foodNumber,expNumber,cleanNumber);
}


- (void)configStandUpChangeTime {
    HippoModel *model = [[HippoManager shareInstance] configDataWithModel];
    float moodNumber = model.mood;
    float foodNumber = model.food;
    float expNumber = model.exp;
    float cleanNumber = model.clean;
    int16_t shitNumber = model.shitNumber;
    NSString *endDownStatus = model.downStatus;
    NSString *endExpNumberTime = model.changeExpTime;
    NSString *endMoodNumberTime = model.changeMoodTime;
    NSString *endActionNumberTime = model.actionTime;
    NSString *endShitTime = model.changeShitTime;
    endActionNumberTime = [[HippoToolManager shareInstance] getCurrentTiem];
    endDownStatus = @"0";

    [[HippoToolManager shareInstance] updateDataId:@"1" actionTime:endActionNumberTime changeExpTime:endExpNumberTime changeMoodTime:endMoodNumberTime food:foodNumber exp:expNumber mood:moodNumber clean:cleanNumber shitNumber:shitNumber downStatus:endDownStatus changeShitTime:endShitTime];
}

- (void)configDataWithEatSuccess:(void (^)(float mood,float food,float exp,float clean))eatSuccess eatFailure: (void (^)(void))eatFailure {
    HippoModel *model = [[HippoToolManager shareInstance] readData];
    float moodNumber = model.mood;
    float foodNumber = model.food;
    float expNumber = model.exp;
    float cleanNumber = model.clean;
    int16_t shitNumber = model.shitNumber;
    NSString *endDownStatus = model.downStatus;
    NSString *endExpNumberTime = model.changeExpTime;
    NSString *endMoodNumberTime = model.changeMoodTime;
    NSString *endActionNumberTime = model.actionTime;
    NSString *endShitTime = model.changeShitTime; 
    if (foodNumber < 0.3 || expNumber > 0.95) {
        eatFailure();
    } else {
        foodNumber = foodNumber - 0.3;
        expNumber = expNumber + 0.1;
        [[HippoToolManager shareInstance] updateDataId:@"1" actionTime:endActionNumberTime changeExpTime:endExpNumberTime changeMoodTime:endMoodNumberTime food:foodNumber exp:expNumber mood:moodNumber clean:cleanNumber shitNumber:shitNumber downStatus:endDownStatus changeShitTime:endShitTime];
        eatSuccess(moodNumber,foodNumber,expNumber,cleanNumber);
    }
    
}


- (void)configDataWithAddFood:(CGFloat)food foodSuccess:(void (^)(float mood,float food,float exp,float clean))foodSuccess  {
    HippoModel *model = [[HippoToolManager shareInstance] readData];
    float moodNumber = model.mood;
    float foodNumber = model.food;
    float expNumber = model.exp;
    float cleanNumber = model.clean;
    int16_t shitNumber = model.shitNumber;
    NSString *endDownStatus = model.downStatus;
    NSString *endExpNumberTime = model.changeExpTime;
    NSString *endMoodNumberTime = model.changeMoodTime;
    NSString *endActionNumberTime = model.actionTime;
    NSString *endShitTime = model.changeShitTime;
    foodNumber = foodNumber + food;
    if (foodNumber > 0.95) {
        foodNumber = 1.0;
    }
    [[HippoToolManager shareInstance] updateDataId:@"1" actionTime:endActionNumberTime changeExpTime:endExpNumberTime changeMoodTime:endMoodNumberTime food:foodNumber exp:expNumber mood:moodNumber clean:cleanNumber shitNumber:shitNumber downStatus:endDownStatus changeShitTime:endShitTime];
    foodSuccess(moodNumber,foodNumber,expNumber,cleanNumber);
}


- (void)configDataWithAddMood:(CGFloat)mood moodSuccess:(void (^)(float mood,float food,float exp,float clean))moodSuccess {
    HippoModel *model = [[HippoToolManager shareInstance] readData];
    float moodNumber = model.mood;
    float foodNumber = model.food;
    float expNumber = model.exp;
    float cleanNumber = model.clean;
    int16_t shitNumber = model.shitNumber;
    NSString *endDownStatus = model.downStatus;
    NSString *endExpNumberTime = model.changeExpTime;
    NSString *endMoodNumberTime = model.changeMoodTime;
    NSString *endActionNumberTime = model.actionTime;
    NSString *endShitTime = model.changeShitTime;
    moodNumber = moodNumber + mood;
    if (moodNumber > 0.95) {
        moodNumber = 0.95;
    }
    [[HippoToolManager shareInstance] updateDataId:@"1" actionTime:endActionNumberTime changeExpTime:endExpNumberTime changeMoodTime:endMoodNumberTime food:foodNumber exp:expNumber mood:moodNumber clean:cleanNumber shitNumber:shitNumber downStatus:endDownStatus changeShitTime:endShitTime];
    moodSuccess(moodNumber,foodNumber,expNumber,cleanNumber);
}

- (float)configCurrenShit:(int)shitNumber shitNewNumber:(int)shitNewNumber {
    
    int chatShitNumber = shitNumber + shitNewNumber - HippoShitNumer - 1;
    int changeNumber = HippoShitTime * chatShitNumber / HippoMoodTime;
    return 0.1 * changeNumber;
}

- (void)resetData
{
    HippoModel *model = [[HippoToolManager shareInstance] readData];
//    float moodNumber = model.mood;
    float foodNumber = model.food;
//    float expNumber = model.exp;
//    float cleanNumber = model.clean;
    int16_t shitNumber = model.shitNumber;
    NSString *endDownStatus = model.downStatus;
    NSString *endExpNumberTime = model.changeExpTime;
    NSString *endMoodNumberTime = model.changeMoodTime;
    NSString *endActionNumberTime = model.actionTime;
    NSString *endShitTime = model.changeShitTime;
    [[HippoToolManager shareInstance] updateDataId:@"1" actionTime:endActionNumberTime changeExpTime:endExpNumberTime changeMoodTime:endMoodNumberTime food:foodNumber exp:1.0 mood:1.0 clean:1.0 shitNumber:shitNumber downStatus:endDownStatus changeShitTime:endShitTime];
}

@end
