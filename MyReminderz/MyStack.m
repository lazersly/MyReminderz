//
//  MyStack.m
//  MyReminderz
//
//  Created by Brandon Roberts on 4/27/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "MyStack.h"

@interface MyStack ()

@property (strong, nonatomic) NSMutableArray *backingArray;

@end

@implementation MyStack

-(instancetype)init {
  if (self = [super init]) {
    _backingArray = [[NSMutableArray alloc] init];
  }
  return self;
}

-(void)push:(id)object {
  [self.backingArray addObject:object];
}

-(id)pop {
  if (self.backingArray.count > 0) {
    id objectToReturn = self.backingArray.lastObject;
    [self.backingArray removeLastObject];
    return objectToReturn;
  } else {
    return nil;
  }
}

-(NSUInteger)count {
  return self.backingArray.count;
}

@end
