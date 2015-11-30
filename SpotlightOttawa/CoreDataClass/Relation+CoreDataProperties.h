//
//  Relation+CoreDataProperties.h
//  SpotlightOttawa
//
//  Created by Nignesh on 2015-11-29.
//  Copyright © 2015 patel.nignesh2108@gmail.com. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Relation.h"

NS_ASSUME_NONNULL_BEGIN

@interface Relation (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *event_id;
@property (nullable, nonatomic, retain) NSNumber *location_id;
@property (nullable, nonatomic, retain) NSNumber *option_id;
@property (nullable, nonatomic, retain) NSNumber *sector_id;
@property (nullable, nonatomic, retain) NSNumber *category_id;

@end

NS_ASSUME_NONNULL_END
