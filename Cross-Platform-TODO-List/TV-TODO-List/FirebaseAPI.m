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
    NSString *urlString = [NSString stringWithFormat:@"https://cross-platform-todo-list.firebaseio.com/users.json?auth=%@"];
    
}

@end
