//
//  MyStack.h
//  MyReminderz
//
//  Created by Brandon Roberts on 4/27/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStack : NSObject

-(void)push:(id)object;
-(id)pop;

-(NSUInteger)count;

@end
