//
//  TestViewController.m
//  KVOTest
//
//  Created by GC on 2020/10/28.
//

#import "TestViewController.h"
#import "Test.h"
#import "SubTest.h"

@interface TestViewController ()

@property(nonatomic, strong) Test *test;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.test = [[Test alloc] init];
    [Test printSubClasses:[Test class]];
    [self.test addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld context:NULL];
    [Test printSubClasses:[Test class]];
    [Test printAllInstacnseMethod:[SubTest class]];
    [Test printAllInstacnseMethod: NSClassFromString(@"NSKVONotifying_Test")];
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    [self.test removeObserver:self forKeyPath:@"name" context:NULL];
    NSLog(@"TestViewController dealloc");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.test.name = [NSString stringWithFormat:@"%d", arc4random() % 10];
//    self.test->_memberName = @"10";
}

@end
