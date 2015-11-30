//
//  EventViewController.m
//  SpotlightOttawa
//
//  Created by Nignesh on 2015-11-29.
//  Copyright © 2015 patel.nignesh2108@gmail.com. All rights reserved.
//

#import "EventViewController.h"
#import "AppDelegate.h"
#import "Event.h"
#import "Location.h"
#import "Options.h"
#import "CitySector.h"
#import "SOCategory.h"
#import "Constants.h"
#import "XMLDictionary.h"
#import "EventDetailController.h"

#import <QuartzCore/QuartzCore.h>

@interface EventViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet NSArray *tblData;
@property (strong, nonatomic) IBOutlet UILabel *lblLoading;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lblLoading.hidden=NO;
    self.tblView.hidden=YES;
    
//    [self performSelector:@selector(fetchEventData) withObject:nil afterDelay:0.9];
    
    [self fetchEventData];
    [self getEventData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma - Private Methods

-(IBAction)refreshEventData:(id)sender{

    self.lblLoading.hidden=NO;
    self.tblView.hidden=YES;
    
    [self performSelector:@selector(fetchEventData) withObject:nil afterDelay:0.9];
    
    //[self fetchEventData];
    [self getEventData];
}

-(void)fetchEventData{
    
    NSURL *URL = [NSURL URLWithString:EVENTS];
    NSString *xmlString = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    //NSLog(@"string: %@", xmlString);
    
    if (!xmlString) {
        
        self.lblLoading.hidden=NO;
        self.lblLoading.text=@"Something went wrong.";
        self.tblView.hidden=YES;
    }
    
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:xmlString];
    //NSLog(@"dictionary: %@", xmlDoc);
    
    NSArray *array= [xmlDoc objectForKey:@"event"];
    
    [self addEventsToCoreData:array];
}

