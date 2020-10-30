//
//  TestAViewController.m
//  KVOTest
//
//  Created by GC on 2020/10/27.
//

#import "TestAViewController.h"
#import "TestA.h"

static void *k_TestAVC_totalCountContext = &k_TestAVC_totalCountContext;
static NSString *k_TestAVC_totalCount = @"totalCount";
@interface TestAViewController ()

@property (nonatomic, strong) TestA *testA;

@end

@implementation TestAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testA = [[TestA alloc] init];
    [self.testA addTestB:10];
    [self.testA addTestB:20];
    [self.testA addTestB:30];
    [self.testA addObserver:self forKeyPath:k_TestAVC_totalCount options:NSKeyValueObservingOptionNew context:k_TestAVC_totalCountContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == k_TestAVC_totalCountContext) {
        if ([keyPath isEqualToString:k_TestAVC_totalCount]) {
            NSLog(@"totalCount is %@", self.testA.totalCount);
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.testA.bArrayCount > arc4random() % 10) {
        int index = arc4random() % self.testA.bArrayCount;
        if (self.testA.bArrayCount > 5) {
            [self.testA removeTestBAtIndex:index];
        } else {
            [self.testA replaceTestBCountAtIndex:index withCount: arc4random() % 10];
        }
    } else {
        [self.testA addTestB:arc4random() % 100];
    }
}

- (void)dealloc
{
    [self.testA removeObserver:self forKeyPath: k_TestAVC_totalCount context:k_TestAVC_totalCountContext];
}

@end
