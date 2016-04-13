//
//  EtsyNetworkSevices.h
//  Etsy
//
//  Created by Slaven Kozub on 9/27/15.
//  Copyright (c) 2015 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol EtsyNetworkSevicesDelegat


- (void) categoriesDidLoad:(NSArray*)categories;
- (void) searchItemDidLoad:(NSArray*)searchItems;


@end

@interface EtsyNetworkSevices : NSObject

@property (weak, nonatomic) id<EtsyNetworkSevicesDelegat> delegate;

- (void) fetchCategories;

- (void) searchItem:(NSString*)keywords forCategory:(NSString*)category ;

- (void)getImageUrlForListing:(NSString*)listingId withComplition:(void(^)(NSString *stringURL))complition;

@end
