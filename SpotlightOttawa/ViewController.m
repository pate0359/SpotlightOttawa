//
//  ViewController.m
//  SpotlightOttawa
//
//  Created by Nignesh on 2015-11-28.
//  Copyright © 2015 patel.nignesh2108@gmail.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)englishClicked:(id)sender {
    
    //Change language flag
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isEnglish"];
    
    UITabBarController *tabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    [self presentViewController:tabViewController animated:NO completion:nil];
}

- (IBAction)frenchClicked:(id)sender {
    
    //Change language flag
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isEnglish"];
    
    UITabBarController *tabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    [self presentViewController:tabViewController animated:NO completion:nil];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     
     
 }
 

@end
