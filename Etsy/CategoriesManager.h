//
//  CategoriesManager.h
//  Etsy
//
//  Created by Slaven Kozub on 9/27/15.
//  Copyright (c) 2015 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EtsyGood.h"

@protocol CategoriesManagerDelegat <NSObject>

- (void) categoriesReady:(NSArray*)categories;
- (void) itemsLoad:(NSArray*)items;

@end

@interface CategoriesManager : NSObject

@property (nonatomic, strong) NSArray *categories;
@property (weak, nonatomic) id<CategoriesManagerDelegat>delagate;

+ (instancetype)sharedInstance;

- (void)loadCategories;
- (void) searchItem:(NSString*)keywords forCategory:(NSString*)category;
- (void)loadImageForListing:(NSString*) listingId withComplition:(void(^)(NSString *stringURL))complition;

- (void)addItem:(EtsyGood*)item;
- (void)deleteItem:(EtsyGood*)item;
- (NSArray*)fetchAllItems;
- (void)cleanUp;
- (BOOL)existEntity:(NSString*)goodId;





@end
