//
//  HippoToolManager.m
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/13.
//  Copyright © 2019 xlkd 24. All rights reserved.
//

#import "HippoToolManager.h"
#import <CoreData/CoreData.h>


@interface HippoToolManager ()
{
    NSManagedObjectContext * _context;
}

@end

@implementation HippoToolManager

static HippoToolManager* _instance = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

- (NSString *)getCurrentTiem {
//    let date = Date()
//
//    // GMT时间转时间戳 没有时差，直接是系统当前时间戳
//
//    return date.timeIntervalSince1970
    NSDate *date = [[NSDate alloc]init];
    
    return [NSString stringWithFormat:@"%lf",[date timeIntervalSince1970]];
}

//创建数据库
- (void)createSqlite{
    
    //1、创建模型对象
    //获取模型路径
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HippoPlayModel" withExtension:@"momd"];
    //根据模型文件创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    //2、创建持久化存储助理：数据库
    //利用模型对象创建助理对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //数据库的名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
    NSLog(@"数据库 path = %@", sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    NSError *error = nil;
    //设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    
    if (error) {
        NSLog(@"添加数据库失败:%@",error);
    } else {
        NSLog(@"添加数据库成功");
    }
    
    //3、创建上下文 保存信息 操作数据库
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //关联持久化助理
    context.persistentStoreCoordinator = store;
    
    _context = context;
}


#pragma mark -- 数据处理

/**
 插入数据

 @param hippoId id
 @param actionTime 河马是否趴下时间
 @param changeExpTime 开始饥饿度时间
 @param changeMoodTime 开始影响心情时间
 @param food 食物
 @param exp 饱程度
 @param mood 心情
 @param shitNumber 屎数量
 @param downStatus 河马是否趴下
 @param changeShitTime 开始拉屎时间
 */
- (void)insertDataId:(NSString *)hippoId actionTime:(NSString *)actionTime changeExpTime:(NSString *)changeExpTime changeMoodTime:(NSString *)changeMoodTime food:(CGFloat)food exp:(CGFloat)exp mood:(CGFloat)mood shitNumber:(NSInteger)shitNumber downStatus:(NSString *)downStatus changeShitTime:(NSString *)changeShitTime {
    
    
    // 1.根据Entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类Student
    
    HippoModel * model = [NSEntityDescription
                         insertNewObjectForEntityForName:@"HippoModel"
                         inManagedObjectContext:_context];
    NSLog(@"%@",model);
    
    //  2.根据表Student中的键值，给NSManagedObject对象赋值
    model.hippoId = hippoId;
    model.actionTime = actionTime;
    model.changeExpTime = changeExpTime;
    model.changeMoodTime = changeMoodTime;
    model.food = food;
    model.exp = exp;
    model.mood = mood;
    model.shitNumber = shitNumber;
    model.downStatus = downStatus;
    model.changeShitTime = changeShitTime;
    
    NSLog(@"%@",model);
    //   3.保存插入的数据
    NSError *error = nil;
    if ([_context save:&error]) {
        NSLog(@"数据插入到数据库成功");
    }else{
        NSLog(@"数据插入到数据库失败");
    }
    
}

//更新，修改
- (void)updateData{
    
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HippoModel"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"hippoId = %@", @"1"];
    request.predicate = pre;
    
    //发送请求
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
    //修改
    for (HippoModel *stu in resArray) {
        stu.hippoId = @"且行且珍惜_iOS";
    }
    
    //保存
    NSError *error = nil;
    if ([_context save:&error]) {
        NSLog(@"数据插入到数据库成功");
    }else{
        NSLog(@"数据插入到数据库失败");
    }
}

//读取查询
- (HippoModel *)readData{
    
    
    /* 谓词的条件指令
     1.比较运算符 > 、< 、== 、>= 、<= 、!=
     例：@"number >= 99"
     
     2.范围运算符：IN 、BETWEEN
     例：@"number BETWEEN {1,5}"
     @"address IN {'shanghai','nanjing'}"
     
     3.字符串本身:SELF
     例：@"SELF == 'APPLE'"
     
     4.字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
     例：  @"name CONTAIN[cd] 'ang'"  //包含某个字符串
     @"name BEGINSWITH[c] 'sh'"    //以某个字符串开头
     @"name ENDSWITH[d] 'ang'"    //以某个字符串结束
     
     5.通配符：LIKE
     例：@"name LIKE[cd] '*er*'"   //*代表通配符,Like也接受[cd].
     @"name LIKE[cd] '???er*'"
     
     *注*: 星号 "*" : 代表0个或多个字符
     问号 "?" : 代表一个字符
     
     6.正则表达式：MATCHES
     例：NSString *regex = @"^A.+e$"; //以A开头，e结尾
     @"name MATCHES %@",regex
     
     注:[c]*不区分大小写 , [d]不区分发音符号即没有重音符号, [cd]既不区分大小写，也不区分发音符号。
     
     7. 合计操作
     ANY，SOME：指定下列表达式中的任意元素。比如，ANY children.age < 18。
     ALL：指定下列表达式中的所有元素。比如，ALL children.age < 18。
     NONE：指定下列表达式中没有的元素。比如，NONE children.age < 18。它在逻辑上等于NOT (ANY ...)。
     IN：等于SQL的IN操作，左边的表达必须出现在右边指定的集合中。比如，name IN { 'Ben', 'Melissa', 'Nick' }。
     
     提示:
     1. 谓词中的匹配指令关键字通常使用大写字母
     2. 谓词中可以使用格式字符串
     3. 如果通过对象的key
     path指定匹配条件，需要使用%K
     
     */
    //查询所有数据的请求
    
    
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HippoModel"];
    
    //查询条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"hippoId = %@", @"1"];
//    NSPredicate *pre = [[NSPredicate alloc]init];
    request.predicate = pre;
    
    
    //发送查询请求,并返回结果
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
    if (resArray.count > 0) {
        return [resArray firstObject];
    }
    NSLog(@"%ld",resArray.count);
    return nil;
}


@end
