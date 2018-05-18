//
//  ViewController.m
//  RAC
//
//  Created by 灿灿 on 2018/5/18.
//  Copyright © 2018年 HZSS. All rights reserved.
//

#import "ViewController.h"
#import "HZSFirstController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "HZSFlag.h"

@interface ViewController ()
@property (nonatomic, strong) RACCommand *command;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test4];
}

- (void)test1 { // RACSignal 简单使用
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接受到数据：%@", x);
    }];
}

- (void)test2 { // RACSubject 与 RACReplaySubject
    RACSubject *subject = [RACSubject subject]; // 创建信号
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者：%@", x);
    }]; // 订阅信号
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者：%@", x);
    }];
    
    [subject sendNext:@"1"]; // 发送信号
    
    RACReplaySubject *replaySubject = [RACReplaySubject replaySubjectWithCapacity:10];
    
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者数据：%@", x);
    }];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者数据：%@", x);
    }];
}

- (void)test3 { // RACSequence 和 RACTuple
    // ----- 遍历数组 -----
    NSArray *numbers = @[@1, @2, @3, @4];
    
    [numbers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
        NSLog(@"thread : %@", [NSThread currentThread]);
    }];
    
    // ----- 遍历字典 -----
    NSDictionary *dict = @{
                           @"name" : @"hzs",
                           @"age" : @18
                           };
    
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key, NSString *value) = x;
        
        NSLog(@"%@ %@", key, value);
    }];
    
     // ----- 字典转模型 -----
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *flags = [NSMutableArray array];
    
    [dictArray.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        HZSFlag *flag  = [HZSFlag flagWithDict:x];
        
        [flags addObject:flag];
    }];
    
    // ----- RAC 高级写法 -----
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArray2 = [NSArray arrayWithContentsOfFile:filePath];
    
    NSArray *flags2 = [[dictArray2.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [HZSFlag flagWithDict:value];
    }] array];
    
}

- (IBAction)jumpToFirstVc:(id)sender {
    HZSFirstController *firstVc = [[HZSFirstController alloc] init];
    firstVc.delegateSignal = [RACSubject subject];
    
    [firstVc.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"点击了通知按钮");
    }];
    [self presentViewController:firstVc animated:YES completion:nil];
}

- (void)test4 {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令");
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"请求数据"];
            
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
    _command = command;
    
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@", x);
        }];
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            NSLog(@"正在执行");
        } else {
            NSLog(@"执行完成");
        }
    }];
    
    [self.command execute:@1];
}

@end
