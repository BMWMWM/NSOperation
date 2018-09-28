//
//  ViewController.m
//  NSOperation&NSOperationQueue
//
//  Created by BMW on 2018/4/3.
//  Copyright © 2018年 tsouTSoutsou. All rights reserved.
//

#import "ViewController.h"
#import "BMWOperation.h"
@interface ViewController ()
//余票
@property (nonatomic, assign) NSUInteger ticketSurplusCount;

@property (nonatomic, strong) NSLock *lock;
@end

@implementation ViewController

//通过 使用子类 NSInvocationOperation 封装操作
- (void)useInvocationOperation{
    //创建NSInvocationOperation
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    //调用start开始执行操作
    [op start];
}
- (void)task1{
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1------%@",[NSThread currentThread]);
    }
}

//通过 使用子类 NSBlockOperation 封装操作
- (void)useBlockOperation{
    //创建NSBlockOperation对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    }];
    //调用start 开始执行操作
    [op start];
}

//NSBlockOperation添加额外的操作 addExecutionBlock
- (void)useBlockOperationAndAddExecutionBlock{
    //先创建NSBlockOperation
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
        }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4------%@",[NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"5------%@",[NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"6------%@",[NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"7------%@",[NSThread currentThread]);
        }
    }];
    //开始执行操作
    [op start];
}

//使用自定义继承 NSOperation 的子类
- (void)customOperation{
    BMWOperation *op = [[BMWOperation alloc] init];
    //调用start开始执行操作
    [op start];
}

//将操作添加到队列中
- (void)addOperationToQueue{
    //获取主队列
//    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //创建操作一
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    //创建操作二
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    //创建操作三
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i =  0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    }];
    //给操作三 添加额外 操作
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4------%@",[NSThread currentThread]);
        }
    }];
    
    //添加所有操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}
- (void)task2{
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2------%@",[NSThread currentThread]);
    }
}

//无需创建操作 在block中直接添加操作 直接将包含操作的block添加到队列中
- (void)addOperationWithBlockToQueue{
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //使用addOperationBlock 添加操作到队列中
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4------%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"5------%@",[NSThread currentThread]);
        }
    }];
    
}

//设置最大并发操作数
- (void)setMaxConcurrentOperationCount{
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //设置最大病并发书
//    queue.maxConcurrentOperationCount = 1;
//    queue.maxConcurrentOperationCount = 2;
    queue.maxConcurrentOperationCount = 8;
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4------%@",[NSThread currentThread]);
        }
    }];
    
}

//操作依赖
- (void)addDependncy{
    //创建队列
    NSOperationQueue *queue =  [[NSOperationQueue alloc] init];
    
    //创建操作一
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    }];
    
    //添加操作二
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    }];
    
    //添加依赖
    [op2 addDependency:op1];//op2 依赖于 op1 则先执行 op1 再执行 op2
    
    //添加操作到队列中
    [queue addOperation:op2];
    [queue addOperation:op1];
    
}

//线程间通信
- (void)communication{
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //添加操作
    [queue addOperationWithBlock:^{
        
        for (int i = 0; i < 50; i++) {
            [NSThread sleepForTimeInterval:0.5];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
//        NSLog(@"1------%@",[NSThread currentThread]);
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"2------%@",[NSThread currentThread]);
        
        
    }];
    //回到主线程
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        //进行一些用户交互操作 如UI刷新等
        //        [NSThread sleepForTimeInterval:2];
        for (int i = 0; i < 50; i++) {
            [NSThread sleepForTimeInterval:0.5];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
        //        NSLog(@"3------%@",[NSThread currentThread]);
        //        [NSThread sleepForTimeInterval:2];
        //        NSLog(@"4------%@",[NSThread currentThread]);
    }];
}

//线程同步 和线程安全

/**
 非线程安全 不使用NSLock
 初始化火车票数量 售票窗口（非线程安全）并开始卖票
 */
- (void)initTicketStatusNotSafe{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    
    //初始化最大票数
    self.ticketSurplusCount = 50;
    
    //初始化北京售票窗口（queue1）
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    //设置最大并发数 每次售卖一张票
    queue1.maxConcurrentOperationCount = 1;
    
    //初始化上海售票窗口（queue2）
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    //设置最大并发数
    queue2.maxConcurrentOperationCount = 1;
    
    //创建操作一
    //初始化弱引用
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketNotSafe];
    }];
    
    //创建操作二
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketNotSafe];
    }];
    
    //将操作添加到队列
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}
/**
 售卖火车票（非线程安全）
 */
- (void)saleTicketNotSafe{
    while (1) {
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount --;
            //打印剩余票数 以及当前售票窗口（当前线程）
            NSLog(@"%@",[NSString stringWithFormat:@"剩余票数:%ld 当前窗口%@",self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }else{
            NSLog(@"票已售完");
            //跳出当前方法
            break;
        }
    }
}

/**
 
 线程安全的售票方式 使用NSLock
 
 */
- (void)initTicketStatusSafe{
    //打印当前线程
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    
    //初始化余票数
    self.ticketSurplusCount = 50;
    
    //初始化 NSLock
    self.lock = [[NSLock alloc] init];
    
    //初始化北京售票窗口（queue1）
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    //设置最大并发数
    queue1.maxConcurrentOperationCount = 1;
    
    //初始化上海售票窗口
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    //设置最大并发数
    queue2.maxConcurrentOperationCount = 1;
    
    //初始化操作一
    //初始化弱引用
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    //初始化操作二
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    //将操作添加到队列中
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

/**
 
 开始售票（线程安全）
 
 */
- (void)saleTicketSafe{
    while (1) {
        
        //加锁
        [self.lock lock];
        
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount --;
            NSLog(@"%@",[NSString stringWithFormat:@"剩余票数:%ld 当前窗口%@",self.ticketSurplusCount, [NSThread currentThread]]);
        }else{
            NSLog(@"票已经售完");
            [self.lock unlock];
            break;
        }
        [self.lock unlock];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self useInvocationOperation];
//    [NSThread detachNewThreadSelector:@selector(useInvocationOperation) toTarget:self withObject:nil];//开新线程 调用方法
//    [self useBlockOperation];
//    [NSThread detachNewThreadSelector:@selector(useBlockOperation) toTarget:self withObject:nil];
//    [self useBlockOperationAndAddExecutionBlock];
//    [self customOperation];
//    [self addOperationToQueue];
//    [self addOperationWithBlockToQueue];
//    [self setMaxConcurrentOperationCount];
//    [self addDependncy];
//    [self communication];
    [NSThread detachNewThreadSelector:@selector(communication) toTarget:self withObject:nil];
//    [self initTicketStatusNotSafe];
//    [self initTicketStatusSafe];
    //测试程序走完
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, self.view.frame.size.width - 200, 50)];
    label.text = @"程序已经启动啦！";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
