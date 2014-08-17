//
//  MDockGameSystem.h
//  MetaDock
//
//  Created by Rob Tsuk on 8/17/14.
//  Copyright (c) 2014 Rob Tsuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MDockComponent;

@interface MDockGameSystem : NSManagedObject

@property (nonatomic, retain) NSString * systemId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * version;
@property (nonatomic, retain) id terms;
@property (nonatomic, retain) NSSet *components;
@end

@interface MDockGameSystem (CoreDataGeneratedAccessors)

- (void)addComponentsObject:(MDockComponent *)value;
- (void)removeComponentsObject:(MDockComponent *)value;
- (void)addComponents:(NSSet *)values;
- (void)removeComponents:(NSSet *)values;

@end