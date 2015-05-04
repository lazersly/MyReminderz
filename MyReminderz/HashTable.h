//
//  HashTable.h
//  MyReminderz
//
//  Created by Brandon Roberts on 4/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTable : NSObject

-(instancetype)initWithSize:(NSInteger)size;

-(void)addObject:(id)object forKey:(NSString *)key;
-(id)objectForKey:(NSString *)key;
-(void)removeObjectForKey:(NSString *)key;

@end
