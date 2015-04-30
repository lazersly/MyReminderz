//
//  HashTable.m
//  MyReminderz
//
//  Created by Brandon Roberts on 4/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "HashTable.h"
#import "HashBucket.h"

@interface HashTable ()

@property (strong, nonatomic) NSMutableArray *items;
@property (nonatomic) NSInteger size;
@property (nonatomic) NSInteger count;

@end

@implementation HashTable

-(instancetype)initWithSize:(NSInteger)size {
  if (self = [super init]) {
    self.size = size;
    
    for (int i=0; i<size; i++) {
      HashBucket *bucket = [[HashBucket alloc] init];
      [self.items addObject:bucket];
    }
  }
  
  return self;
}

-(NSInteger)hash:(NSString *)key {
  
  NSInteger total = 0;
  
  for (int i = 0; i < key.length; i++) {
    NSInteger ascii = [key characterAtIndex:i];
    total = total + ascii;
  }
  return total % self.size;
}



@end
