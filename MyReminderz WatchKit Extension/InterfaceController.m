//
//  InterfaceController.m
//  MyReminderz WatchKit Extension
//
//  Created by Brandon Roberts on 4/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "InterfaceController.h"
#import "RegionRowController.h"
#import "MapInterfaceContext.h"

@interface InterfaceController()

@property (strong, nonatomic) IBOutlet WKInterfaceTable *regionsTable;
@property (strong, nonatomic) NSArray *regions;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
  
  CLLocationManager *locMan = [[CLLocationManager alloc] init];
  self.regions = locMan.monitoredRegions.allObjects;
  
  [self.regionsTable setNumberOfRows:self.regions.count withRowType:@"Region"];
  
  for (int i = 0; i < self.regions.count; i++) {
    CLRegion *region = self.regions[i];
    RegionRowController *rowController = [self.regionsTable rowControllerAtIndex:i];
    rowController.regionLabel.text = region.identifier;
  }
  
  
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex {
  MapInterfaceContext *context = [[MapInterfaceContext alloc] init];
  context.regionToDisplay = self.regions[rowIndex];
  
  return context;
}

@end



