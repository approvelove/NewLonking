//
//  HotProductDAO.m
//  NewLonking
//
//  Created by 李健 on 14-10-16.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "HotProductDAO.h"
#import "AppDelegate.h"
#import "HotProductDB.h"
#import "HotProductModel.h"

@implementation HotProductDAO

+ (BOOL)save:(HotProductModel *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    
    HotProductDB * info = [NSEntityDescription insertNewObjectForEntityForName:@"HotProductDB" inManagedObjectContext:context];
    [info fromModel:model];
    
    NSError * error;
    if ([context save:&error]) {
        NSLog(@"save users success");
        return YES;
    }else{
        NSLog(@"save users fail");
        return NO;
    }
}

+ (HotProductDB *)findById:(NSString *)hotproductid
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"HotProductDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"hotproductid = %@", hotproductid];
    
    //    排序
    //    NSSortDescriptor * sort = [[NSortDescriptor alloc] initWithKey:@"name"];
    //    NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
    
    [request setEntity:entity];
    [request setPredicate: predicate];
    //    [fetch setSortDescriptors: sortDescriptors];
    
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    
    if (resultArr == nil || resultArr.count == 0) {
        return nil;
    }else{
        return resultArr[0];
    }
}

+ (BOOL)clearData
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"HotProductDB" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    
    return YES;
}

+ (BOOL)deleteById:(NSString *)hotproductid
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"HotProductDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"hotproductid = %@", hotproductid];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    return YES;
}

+ (BOOL)update:(HotProductModel *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"HotProductDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"hotproductid = %@", model.modelId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    if (resultArr && resultArr.count >0) {
        HotProductDB * info = resultArr[0];
        [info fromModel:model];
        if ([context save:&error]) {
            NSLog(@"update hotProduct success");
            return YES;
        }else{
            NSLog(@"update hotProduct fail");
            return NO;
        }
    }else{
        return NO;
    } 
}

+ (NSArray *)findAll
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"HotProductDB" inManagedObjectContext:context];
    [request setEntity:entity];
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"orderindex" ascending:YES];
//    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSError * error;
    
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    resultArr = [resultArr sortedArrayUsingComparator:^NSComparisonResult(HotProductDB *obj1, HotProductDB *obj2) {
        int val_one = [obj1.orderindex intValue];
        int val_two = [obj2.orderindex intValue];
        if (val_one<val_two) {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedDescending;
        }
    }];
    return resultArr;
}


@end
