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



@end
