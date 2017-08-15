//
//  StudentManager.m
//  MyFMDB
//
//  Created by NewBest_RD on 2017/8/10.
//  Copyright © 2017年 Jerry. All rights reserved.
//

#import "StudentManager.h"

static StudentManager * _manager=nil;

@implementation StudentManager

+(StudentManager *)shareManager{

    @synchronized (self) {//同步线程
        if (_manager==nil) {
            _manager=[[StudentManager alloc]init];
            
        }
    }
    
    return _manager;

}

- (id)init {
    self=[super init];
    if (!self) {
       return nil;
    }

    if ([self.dataBase open]) {
        
        [self createTable];
    }
    
    return self;
}

-(NSString *)databasePath{
//起的数据库的名字千万别和已知类的名字重复，否则数据库会创造失败
    NSString * dbpath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"StudentInfo.db"];
    return dbpath;

}

//懒加载
- (FMDatabase*)dataBase{//_dataBase和self.dataBase的区别：self.dataBase回调用get方法但是_dataBase不会；在这个方法里若是使用self.dataBase会陷入死循环无限调用get方法。
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:[self databasePath]];
    }
    return _dataBase;
}

-(BOOL) openDB{

    if ([self.dataBase open]) {
        return YES;
    }
    return NO;

}

-(BOOL)createTable{

    NSString * createSql=@"create table if not exists StudentInfo(sid varchar(128),name text,age integer,image blob)";// blob：存放二进制，data
//    NSString * createSql=@"create table if not exists StudentInfo(sid varchar(128),name text,age integer)";// blob：存放二进制，data
    BOOL isSuccess = false;
    // 打开数据库文件，如果这个文件（dbPath）原来是存在的, 则直接打开，不会破坏原来的内容
    // 如果不存在，则自动创建一个空的数据库文件
    if ([self.dataBase open]) {
        isSuccess=[self.dataBase executeUpdate:createSql];
    }
        [self.dataBase close];
    NSLog(@"%@",isSuccess==YES?@"创建成功":@"创建失败");
    return isSuccess;

}

-(BOOL)add:(Student *)student{

    if (![self.dataBase open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    NSString * insertSql=@"insert into StudentInfo values(?,?,?,?)";
    BOOL isSuccess=[_dataBase executeUpdate:insertSql,student.sid,student.name,[NSNumber numberWithInteger:student.age],UIImagePNGRepresentation(student.image)];
    if (!isSuccess){
        NSLog(@"添加数据失败");
    }
    
    [self.dataBase close];
    
    NSLog(@"%@",isSuccess==YES?@"++成功":@"++失败");
    return isSuccess;
    
}

-(BOOL)delete:(Student *)student{
    
    return [self deleteByID:student.sid];
    
}

-(BOOL)deleteByID:(NSString *)iid{

    if (![self.dataBase open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    NSString * deleteSql=@"delete from StudentInfo where sid = ?";
    BOOL isSuccess=[self.dataBase executeUpdate:deleteSql,iid];
    if(!isSuccess){
      NSLog(@"删除指定ID数据失败");
    }
    
    [self.dataBase close];
    return isSuccess;

}

-(BOOL)change:(Student *)student{
    
    if (![self.dataBase open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    NSString * changeSql=@"update StudentInfo set name=?,age=?, image=? where sid=?";
    //student.name,[NSNumber numberWithInteger:student.age],student.image,student.sid的顺序必须和name=?,age=? where sid=?顺序一致否则会更改失败。
    BOOL isSuccess=[_dataBase executeUpdate:changeSql,student.name,[NSNumber numberWithInteger:student.age],UIImagePNGRepresentation(student.image),student.sid];
    if (!isSuccess) {
        NSLog(@"更改数据库失败");
    }
    [self.dataBase close];
    return isSuccess;
    
}

-(NSMutableArray *)fetch{
    if (![self.dataBase open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    NSMutableArray * StudentArray=[[NSMutableArray alloc]init];
    
    NSString * fetchSql=@"select * from StudentInfo";
    FMResultSet * set=[self.dataBase executeQuery:fetchSql];
    while ([set next]) {
        Student *student=[[Student alloc]init];
        student.sid=[set stringForColumn:@"sid"];
        student.name=[set stringForColumn:@"name"];
        student.age=[set intForColumn:@"age"];
        student.image=[UIImage imageWithData:[set dataForColumn:@"image"]];
        [StudentArray addObject:student];
        
    }
    NSLog(@"StudentArray====%@",StudentArray);
    [self.dataBase close];
    return StudentArray;
    
}



@end
