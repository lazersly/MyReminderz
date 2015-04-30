//
//  HashBucket.h
//  MyReminderz
//
//  Created by Brandon Roberts on 4/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashBucket : NSObject

@property (strong, nonatomic) HashBucket *next;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) id data;

@end
