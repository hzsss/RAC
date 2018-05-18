//
//  HZSFirstController.h
//  RAC
//
//  Created by 灿灿 on 2018/5/18.
//  Copyright © 2018年 HZSS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface HZSFirstController : UIViewController
@property (nonatomic, strong) RACSubject *delegateSignal;

@end
