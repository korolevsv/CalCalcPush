//
//  SVKDateStore.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SVKDate;

@interface SVKDateStore : NSObject

@property (nonatomic, readonly) NSArray *allDates;

+ (instancetype) sharedStore;
- (SVKDate *) createDate;

@end
