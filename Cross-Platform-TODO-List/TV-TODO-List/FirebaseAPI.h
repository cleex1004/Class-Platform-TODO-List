//
//  FirebaseAPI.h
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

typedef void(^AllTodosCompletion)(NSArray<Todo *> *allTodos);

@interface FirebaseAPI : NSObject

+(void)fetchAllTodos:(NSString *)email:(AllTodosCompletion)completion;

@end
