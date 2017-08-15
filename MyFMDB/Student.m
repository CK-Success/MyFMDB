//
//  Student.m
//  MyFMDB
//
//  Created by NewBest_RD on 2017/8/10.
//  Copyright © 2017年 Jerry. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString *)description {
    return [NSString stringWithFormat:@"sid:%@ name:%@ age:%d image:%ld", self.sid, self.name, self.age,UIImagePNGRepresentation(self.image).length];
}

//- (NSString *)description {
//    return [NSString stringWithFormat:@"sid:%@ name:%@ age:%d", self.sid, self.name, self.age];
//}


@end
