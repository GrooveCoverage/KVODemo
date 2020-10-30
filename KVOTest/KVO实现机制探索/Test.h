//
//  Test.h
//  KVOTest
//
//  Created by GC on 2020/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject {
    @public
    NSString *_memberName;
}

@property(nonatomic, copy) NSString *name;

+ (void)printSubClasses:(Class)cls;
+ (void)printAllInstacnseMethod: (Class)cls;

@end

NS_ASSUME_NONNULL_END
