//
//  JSUserDefaultTool.m
//  Planner Pet
//
//  Created by Mr_Jesson on 2019/4/26.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import "JSUserDefaultTool.h"
#import "HippoManager.h"


@implementation JSUserDefaultTool

+ (void)initUserDefaultTool
{
    //记录上次app的打开时间
    if ([USER_DEFAULTS objectForKey:@"lastTime"]) {
        NSString *lastTime = [USER_DEFAULTS objectForKey:@"lastTime"];
        NSString *currentTime = [JSUserDefaultTool getNowTimeTimestamp];
        //对比本次时间和上次时间是不是同一天
        if (![JSUserDefaultTool isSameDay:[lastTime longLongValue] Time2:[currentTime longLongValue]]) {//不是同一天
            [[HippoManager shareInstance] resetData];
            [AppDelegate App].isNotToday = YES;
        }
    }
}

+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}


+ (BOOL)isSameDay:(long)iTime1 Time2:(long)iTime2
{
    //传入时间毫秒数
    NSDate *pDate1 = [NSDate dateWithTimeIntervalSince1970:iTime1/1000];
    NSDate *pDate2 = [NSDate dateWithTimeIntervalSince1970:iTime2/1000];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:pDate1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:pDate2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}


/**
 *  是否是当天第一次
 */
+(BOOL)isTodayFirst{
    
    NSDate *now = [NSDate date];
    //当前时间的时间戳
    NSTimeInterval nowStamp = [now timeIntervalSince1970];
    //当天零点的时间戳
    NSTimeInterval zeroStamp = [[[NSUserDefaults standardUserDefaults] objectForKey:@"zeroStamp"] doubleValue];
    //一天的时间戳
    NSTimeInterval oneDay = 60* 60 * 24;
    
    /**
     "showedLocation"代表了是否当天是否提醒过开启定位，NO代表没有提醒过，YES代表已经提醒过
     */
    
    if(nowStamp - zeroStamp> oneDay){
        
        zeroStamp = [JSUserDefaultTool getTodayZeroStampWithDate:now];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:zeroStamp] forKey:@"zeroStamp"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"showedLocation"];
        return YES;
        
    }else{
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showedLocation"]) {
            return NO;
            
        }else{
            return YES;
        }
        
    }
    
}

/**
 * 获取当天零点时间戳
 */
+ (double)getTodayZeroStampWithDate:(NSDate *)date{
    
    NSDateFormatter *dateFomater = [[NSDateFormatter alloc]init];
    dateFomater.dateFormat = @"yyyy年MM月dd日";
    NSString *original = [dateFomater stringFromDate:date];
    NSDate *ZeroDate = [dateFomater dateFromString:original];
    // 今天零点的时间戳
    NSTimeInterval zeroStamp = [ZeroDate timeIntervalSince1970];
    return zeroStamp;
    
}

+ (BOOL)isCanShit
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dayStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *time1 = [NSString stringWithFormat:@"%@ 00:00:00",dayStr];
    
    NSString *time2 = [NSString stringWithFormat:@"%@ 06:00:00",dayStr];
    
    NSString *time3 = [NSString stringWithFormat:@"%@ 12:00:00",dayStr];
    
    NSString *time4 = [NSString stringWithFormat:@"%@ 18:00:00",dayStr];
    
    if ([JSUserDefaultTool compareOneDay:[NSDate date] withAnotherDay:[JSUserDefaultTool stringToDate:time1]]) {
        return YES;
    }
    
    if ([JSUserDefaultTool compareOneDay:[NSDate date] withAnotherDay:[JSUserDefaultTool stringToDate:time2]]) {
        return YES;
    }
    
    if ([JSUserDefaultTool compareOneDay:[NSDate date] withAnotherDay:[JSUserDefaultTool stringToDate:time3]]) {
        return YES;
    }
    
    if ([JSUserDefaultTool compareOneDay:[NSDate date] withAnotherDay:[JSUserDefaultTool stringToDate:time4]]) {
        return YES;
    }

    return NO;
}

+ (NSDate *)stringToDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-mm-dd hh:mm:ss";
    NSLog(@"%@",[dateFormatter dateFromString:dateStr]);
    return [dateFormatter dateFromString:dateStr];
}

#pragma mark -得到当前时间date
+ (NSDate *)getCurrentTime
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}

+ (BOOL)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
        NSLog(@"oneDay  is in the future");
        return NO;
    }
    else if (result == NSOrderedAscending){
        //没过指定时间 没过期
        //NSLog(@"Date1 is in the past");
        return NO;
    }
    //刚好时间一样.
    //NSLog(@"Both dates are the same");
    return YES;
    
}



@end
