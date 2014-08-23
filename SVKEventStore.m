//
//  SVKDateStore.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKEventStore.h"
#import "SVKEvent.h"
#import "SVKCalCalc.h"

static NSString * const archiveFullName = @"events.archive";
static NSString * const archiveName = @"events";
static NSString * const archiveType = @"archive";


static NSString * const nameNewEvent = @"New Event";


@interface SVKEventStore()

@property (nonatomic) NSMutableArray *privateEvents;

@end

@implementation SVKEventStore

+ (instancetype)sharedStore
{
    static SVKEventStore *sharedStore = nil;
    
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
    NSString *path = [self eventArchivePath];
    _privateEvents = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    path = [self eventArchiveBundlePath];
    // If the array hadn't been saved previously, read defaults from app bundle
    if (!_privateEvents) {
        path = [self eventArchiveBundlePath];
        _privateEvents = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }

    // If the array hadn't been saved previously and there is no archive in application bundle, create a new empty one
    if (!_privateEvents) {
        _privateEvents = [[NSMutableArray alloc] init];
    }
    return self;
}


- (NSArray *) allEvents
{
    return self.privateEvents;
}

- (SVKEvent *) createEvent
{
    SVKEvent * event = [[SVKEvent alloc] init];
    event.eventName = nameNewEvent;
    event.eventDate = [SVKCalCalc removeSecondsFromDate:[[NSDate alloc] init]];
    
    [self.privateEvents addObject:event];
    
    return event;
}
- (void)removeEvent:(SVKEvent *)event
{
    [self.privateEvents removeObjectIdenticalTo:event];
}

- (void)moveEventAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so you can re-insert it
    SVKEvent *event = self.privateEvents[fromIndex];
    
    // Remove item from array
    [self.privateEvents removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.privateEvents insertObject:event atIndex:toIndex];
}

- (NSString *)eventArchivePath
{
    // Make sure that the first argument is NSDocumentDirectory
    // and not NSDocumentationDirectory
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    
    // Get the one document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:archiveName];
}

- (NSString *)eventArchiveBundlePath
{
    // Get a pointer to the application bundle
    NSBundle *applicationBundle = [NSBundle mainBundle];
    
    // Ask for the path to a resource named myImage.png in the bundle
    NSString *path = [applicationBundle pathForResource:archiveName
                                                 ofType:archiveType];
    
    return path;
}

- (BOOL)saveChanges
{
    NSString *path = [self eventArchivePath];
    
    // Returns YES on success
    return [NSKeyedArchiver archiveRootObject:self.privateEvents
                                       toFile:path];
}

@end

