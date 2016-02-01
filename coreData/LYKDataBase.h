//
//  LYKDataBase.h
//  coreData
//
//  Created by ws on 16/1/29.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface LYKDataBase : NSObject
+ (instancetype)shardDataBase;

- (id)creatModelWith:(Class)modelClass;

- (void)deleteDataWithModelClass:(Class)modelClass predicate:(NSPredicate *)predicate;


/**
 *  读取
 */
- (NSArray *)readDataWithModelClass:(Class)modelClass;

/**
 *  插入数据
 */
- (void)insertObjectToSqlist:(id)model;

@end
