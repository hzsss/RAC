//
//  HZSFirstController.m
//  RAC
//
//  Created by 灿灿 on 2018/5/18.
//  Copyright © 2018年 HZSS. All rights reserved.
//

#import "HZSFirstController.h"

@interface HZSFirstController ()

@end

@implementation HZSFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 200, 200, 100);
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(backToVc) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_delegateSignal) {
        [_delegateSignal sendNext:nil];
    }
}

- (void)backToVc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
