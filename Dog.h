//
//  Dog.h
//  coreData
//
//  Created by ws on 16/1/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Dog : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * userID;

@end
