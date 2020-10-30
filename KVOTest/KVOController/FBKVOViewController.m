//
//  FBKVOViewController.m
//  KVOTest
//
//  Created by GC on 2020/10/30.
//

#import "FBKVOViewController.h"
#import "NSObject+FBKVOController.h"
#import "TestFB.h"

@interface FBKVOViewController ()

@property(nonatomic, strong) TestFB *test;

@end

@implementation FBKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.test = [[TestFB alloc] init];
    
    //观察自己属性时用self.KVOController会造成循环引用，所以要用self.KVOControllerNonRetaining来观察属性test
    [self.KVOControllerNonRetaining observe:self keyPath:@"test" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"%@", change);
    }];
    //使用self.KVOController让self.test观察它的count属性不会造成循环引用
    [self.KVOController observe:self.test keyPath:@"count" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"%@", change);
    }];

    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    NSLog(@"FBKVOViewController dealloc");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.test.count = arc4random() % 10;
    self.test = [[TestFB alloc] init];
}

@end
