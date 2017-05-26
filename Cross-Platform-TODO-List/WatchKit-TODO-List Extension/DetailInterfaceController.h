//
//  DetailInterfaceController.h
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "Todo.h"

@interface DetailInterfaceController : WKInterfaceController

@property(strong, nonatomic) Todo *currentTodo;

@end
