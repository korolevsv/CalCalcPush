//
//  SVKDateStore.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKDateStore.h"
#import "SVKEventDate.h"

@interface SVKDateStore()

@property (nonatomic) NSMutableArray *privateDates;

@end

@implementation SVKDateStore

+ (instancetype)sharedStore
{
    static SVKDateStore *sharedStore = nil;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// If a programmer calls [[SVKDateStore alloc] init], let him
// know the error of his ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[SVKDateStore sharedStore]"
                                 userInfo:nil];
    return nil;
}
        
// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    if(self) {
        _privateDates = [[NSMutableArray alloc] init];
    }
            
    return self;
}


- (NSArray *) allDates
{
    return self.privateDates;
}

- (SVKEventDate *) createDate
{
    SVKEventDate * date = [[SVKEventDate alloc] init];
    date.name = @"New Date";
    date.date = [[NSDate alloc] init];
    
    [self.privateDates addObject:date];
    
    return date;
}
- (void)removeDate:(SVKEventDate *)date
{
    [self.privateDates removeObjectIdenticalTo:date];
}

- (void)moveDateAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so you can re-insert it
    SVKEventDate *date = self.privateDates[fromIndex];
    
    // Remove item from array
    [self.privateDates removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.privateDates insertObject:date atIndex:toIndex];
}


@end

