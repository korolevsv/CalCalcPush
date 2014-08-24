//
//  SVKDate.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKEvent.h"

@implementation SVKEvent

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if ( self )
    {
        self.eventName = [coder decodeObjectForKey:@"self.eventName"];
        self.eventDate = [coder decodeObjectForKey:@"self.eventDate"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.eventName forKey:@"self.eventName"];
    [coder encodeObject:self.eventDate forKey:@"self.eventDate"];
}


- (NSString *) description
{
    return self.eventName;
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
