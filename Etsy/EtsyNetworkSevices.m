
//
//  EtsyNetworkSevices.m
//  Etsy
//
//  Created by Slaven Kozub on 9/27/15.
//  Copyright (c) 2015 Slava. All rights reserved.
//

#import "EtsyNetworkSevices.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

#import "EtsyGood.h"
#import "EtsyCategory.h"

#import "CategoriesManager.h"

NSString *const BASE_ETSY_URL = @"https://openapi.etsy.com/v2/";
NSString *const GET_CATS_METHOD = @"taxonomy/categories";
NSString *const API_KEY = @"l6pdqjuf7hdf97h1yvzadfce";
NSString *const SEARCH_METHOD = @"listings/active";
NSString *const IMAGE_URL = @"images";

@implementation EtsyNetworkSevices

- (void) fetchCategories {
  NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@",BASE_ETSY_URL,GET_CATS_METHOD,@"?api_key=",API_KEY];

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:urlString
    parameters:nil
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSArray *rawCategories = responseObject[@"results"];// [responseObject objectForKey:@"results"]
         
         NSMutableArray *categories = [[NSMutableArray alloc] init];
         
         for (NSDictionary *rawCategory in rawCategories) {
           EtsyCategory *currentCat = [[EtsyCategory alloc] initWithDictionaty:rawCategory];
           [categories addObject:currentCat];
         }
         [self.delegate categoriesDidLoad:categories];
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         
       }];
  
}

- (void) searchItem:(NSString*)keywords forCategory:(NSString*)category {
  NSString *urlString = [NSString stringWithFormat:@"%@%@?api_key=%@&category=%@&keywords=%@",BASE_ETSY_URL,SEARCH_METHOD,API_KEY,category, keywords];
  NSLog(@"SEARCH URL = %@", urlString);
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:urlString
    parameters:nil
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSMutableArray *etsyGoodsArray = [[NSMutableArray alloc]init];
         NSArray *results = responseObject[@"results"];
         //NSLog(@"SEARCH = %@",results);
         for (NSDictionary *currentItem in results) {
           
           EtsyGood *currentGood = [[EtsyGood alloc] initWithDictionaty:currentItem];
         //  NSLog(@"ITEM = %@",currentItem);
           
           [etsyGoodsArray addObject:currentGood];
         }
      
         NSLog(@"%@",etsyGoodsArray);
         [self.delegate searchItemDidLoad:etsyGoodsArray];
        
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
       }];
  
}
//https://openapi.etsy.com/v2/listings/109242617/images?api_key=l6pdqjuf7hdf97h1yvzadfce

- (void)getImageUrlForListing:(NSString*)listingId withComplition:(void(^)(NSString *stringURL))complition {

  NSString *urlImage = [NSString stringWithFormat:@"%@/listings/%@/%@?api_key=%@",BASE_ETSY_URL,listingId,IMAGE_URL,API_KEY];
  NSLog(@"String =%@",urlImage);
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:urlImage
    parameters:nil
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSArray *results = responseObject[@"results"];
         NSDictionary *imageData = results.firstObject;
         NSString *imageUrl = imageData[@"url_75x75"];
         
         complition(imageUrl);
         
         NSLog(@"%@",imageUrl);
         
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
       }];
}

@end
