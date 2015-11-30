//
//  Event+CoreDataProperties.h
//  SpotlightOttawa
//
//  Created by Nignesh on 2015-11-29.
//  Copyright © 2015 patel.nignesh2108@gmail.com. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *organizer_name_french;
@property (nullable, nonatomic, retain) NSString *organizer_name_english;
@property (nullable, nonatomic, retain) NSString *modify_time_stamp;
@property (nullable, nonatomic, retain) NSString *event_times_french;
@property (nullable, nonatomic, retain) NSString *event_times_english;
@property (nullable, nonatomic, retain) NSString *end_date;
@property (nullable, nonatomic, retain) NSString *email_address_french;
@property (nullable, nonatomic, retain) NSString *email_address_english;
@property (nullable, nonatomic, retain) NSString *description_french;
@property (nullable, nonatomic, retain) NSString *description_english;
@property (nullable, nonatomic, retain) NSString *create_time_stamp;
@property (nullable, nonatomic, retain) NSString *contact_phone_extension;
@property (nullable, nonatomic, retain) NSString *contact_phone;
@property (nullable, nonatomic, retain) NSString *contact_name;
@property (nullable, nonatomic, retain) NSString *contact_email;
@property (nullable, nonatomic, retain) NSString *website_url_french;
@property (nullable, nonatomic, retain) NSString *owning_organization_name_french;
@property (nullable, nonatomic, retain) NSString *owning_organization_name_english;
@property (nullable, nonatomic, retain) NSString *website_url_english;
@property (nullable, nonatomic, retain) NSString *title_french;
@property (nullable, nonatomic, retain) NSString *title_english;
@property (nullable, nonatomic, retain) NSString *summary_french;
@property (nullable, nonatomic, retain) NSString *summary_english;
@property (nullable, nonatomic, retain) NSString *start_date;
@property (nullable, nonatomic, retain) Location *location;
@property (nullable, nonatomic, retain) NSManagedObject *category;
@property (nullable, nonatomic, retain) Options *option;
@property (nullable, nonatomic, retain) CitySector *citysector;

@end

NS_ASSUME_NONNULL_END
