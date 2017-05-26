//
//  DetailInterfaceController.m
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "DetailInterfaceController.h"
#import "Todo.h"

@interface DetailInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;

@end

@implementation DetailInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.currentTodo = context;
    [self.titleLabel setText:self.currentTodo.title];
    [self.contentLabel setText:self.currentTodo.content];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



