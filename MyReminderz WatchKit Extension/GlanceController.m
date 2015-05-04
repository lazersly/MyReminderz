//
//  GlanceController.m
//  MyReminderz WatchKit Extension
//
//  Created by Brandon Roberts on 4/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()

@property (strong, nonatomic) IBOutlet WKInterfaceLabel *regionsLabel;
@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
  
  CLLocationManager *locMan = [[CLLocationManager alloc] init];
  
  NSArray *regions = locMan.monitoredRegions.allObjects;
  NSInteger count = regions.count;
  NSString *countString = [NSString stringWithFormat:@"%ld",(long)count];
  
  [self.regionsLabel setText:countString];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