-(void)getEventData{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *array = [[AppDelegate sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [self createGroupData:array];
}

-(void)createGroupData:(NSArray *)array{
    
    if (!array) self.tblData=[NSArray array];
    
    NSMutableArray *arrayToday=[NSMutableArray array];
    NSMutableArray *arrayTomoro=[NSMutableArray array];
    NSMutableArray *arrayUpcoming=[NSMutableArray array];
    NSMutableArray *arrayPastEvents=[NSMutableArray array];
    
    for (Event *event in array) {
        
        NSDate *today=[NSDate date];
        NSDate *tomorrow = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
        [formatter setDateFormat:@"yyyyMMdd"];
        
        NSString *strToday=[formatter stringFromDate:today];
        NSString *strTomorrow=[formatter stringFromDate:tomorrow];
        NSString *strEventDate=event.start_date;
        
        //Todays events
        if ([strToday isEqualToString:strEventDate]) {
            
            [arrayToday addObject:event];
            continue;
        }
        
        //Tomorrow events
        if ([strTomorrow isEqualToString:strEventDate]) {
            
            [arrayTomoro addObject:event];
            continue;
        }
        
        //Upcoming events
        NSDate *eventDate=[formatter dateFromString:strEventDate];
        if ([eventDate compare:tomorrow] == NSOrderedDescending) {
            [arrayUpcoming addObject:event];
        }
        
        //Past events
        [arrayPastEvents addObject:event];
    }
    
    self.tblData=[NSArray arrayWithObjects:arrayToday,arrayTomoro,arrayUpcoming,arrayPastEvents, nil];
    
    [self.tblView reloadData];
}

#pragma - Tableview Delegates

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tblData.count;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *title=@"";
    switch (section) {
        case 0:
            title= @"Today";
            break;
            
        case 1:
            title= @"Tomorrow";
            break;
        case 2:
            title= @"Upcoming";
            break;
        case 3:
            title= @"Past Events";
            break;
            
        default:
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tblData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSArray *array=[self.tblData objectAtIndex:indexPath.section];
    
    Event *event=[array objectAtIndex:indexPath.row];
    cell.textLabel.text = event.title_english;
    
    return cell;
}

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array=[self.tblData objectAtIndex:indexPath.section];
    
    Event *event=[array objectAtIndex:indexPath.row];
    
    EventDetailController *eventDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailController"];
    eventDetails.event=event;
    [self.navigationController pushViewController:eventDetails animated:YES];
}

#pragma - Core Data Operation

-(void)addEventsToCoreData:(NSArray *)eventArray{
    
    NSManagedObjectContext *context = [[AppDelegate sharedInstance] managedObjectContext];
    
    for (NSDictionary * eventDict in eventArray) {
        
        Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
        
        NSInteger eventId=(NSInteger)[eventDict objectForKey:@"_id"];
        event.id = [NSNumber numberWithInteger:eventId];
        
        event.organizer_name_french=[eventDict objectForKey:@"organizer_name_french"];
        event.organizer_name_english=[eventDict objectForKey:@"organizer_name_english"];
        event.modify_time_stamp=[eventDict objectForKey:@"modify_time_stamp"];
        event.event_times_french=[eventDict objectForKey:@"event_times_french"];
        event.event_times_english=[eventDict objectForKey:@"event_times_english"];
        NSString *strEndDate= [NSString stringWithFormat:@"%ld",([[eventDict objectForKey:@"end_date"] integerValue])/1000000];
        event.end_date=strEndDate;
        event.email_address_french=[eventDict objectForKey:@"email_address_french"];
        event.email_address_english=[eventDict objectForKey:@"email_address_english"];
        event.description_french=[eventDict objectForKey:@"description_french"];
        event.description_english=[eventDict objectForKey:@"description_english"];
        event.create_time_stamp=[eventDict objectForKey:@"create_time_stamp"];
        event.contact_phone_extension=[eventDict objectForKey:@"contact_phone_extension"];
        event.contact_phone=[eventDict objectForKey:@"contact_phone"];
        event.contact_name=[eventDict objectForKey:@"contact_name"];
        event.contact_email=[eventDict objectForKey:@"contact_email"];
        event.website_url_french=[eventDict objectForKey:@"website_url_french"];
        event.owning_organization_name_french=[eventDict objectForKey:@"owning_organization_name_french"];
        event.owning_organization_name_english=[eventDict objectForKey:@"owning_organization_name_english"];
        event.website_url_english=[eventDict objectForKey:@"website_url_english"];
        event.title_french=[eventDict objectForKey:@"title_french"];
        event.title_english=[eventDict objectForKey:@"title_english"];
        event.summary_french=[eventDict objectForKey:@"summary_french"];
        event.summary_english=[eventDict objectForKey:@"summary_english"];
        
        NSString *strDate= [NSString stringWithFormat:@"%ld",([[eventDict objectForKey:@"start_date"] integerValue])/1000000];
        event.start_date=strDate;
        
        Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
        NSDictionary *dictLocation=nil;
        
        id objectLocation = [eventDict objectForKey:@"locations"];
        if ([objectLocation isKindOfClass:[NSArray class]]) {
            
            dictLocation=[(NSArray*)objectLocation objectAtIndex:0];
            
        }else if ([objectLocation isKindOfClass:[NSDictionary class]]) {
            
            dictLocation=[(NSDictionary*)objectLocation valueForKey:@"location"];
        }
        NSInteger locId=(NSInteger)[dictLocation objectForKey:@"_id"];
        location.id = [NSNumber numberWithInteger:locId];
        
        BOOL isActive = NO;
        if ([[dictLocation objectForKey:@"_active"] isEqualToString:@"true"]) {
            isActive=YES;
        }else{
            isActive=NO;
        }
        location.active=isActive;
        location.type=[dictLocation objectForKey:@"_type"];
        location.address_english=[dictLocation objectForKey:@"address_english"];
        location.address_french=[dictLocation objectForKey:@"address_french"];
        location.city=[dictLocation objectForKey:@"city"];
        location.intersection_english=[dictLocation objectForKey:@"intersection_english"];
        location.intersection_french=[dictLocation objectForKey:@"intersection_french"];
        location.name_english=[dictLocation objectForKey:@"name_english"];
        location.name_french=[dictLocation objectForKey:@"name_french"];
        location.postal_code=[dictLocation objectForKey:@"postal_code"];
        location.province=[dictLocation objectForKey:@"province"];
        
        event.location = location;
        
        SOCategory *category = [NSEntityDescription insertNewObjectForEntityForName:@"SOCategory" inManagedObjectContext:context];
        NSDictionary *dictCategory=nil;
        id object = [eventDict objectForKey:@"categories"];
        if ([object isKindOfClass:[NSArray class]]) {
            
            dictCategory=[(NSArray*)object objectAtIndex:0];
            
        }else if ([object isKindOfClass:[NSDictionary class]]) {
            
            dictCategory=[(NSDictionary*)object valueForKey:@"category"];
        }
        NSInteger cateId=(NSInteger)[eventDict objectForKey:@"_id"];
        category.id = [NSNumber numberWithInteger:cateId];
        category.title_english=[eventDict objectForKey:@"title_english"];
        category.title_french=[eventDict objectForKey:@"title_french"];
        event.category = category;
        
        //    Options *options = [NSEntityDescription insertNewObjectForEntityForName:@"Options" inManagedObjectContext:context];
        //    event.option = options;
        
        CitySector *citysector = [NSEntityDescription insertNewObjectForEntityForName:@"CitySector" inManagedObjectContext:context];
        
        NSDictionary *dictSector=nil;
        id objectSector = [eventDict objectForKey:@"city_sectors"];
        if ([objectSector isKindOfClass:[NSArray class]]) {
            
            dictSector=[(NSArray*)objectSector objectAtIndex:0];
            
        }else if ([objectSector isKindOfClass:[NSDictionary class]]) {
            
            dictSector=[(NSDictionary*)objectSector valueForKey:@"city_sector"];
        }
        
        NSInteger sectorId=(NSInteger)[eventDict objectForKey:@"_id"];
        citysector.id = [NSNumber numberWithInteger:sectorId];
        citysector.title_english=[eventDict objectForKey:@"title_english"];;
        citysector.title_french=[eventDict objectForKey:@"title_french"];;
        event.citysector = citysector;
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
    //Show table
    self.lblLoading.hidden=YES;
    self.tblView.hidden=NO;
}

@end
