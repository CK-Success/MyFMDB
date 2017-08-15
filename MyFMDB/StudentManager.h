//
//  StudentManager.h
//  MyFMDB
//
//  Created by NewBest_RD on 2017/8/10.
//  Copyright © 2017年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
//#import "FMDatabase.h"
#import "FMDB.h"
@interface StudentManager : NSObject
@property(nonatomic,strong)FMDatabase * dataBase;
@property(nonatomic,strong)FMDatabaseQueue * queque;

//{
//    FMDatabase * _dataBase;
//    FMDatabaseQueue * _queque;
//    
//}

//懒加载
- (FMDatabase*)dataBase;

+(StudentManager *)shareManager;

-(BOOL)add:(Student *)student;
-(BOOL)delete:(Student *)student;
-(BOOL)change:(Student *)student;
-(NSMutableArray *)fetch;



@end
