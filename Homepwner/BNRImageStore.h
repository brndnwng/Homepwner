//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Brandon Wong on 5/18/14.
//  Copyright (c) 2014 Brandomination. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject
+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
