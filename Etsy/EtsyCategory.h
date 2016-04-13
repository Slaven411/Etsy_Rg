//
//  EtsyCategory.h
//  Etsy
//
//  Created by Slaven Kozub on 9/27/15.
//  Copyright (c) 2015 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EtsyCategory : NSObject

@property (strong, nonatomic) NSString *catId;
@property (strong, nonatomic) NSString *name;

- (instancetype)initWithDictionaty:(NSDictionary *)rawCategory;

@end
