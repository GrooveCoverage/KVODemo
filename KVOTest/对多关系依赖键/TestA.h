//
//  TestA.h
//  KVOTest
//
//  Created by GC on 2020/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestA : NSObject

@property (nonatomic, strong, readonly) NSNumber *totalCount;

- (NSUInteger)bArrayCount;
- (void)addTestB:(int)count;
- (void)removeTestBAtIndex: (NSUInteger)index;
- (void)replaceTestBCountAtIndex:(NSUInteger)index withCount: (int)count;

@end

NS_ASSUME_NONNULL_END
