//
//  TestA.m
//  KVOTest
//
//  Created by GC on 2020/10/27.
//

#import "TestA.h"
#import "TestB.h"

static NSString *k_testA_bArray = @"bArray";
static NSString *k_testA_totalCount = @"totalCount";
static NSString *k_testB_count = @"count";
static void *k_testA_bArrayContext = &k_testA_bArrayContext;
@interface TestA () {
    NSNumber *_totalCount;
}

@property (nonatomic, strong) NSMutableArray<TestB *> *bArray;

@end

@implementation TestA

#pragma mark - 生命周期

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bArray = [NSMutableArray arrayWithCapacity:0];
        [self addObserver:self forKeyPath:k_testA_bArray options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:k_testA_bArrayContext];
    }
    return self;
}

- (void)dealloc
{
    [self removeAllObserverForTestB];
    [self removeObserver:self forKeyPath:k_testA_bArray context:k_testA_bArrayContext];
    NSLog(@"TestA dealloc");
}

#pragma mark - 数组names操作

- (NSUInteger)bArrayCount {
    return self.bArray.count;
}

- (void)replaceTestBCountAtIndex:(NSUInteger)index withCount: (int)count {
    if (index < self.bArray.count) {
        ((TestB *)[self.bArray objectAtIndex:index]).count = count;
    } else {
        NSAssert(index<self.bArray.count, @"index>=bArray.count, 越界");
    }
}

- (void)addTestB:(int)count {
    TestB *b = [[TestB alloc] init];
    b.count = count;
    [b addObserver:self forKeyPath:k_testB_count options:NSKeyValueObservingOptionNew context:k_testA_bArrayContext];
    [[self mutableArrayValueForKey:k_testA_bArray] addObject:b];
}

- (void)removeTestBAtIndex: (NSUInteger)index {
    if (index < self.bArray.count) {
        TestB *b = [[self mutableArrayValueForKey:k_testA_bArray] objectAtIndex:index];
        [b removeObserver:self forKeyPath:k_testB_count context:k_testA_bArrayContext];
        [[self mutableArrayValueForKey:k_testA_bArray] removeObjectAtIndex:index];
    } else {
        NSAssert(index<self.bArray.count, @"index>=bArray.count, 越界");
    }
}

#pragma mark - KVO

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:k_testA_totalCount]) {
        return NO;
    } else {
       return [super automaticallyNotifiesObserversForKey:key];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == k_testA_bArrayContext) {
        [self updatetotalCount];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)removeAllObserverForTestB {
    for (TestB *b in self.bArray) {
        [b removeObserver:self forKeyPath:k_testB_count context:k_testA_bArrayContext];
    }
}

#pragma mark KVO Helper
- (void)updatetotalCount {
    [self setTotalCount:[self valueForKeyPath:[NSString stringWithFormat:@"%@.@sum.%@", k_testA_bArray, k_testB_count]]];
}

#pragma mark - Getter/Setter

- (NSNumber *)totalCount {
    return _totalCount;
}

- (void)setTotalCount:(NSNumber *)totalCount {
    if (_totalCount != totalCount) {
        [self willChangeValueForKey:k_testA_totalCount];
        _totalCount = totalCount;
        [self didChangeValueForKey:k_testA_totalCount];
    }
}
@end
