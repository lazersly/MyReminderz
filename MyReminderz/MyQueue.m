//
//  MyQueue.m
//  MyReminderz
//
//  Created by Brandon Roberts on 4/27/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "MyQueue.h"

@interface MyQueue ()

@property (strong, nonatomic) NSMutableArray *backingArray;

@end

@implementation MyQueue

-(instancetype)init {
  if (self = [super init]) {
    _backingArray = [[NSMutableArray alloc] init];
  }
  return self;
}

-(void)enqueue:(id)object {
  [self.backingArray addObject:object];
}

-(id)dequeue {
  if (self.backingArray.count > 0) {
    id objectToReturn = self.backingArray.firstObject;
    [self.backingArray removeObjectAtIndex:0];
    return objectToReturn;
  } else {
    return nil;
  }
}

-(NSUInteger)count {
  return self.backingArray.count;
}



@end
