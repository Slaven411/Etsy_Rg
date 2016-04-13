//
//  SavedItemsManager.h
//  Etsy
//
//  Created by Slaven Kozub on 11/4/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EtsyGood.h"

@interface SavedItemsManager : NSObject

- (void)addItem:(EtsyGood*)item;
- (void)deleteItem:(EtsyGood*)item;
- (NSArray*)fetchAllItems;
- (void)cleanUp;

-(BOOL)existEntity:(NSString*)goodId;
@end
