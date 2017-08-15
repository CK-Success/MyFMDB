//
//  Student.h
//  MyFMDB
//
//  Created by NewBest_RD on 2017/8/10.
//  Copyright © 2017年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKIT/UIKIT.h>
@interface Student : NSObject

@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) int  age;
@property (nonatomic, copy) UIImage  *image;

@end
