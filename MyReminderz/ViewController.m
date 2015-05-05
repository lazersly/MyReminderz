//
//  ViewController.m
//  MyReminderz
//
//  Created by Brandon Roberts on 4/27/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AddRegionViewController.h"

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.mapView.mapType = MKMapTypeSatellite;
  self.locationManager.delegate = self;
  self.mapView.delegate = self;
  
  self.locationManager = [[CLLocationManager alloc] init];
  if ([CLLocationManager locationServicesEnabled]) {
    [self.locationManager requestAlwaysAuthorization];
    self.mapView.showsUserLocation = YES;
  }
  
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
  [self.mapView addGestureRecognizer:longPress];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regionRegistered:) name:@"RegionRegistered" object:nil];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
  if (gesture.state == UIGestureRecognizerStateBegan) {
    CGPoint locationOnMap = [gesture locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:locationOnMap toCoordinateFromView:self.mapView];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"Location-based Reminder";
    
    [self.mapView addAnnotation:annotation];
  }
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

#pragma mark - CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  self.mapView.showsUserLocation = YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  UILocalNotification *localNotification = [[UILocalNotification alloc] init];
  localNotification.alertTitle = @"You've arrived!";
  localNotification.alertBody = [NSString stringWithFormat: @"You've entered your %@ region", region.identifier];
  localNotification.alertAction = @"Open MyReminderz";
  
  [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
  
  NSLog(@"Region Entered: %@", region.identifier);
}

#pragma mark - NSNotificationCenter

-(void)regionRegistered:(NSNotification *)notification {
  
  if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
    
    CLCircularRegion *region = notification.userInfo[@"region"];
    
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
    [self.mapView addOverlay:circle];
    
    [self.locationManager startMonitoringForRegion:region];
    
  } else {
    // Display an alert saying it's not turned on
  }
}

#pragma mark - Map View Methods


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  //  if ([annotation isKindOfClass:[MKUserLocation class]]) {
  //    return nil;
  //  }
  
  if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PinView"];
    
    if (!pin) {
      pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PinView"];
      pin.animatesDrop = YES;
      pin.pinColor = MKPinAnnotationColorPurple;
      pin.canShowCallout = YES;
      pin.draggable = YES;
      pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    } else {
      pin.annotation = annotation;
    }
    
    return pin;
  }
  
  return nil;
  
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  
  AddRegionViewController *nextVC = (AddRegionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddRegionViewController"];
  
  nextVC.coordinate = [view.annotation coordinate];
  
  [self presentViewController:nextVC animated:YES completion:nil];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
  MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
  circleRenderer.strokeColor = [UIColor whiteColor];
  circleRenderer.fillColor = [UIColor lightGrayColor];
  circleRenderer.alpha = 0.5;
  
  return circleRenderer;
}


-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
