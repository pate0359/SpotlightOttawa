//
//  SOCategory+CoreDataProperties.h
//  SpotlightOttawa
//
//  Created by Nignesh on 2015-11-29.
//  Copyright © 2015 patel.nignesh2108@gmail.com. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SOCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface SOCategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *title_english;
@property (nullable, nonatomic, retain) NSString *title_french;

@end

NS_ASSUME_NONNULL_END
