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

-(id)objectForKey:(NSString *)key {
  
  NSInteger hashedKey = [self hash:key];
  
  HashBucket *bucket = self.items[hashedKey];
  
  while (bucket) {
    if ([bucket.key isEqualToString:key]) {
      return bucket.data;
    } else {
      bucket = bucket.next;
    }
  }
  return nil;
}

-(void)removeObjectForKey:(NSString *)key {
  NSInteger hashedKey = [self hash:key];
  
  HashBucket *bucket = self.items[hashedKey];
  HashBucket *previousBucket;
  
  while (bucket) {
    if ([bucket.key isEqualToString:key]) {
      // Make the next bucket the current bucket of the previous bucket
      if (!previousBucket) {
        if (bucket.next == nil) {
          bucket.data = nil;
          bucket.key = nil;
        } else {
          self.items[hashedKey] = bucket.next;
        }
      } else {
        previousBucket.next = bucket.next;
      }
    }
    previousBucket = bucket;
    bucket = bucket.next;
  }
  
}

-(void)addObject:(id)object forKey:(NSString *)key {
  
  [self removeObjectForKey:key];
  
  NSInteger index = [self hash:key];
  
  HashBucket *bucket = self.items[index];
  
  if (!bucket.key) {
    bucket.key = key;
    bucket.data = object;
  } else {
    HashBucket *newBucket = [[HashBucket alloc] init];
    newBucket.key = key;
    newBucket.next = bucket;
    self.items[index] = newBucket;
  }
  
}



@end
