//
//  MapInterfaceController.m
//  MyReminderz
//
//  Created by Brandon Roberts on 5/4/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "MapInterfaceController.h"
#import "MapInterfaceContext.h"

@interface MapInterfaceController ()

@property (strong, nonatomic) CLCircularRegion *region;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *regionLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceMap *mapInterface;

@end

@implementation MapInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
  self.region = ((MapInterfaceContext *)context).regionToDisplay;
  
  [self.regionLabel setText:self.region.identifier];
  
  MKCoordinateRegion coordRegion = MKCoordinateRegionMakeWithDistance(self.region.center, self.region.radius * 2, self.region.radius * 2);
  
  [self.mapInterface setRegion:coordRegion];
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



