//
//  ViewController.m
//  MyReminderz
//
//  Created by Brandon Roberts on 4/27/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
//@property (nonatomic) CLLocationCoordinate2D leftCoordinate;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.mapView.mapType = MKMapTypeSatellite;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)leftLocationButtonPressed:(id)sender {
  CLLocationCoordinate2D shanghaiLocation = CLLocationCoordinate2DMake(31.2000, 121.5000);
  [self.mapView setCenterCoordinate:shanghaiLocation animated:YES];
}

- (IBAction)middleLocationButtonPressed:(id)sender {
  CLLocationCoordinate2D seattleCoordinate = CLLocationCoordinate2DMake(47.6097, -122.3331);
  [self.mapView setCenterCoordinate:seattleCoordinate animated:YES];
}

- (IBAction)rightLocationButtonPressed:(id)sender {
  CLLocationCoordinate2D barcelonaCoordinate = CLLocationCoordinate2DMake(41.3833, 2.1833);
  [self.mapView setCenterCoordinate:barcelonaCoordinate animated:YES];
}



@end
