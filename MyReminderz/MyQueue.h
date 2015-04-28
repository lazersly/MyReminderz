//
//  MyQueue.h
//  MyReminderz
//
//  Created by Brandon Roberts on 4/27/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyQueue : NSObject

-(void)enqueue:(id)object;
-(id)dequeue;

-(NSUInteger)count;

@end
