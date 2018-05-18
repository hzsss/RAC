//
//  HZSFlag.h
//  RAC
//
//  Created by 灿灿 on 2018/5/18.
//  Copyright © 2018年 HZSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZSFlag : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)flagWithDict:(NSDictionary *)dict;
@end
