//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Brandon Wong on 5/14/14.
//  Copyright (c) 2014 Brandomination. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

@class BNRItem;

@interface BNRItemStore : NSObject

// Notice that this is a class method and prefixed with a + instead of a -
@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;

- (void)removeItem:(BNRItem *)item;

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                 toIndex:(NSUInteger)toIndex;


@end
