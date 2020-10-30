//
//  Test.m
//  KVOTest
//
//  Created by GC on 2020/10/28.
//

#import "Test.h"
#import <objc/runtime.h>

@implementation Test

+ (void)printSubClasses:(Class)cls{
    // 注册类的总数
    int count = objc_getClassList(NULL, 0);
    // 创建一个数组
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:3];
    // 获取所有已注册的类
    Class* classes = (Class*)malloc(sizeof(Class)*count);
    objc_getClassList(classes, count);
    for (int i = 0; i<count; i++) {
        if (cls == class_getSuperclass(classes[i])) {
            [mArray addObject:classes[i]];
        }
    }
    free(classes);
    NSLog(@"%@'s subClasses = %@", NSStringFromClass(cls), mArray);
    
}


+ (void)printAllInstacnseMethod:(Class)cls{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i<count; i++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        IMP imp = class_getMethodImplementation(cls, sel);
        NSLog(@"%@--->%@-%p", NSStringFromClass(cls), NSStringFromSelector(sel),imp);
    }
    free(methodList);
}
@end
