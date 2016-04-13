//
//  CategoriesManager.m
//  Etsy
//
//  Created by Slaven Kozub on 9/27/15.
//  Copyright (c) 2015 Slava. All rights reserved.
//

#import "CategoriesManager.h"
#import "EtsyCategory.h"
#import "EtsyNetworkSevices.h"
#import "SavedItemsManager.h"

@interface CategoriesManager () <EtsyNetworkSevicesDelegat>

@property(nonatomic,strong) SavedItemsManager* savedItemsManager;

@end

@implementation CategoriesManager


+ (instancetype)sharedInstance
{
  static CategoriesManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[CategoriesManager alloc] init];
    // Do any other initialisation stuff here
  });
  return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
      EtsyCategory *noCategory = [[EtsyCategory alloc] init];
      noCategory.name = @"no categories";
      self.categories = [[NSArray alloc] initWithObjects:noCategory, nil];
      self.savedItemsManager = [[SavedItemsManager alloc]init];
      
    }
    return self;
}

- (void)loadCategories {
  EtsyNetworkSevices *etsyNetwork = [EtsyNetworkSevices new];
  etsyNetwork.delegate = self;
  [etsyNetwork fetchCategories];
}

- (void)categoriesDidLoad:(NSArray *)categories {
  
  self.categories = categories;
  [self.delagate categoriesReady:self.categories];
  
}

- (void) searchItem:(NSString*)keywords forCategory:(NSString*)category {
  
  EtsyNetworkSevices* etsyNetwork = [[EtsyNetworkSevices alloc]init];
  etsyNetwork.delegate = self;
  [etsyNetwork searchItem:keywords forCategory:category];
  
}

- (void)searchItemDidLoad:(NSArray *)searchItems {

  [self.delagate itemsLoad:searchItems];
  
  
}

-(void)loadImageForListing:(NSString*) listingId withComplition:(void(^)(NSString *stringURL))complition{
  EtsyNetworkSevices* etsyNetwork = [[EtsyNetworkSevices alloc]init];
  etsyNetwork.delegate = self;
  [etsyNetwork getImageUrlForListing:listingId withComplition:^(NSString *stringURL) {
    complition(stringURL);
    
  }];
}

- (void)addItem:(EtsyGood*)item{
  [self.savedItemsManager addItem:item];
}
- (void)deleteItem:(EtsyGood*)item{
  [self.savedItemsManager deleteItem:item];
}
- (NSArray*)fetchAllItems{
  NSArray* fetchedItems = [self.savedItemsManager fetchAllItems];
  return fetchedItems;
}

- (void)cleanUp {
  [self.savedItemsManager cleanUp];
}

- (BOOL)existEntity:(NSString *)goodId {
  
  BOOL exist = [self.savedItemsManager existEntity:goodId];
  
  return exist;
}

@end
