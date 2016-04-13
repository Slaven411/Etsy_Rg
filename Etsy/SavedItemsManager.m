//
//  SavedItemsManager.m
//  Etsy
//
//  Created by Slaven Kozub on 11/4/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import "SavedItemsManager.h"
#import "CDEtsyCood.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation SavedItemsManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        [MagicalRecord setupCoreDataStackWithStoreNamed:@"EtsyModel"];
    }
    return self;
}

- (void)cleanUp {
  
  [MagicalRecord cleanUp];

}

- (void)addItem:(EtsyGood *)item {
  
  CDEtsyCood* etsyGood = [CDEtsyCood MR_createEntity];
  etsyGood.title = item.title;
  etsyGood.price = item.price;
  etsyGood.descr = item.itemDescription;
  etsyGood.goodId = [NSString stringWithFormat:@"%@",item.goodID];
  
  NSManagedObjectContext *context = etsyGood.managedObjectContext;
  [context MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
    NSLog(@"ITEM SAVED");
  }];
}

- (void)deleteItem:(EtsyGood *)item {
  
  CDEtsyCood *deleteItem = [CDEtsyCood MR_findFirstByAttribute:@"goodId"
                                                     withValue:item.goodID];
  
  [deleteItem MR_deleteEntity];

}

- (NSArray *)fetchAllItems {
  
  NSArray *allItems = [CDEtsyCood MR_findAll];
  
  NSMutableArray* etsyItems = [[NSMutableArray alloc]init];
  
  for (CDEtsyCood*cdGood in allItems) {
    
    EtsyGood* good = [[EtsyGood alloc]init];
    good.title = cdGood.title;
    good.price = cdGood.price;
    good.itemDescription = cdGood.descr;
    good.goodID = cdGood.goodId;
    
    [etsyItems addObject:good];
    
  }
  
  return etsyItems;
}

- (BOOL)existEntity:(NSString *)goodId {
  
  BOOL exist = NO;
  
  NSUInteger numberOfEntities = [CDEtsyCood MR_countOfEntitiesWithPredicate:[NSPredicate predicateWithFormat:@"goodId == %@", goodId]];
  if(numberOfEntities > 0) {
    exist = YES;
  }
  return exist;
}
@end
