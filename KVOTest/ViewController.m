//
//  ViewController.m
//  KVOTest
//
//  Created by GC on 2020/10/27.
//

#import "ViewController.h"
#import "Test.h"

@interface ViewController ()

@property(nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [Test printSubClasses:[Test class]];
}

@end
