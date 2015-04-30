//
//  ActivitiesDAO.m
//  NewLonking
//
//  Created by 李健 on 14-10-9.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "ActivitiesDAO.h"
#import "AppDelegate.h"
#import "ActivitiesModel.h"
#import "ActivitiesDB.h"

@implementation ActivitiesDAO

+ (BOOL)save:(ActivitiesModel *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    
    ActivitiesDB * info = [NSEntityDescription insertNewObjectForEntityForName:@"ActivitiesDB" inManagedObjectContext:context];
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

+ (ActivitiesDB *)findById:(NSString *)activitiesId
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ActivitiesDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"activitiesId = %@", activitiesId];
    
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
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ActivitiesDB" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    
    return YES;
}

+ (BOOL)deleteById:(NSString *)activitiesId
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ActivitiesDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"activitiesId = %@", activitiesId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    return YES;
}

+ (BOOL)update:(ActivitiesModel *)model
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [delegate managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ActivitiesDB" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"activitiesId = %@", model.modelId];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    if (resultArr && resultArr.count >0) {
        ActivitiesDB * info = resultArr[0];
        [info fromModel:model];
        if ([context save:&error]) {
            NSLog(@"update activity success");
            return YES;
        }else{
            NSLog(@"update activity fail");
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
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"ActivitiesDB" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError * error;
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    
    return resultArr;
}
@end
