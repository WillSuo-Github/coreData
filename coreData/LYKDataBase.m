

//
//  LYKDataBase.m
//  coreData
//
//  Created by ws on 16/1/29.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "LYKDataBase.h"
#import <CoreData/CoreData.h>
#import <objc/runtime.h>

@interface LYKDataBase ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation LYKDataBase
+ (instancetype)shardDataBase{
    
    static LYKDataBase *dataBase;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[self alloc] init];
        [dataBase initSqlite];
    });
    return dataBase;
    
}


- (void)initSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"coreData" withExtension:@"momd"];
    
    NSManagedObjectModel *manageModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:manageModel];
    
    /**
     *  创建数据库
     */
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    filePath = [filePath stringByAppendingString:@"coreData.sqlite"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSError *error;
    [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileUrl options:nil error:&error];
    if (error) {
        NSLog(@"创建数据库失败%@",error);
    }else{
        
        NSLog(@"创建数据库成功");
    }
    
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    self.context.persistentStoreCoordinator = psc;
}

/**
 *  插入数据
 */
- (void)insertObjectToSqlist:(id)model{
    
    
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    
//    [fetchRequest setEntity:[NSEntityDescription entityForName:NSStringFromClass([model class]) inManagedObjectContext:self.context]];
//    
//    NSAssert([model valueForKey:@"name"], @"没有查到model的name属性");
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@",[model valueForKey:@"name"]];
//    [fetchRequest setPredicate:predicate];
//    
//    NSError* DeleteError=nil;
//    NSMutableArray* mutableFetchResult=[[self.context executeFetchRequest:fetchRequest error:&DeleteError] mutableCopy];
//    if (mutableFetchResult.count) {
//        NSLog(@"Error:%@",DeleteError);
//    }
//    NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
//    for (id d in mutableFetchResult) {
//        [self.context deleteObject:d];
//    }
//    
//    if ([self.context save:&DeleteError]) {
//        
//        NSLog(@"删除成功");
//    }else{
//        
//        NSLog(@"Error:%@,%@",DeleteError,[DeleteError userInfo]);
//    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@",[model valueForKey:@"name"]];
    
    [self OnlyDeleteDataWithModelClass:[model class] predicate:predicate];
    
   


    NSError *error;
    [self.context insertObject:model];
    [self.context save:&error];
    
    if (error) {
        NSLog(@"插入数据错误%@",error);
    }else{
        
        NSLog(@"插入数据成功");
    }
}


/**
 *  读取
 */
- (NSArray *)readDataWithModelClass:(Class)modelClass{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([modelClass class])];
    
    NSError *error;
    
    if (error) {
        
        NSLog(@"数据库读取错误");
    }else{
        
        return [self.context executeFetchRequest:request error:&error];
    }
    
    return nil;
}

- (void)OnlyDeleteDataWithModelClass:(Class)modelClass predicate:(NSPredicate *)predicate{
    
    
    
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* dog=[NSEntityDescription entityForName:NSStringFromClass(modelClass) inManagedObjectContext:self.context];
    [request setEntity:dog];
    
    
    //    NSAssert([self Class:modelClass IsHaveProperty:PropertyName], @"modelClass类里边没有含有该PropertyName");
    //    NSString *tmpStr = [NSString stringWithFormat:@"%@==",PropertyName];
    //    NSString *predicateStr = [NSString stringWithFormat:@"%@%@",tmpStr,compareName];
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateStr];
    
    //    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"%@==%@",PropertyName,compareName];
    //    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",compareName];
    [request setPredicate:predicate];
    
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult.count) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
//    for (id d in mutableFetchResult) {
//        [self.context deleteObject:d];
//    }
    if (mutableFetchResult.count == 2) {
        [self.context deleteObject:[mutableFetchResult firstObject]];
//        if ([self.context save:&error]) {
//            
//            NSLog(@"删除成功");
//        }else{
//            
//            NSLog(@"Error:%@,%@",error,[error userInfo]);
//        }
    }else if(mutableFetchResult.count > 2){
        
        NSAssert(NO, @"查询出的结果大于2，不科学");
    }else{
        
        NSLog(@"第一次插入");
    }
    
    
    
}

- (void)deleteDataWithModelClass:(Class)modelClass predicate:(NSPredicate *)predicate{
    
    
    
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* dog=[NSEntityDescription entityForName:NSStringFromClass(modelClass) inManagedObjectContext:self.context];
    [request setEntity:dog];
    

//    NSAssert([self Class:modelClass IsHaveProperty:PropertyName], @"modelClass类里边没有含有该PropertyName");
//    NSString *tmpStr = [NSString stringWithFormat:@"%@==",PropertyName];
//    NSString *predicateStr = [NSString stringWithFormat:@"%@%@",tmpStr,compareName];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateStr];
    
//    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"%@==%@",PropertyName,compareName];
//    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",compareName];
    [request setPredicate:predicate];
    
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult.count) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
    for (id d in mutableFetchResult) {
        [self.context deleteObject:d];
    }
    
    if ([self.context save:&error]) {
        
        NSLog(@"删除成功");
    }else{
        
        NSLog(@"Error:%@,%@",error,[error userInfo]);
    }
}

- (BOOL)Class:(Class)modelClass IsHaveProperty:(NSString *)propertyName{
    
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(modelClass, &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);//获取属性名字
        NSString *tmpName = [NSString stringWithUTF8String:name];
        if ([tmpName isEqualToString:propertyName]) {
            return YES;
        }
    }
    
    return NO;
}


- (id)creatModelWith:(Class)modelClass{
    
    return  [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(modelClass) inManagedObjectContext:self.context];
}

@end
