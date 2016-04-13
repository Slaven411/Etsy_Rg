//
//  EtsyCategory.m
//  Etsy
//
//  Created by Slaven Kozub on 9/27/15.
//  Copyright (c) 2015 Slava. All rights reserved.
//

#import "EtsyCategory.h"

@implementation EtsyCategory

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (instancetype)initWithDictionaty:(NSDictionary *)rawCategory
{
  self = [super init];
  if (self) {
    self.catId = rawCategory[@"category_id"];
    self.name = rawCategory[@"name"];
  }
  return self;
}

@end
