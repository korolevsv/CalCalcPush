//
//  SVKDate.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKEvent.h"

@implementation SVKEvent

- (NSString *) description
{
    return self.eventName;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.eventName forKey:@"eventName"];
    [aCoder encodeObject:self.eventDate forKey:@"eventDate"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _eventName = [aDecoder decodeObjectForKey:@"eventName"];
        _eventDate = [aDecoder decodeObjectForKey:@"eventDate"];
    }
    return self;
}
@end
