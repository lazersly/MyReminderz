//
//  MapInterfaceContext.h
//  MyReminderz
//
//  Created by Brandon Roberts on 5/4/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface MapInterfaceContext : NSObject

@property (strong, nonatomic) CLCircularRegion *regionToDisplay;

@end
