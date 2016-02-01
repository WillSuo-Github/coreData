//
//  Card+CoreDataProperties.h
//  coreData
//
//  Created by ws on 16/1/27.
//  Copyright © 2016年 ws. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *cardNum;
@property (nullable, nonatomic, retain) NSString *cardName;

@end

NS_ASSUME_NONNULL_END
