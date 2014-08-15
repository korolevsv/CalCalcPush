//
//  SVKDateStore.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SVKEvent;

@interface SVKEventStore : NSObject

@property (nonatomic, readonly) NSArray *allDates;

+ (instancetype) sharedStore;
- (SVKEvent *) createEvent;
- (void)removeEvent:(SVKEvent *)event;
- (void)moveEventAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;


@end
