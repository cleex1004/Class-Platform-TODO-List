//
//  FirebaseAPI.m
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Credentials.h"

@implementation FirebaseAPI

+(void)fetchAllTodos:(AllTodosCompletion)completion {
    NSString *urlString = [NSString stringWithFormat:@"https://cross-platform-todo-list.firebaseio.com/users.json?auth=%@", APP_KEY];
    
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"ROOT OBJECT:%@", rootObject);
        
        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        
        for (NSDictionary *userTodosDictionary in [rootObject allValues]) {
            NSArray *userTodos = [userTodosDictionary[@"todos"] allValues];
            
            for (NSDictionary *todoDictionary in userTodos) {
                Todo *newTodo = [[Todo alloc]init];
                newTodo.title = todoDictionary[@"title"];
                newTodo.content = todoDictionary[@"content"];
                newTodo.email = todoDictionary[@"email"];
                newTodo.key = todoDictionary[@"key"];
                newTodo.completed = todoDictionary[@"completed"];
                
                [allTodos addObject:newTodo];
            }
        }
        
        if (completion) {
//            completion(allTodos);
            
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                completion(allTodos);
//            }]; //operation queue
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(allTodos);
            }); //GCD
        }
    }] resume];
}

@end
