//
//  HZSFlag.m
//  RAC
//
//  Created by 灿灿 on 2018/5/18.
//  Copyright © 2018年 HZSS. All rights reserved.
//

#import "HZSFlag.h"

@implementation HZSFlag
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)flagWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end
