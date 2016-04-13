//
//  EtsyGood.m
//  Etsy
//
//  Created by Slaven Kozub on 10/2/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import "EtsyGood.h"

@implementation EtsyGood

- (instancetype)initWithDictionaty:(NSDictionary *)rawGood
{
  self = [super init];
  if (self) {
    
    self.title = rawGood[@"title" ];
    self.itemDescription = rawGood[@"description"];
    self.price = rawGood[@"price"];
    self.goodID = rawGood[@"listing_id"];
    
  }
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Good title = %@",self.title];
}

@end
