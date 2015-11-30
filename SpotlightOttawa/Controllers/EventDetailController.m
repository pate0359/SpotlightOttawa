//
//  EventDetailController.m
//  SpotlightOttawa
//
//  Created by Nignesh on 2015-11-29.
//  Copyright © 2015 patel.nignesh2108@gmail.com. All rights reserved.
//

#import "EventDetailController.h"


@interface EventDetailController () <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblDateTime;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblContactInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblSummary;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation EventDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"Details";
    
    NSLog(@"%@",self.event.title_english);
    NSLog(@"%@",self.event.description_english);
    NSLog(@"%@",self.event.event_times_english);
    NSLog(@"%@",self.event.location.address_english);
    NSLog(@"%@",self.event.location.province);
    NSLog(@"%@",self.event.location.postal_code);
    NSLog(@"%@",self.event.organizer_name_english);
    NSLog(@"%@",self.event.contact_name);
    NSLog(@"%@",self.event.contact_email);
    NSLog(@"%@",self.event.contact_phone);
    NSLog(@"%@",self.event.contact_phone_extension);
    
    self.lblTitle.text=self.event.title_english;
    
    self.lblDescription.text=self.event.description_english;
    self.lblDateTime.text=self.event.event_times_english;
    
    NSString *stringLocation = [NSString stringWithFormat:
                                @"%@ \n%@ \n%@",self.event.location.address_english,self.event.location.province,self.event.location.postal_code];
    self.lblLocation.text=stringLocation;
    
    NSString *strInfo=[NSString stringWithFormat:
                       @"%@ \n%@ \n%@ \n%@",self.event.contact_name,self.event.contact_email,self.event.contact_phone,self.event.contact_phone_extension];
    
    self.lblContactInfo.text=strInfo;
    
    self.lblSummary.text=self.event.summary_english;
    
    [self.lblDescription sizeToFit];
    [self.lblDateTime sizeToFit];
    [self.lblLocation sizeToFit];
    [self.lblContactInfo sizeToFit];
    [self.lblSummary sizeToFit];
    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 620);
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

@end
