//
//  BNRItem.h
//  RandomItems
//
//  Created by Brandon Wong on 5/6/14.
//  Copyright (c) 2014 Brandomination. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

@property (nonatomic, copy) NSString *itemKey;

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name
                   valueInDollars:(int)value
                     serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;

- (instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)serialNumber;

-(void)changeDate:(NSDate *)dateCreated;

@end
