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

- (NSString *) dateDescription
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    return [dateFormatter stringFromDate:self.eventDate];
}
- (NSString *) timeDescription
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterNoStyle;
//        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    return [dateFormatter stringFromDate:self.eventDate];
}

@end
