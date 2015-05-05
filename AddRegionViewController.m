//
//  AddRegionViewController.m
//  MyReminderz
//
//  Created by Brandon Roberts on 4/29/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "AddRegionViewController.h"
#import <MapKit/MapKit.h>

@interface AddRegionViewController () <UITextFieldDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet MKMapView *mapPreview;
@property (strong, nonatomic) IBOutlet UISlider *distanceSlider;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) NSNumber *distance;

@end

@implementation AddRegionViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  float maxDistance = 800;
  float minDistance = 10;
  float maxDistanceOffset = 50;
  
  
  self.distance = [NSNumber numberWithInteger:200];
  self.distanceSlider.maximumValue = maxDistance;
  self.distanceSlider.minimumValue = minDistance;
  self.distanceSlider.value = self.distance.floatValue;
  
  self.mapPreview.delegate = self;
  self.mapPreview.mapType = MKMapTypeHybrid;
  self.mapPreview.userInteractionEnabled = NO;
  self.mapPreview.region = MKCoordinateRegionMakeWithDistance(self.coordinate, maxDistance * 2 + maxDistanceOffset, maxDistance * 2 + maxDistanceOffset);
  
}

- (IBAction)addRegionPressed:(id)sender {
  
  if ( [CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:self.coordinate radius:self.distance.floatValue identifier:self.textField.text];
    
    NSDictionary *userInfo = @{@"region" : region};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegionRegistered" object:self userInfo:userInfo];
    
    [self dismissViewControllerAnimated:true completion:nil];
  }
  
}

#pragma mark - Distance and Slider

- (IBAction)distanceSliderValueChanged:(UISlider *)sender {
  self.distance = [NSNumber numberWithFloat:sender.value];
}

-(void)setDistance:(NSNumber *)distance {
  _distance = distance;
  self.distanceLabel.text = [NSString stringWithFormat:@"%ld", (long)_distance.integerValue];
  [self.mapPreview removeOverlays:self.mapPreview.overlays];
  [self.mapPreview addOverlay:[MKCircle circleWithCenterCoordinate:self.coordinate radius:_distance.floatValue]];
}

#pragma mark - MKMapViewDelegate


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
  MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
  circleRenderer.strokeColor = [UIColor whiteColor];
  circleRenderer.fillColor = [UIColor lightGrayColor];
  circleRenderer.alpha = 0.5;
  
  return circleRenderer;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return true;
}
@end

