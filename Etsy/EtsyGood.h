//
//  EtsyGood.h
//  Etsy
//
//  Created by Slaven Kozub on 10/2/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EtsyGood : NSObject

@property (nonatomic, strong) NSURL *imgUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *goodID;

- (instancetype)initWithDictionaty:(NSDictionary *)rawGood;

@end
