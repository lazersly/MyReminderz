//
//  AddRegionViewController.m
//  MyReminderz
//
//  Created by Brandon Roberts on 4/29/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "AddRegionViewController.h"

const CLLocationDistance regionRadius = 200;

@interface AddRegionViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation AddRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.textField.delegate = self;
}

- (IBAction)addRegionButtonPressed:(id)sender {

  CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:self.coordinate radius:regionRadius identifier:self.textField.text];
  
  NSDictionary *userInfo = @{@"region" : region};
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"RegionRegistered" object:self userInfo:userInfo];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

@end
