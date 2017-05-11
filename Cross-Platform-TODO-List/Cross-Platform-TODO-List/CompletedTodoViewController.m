//
//  CompletedTodoViewController.m
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "CompletedTodoViewController.h"
#import "LoginViewController.h"
#import "Todo.h"
@import FirebaseAuth;
@import Firebase;

@interface CompletedTodoViewController () <UITableViewDataSource>

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;
@property(nonatomic) FIRDatabaseHandle completedTodosHandler;

@property (strong, nonatomic) NSMutableArray<Todo *> *completedTodos;

@property (weak, nonatomic) IBOutlet UITableView *completedTable;

@end

@implementation CompletedTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.completedTodos = [[NSMutableArray alloc]init];
//    self.completedTable.dataSource = self;
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkUserStatus];
    self.completedTable.dataSource = self;
    self.completedTable.estimatedRowHeight = 50;
    self.completedTable.rowHeight = UITableViewAutomaticDimension;
}

-(void)checkUserStatus {
    if (![[FIRAuth auth] currentUser]) {
        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginController animated:YES completion:nil];
    } else {
        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    NSLog(@"%@", segue.destinationViewController);
}

-(void)setupFirebase {
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    self.userReference = [[databaseReference child:@"users"] child:self.currentUser.uid];
    
    NSLog(@"USER REFERENCE: %@", self.userReference);
}

-(void)startMonitoringTodoUpdates {
    self.completedTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.completedTodos = [[NSMutableArray<Todo *> alloc]init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;

            Todo *todo = [[Todo alloc] init];
            todo.title = todoData[@"title"];
            todo.content = todoData[@"content"];
            todo.completed = todoData[@"completed"];
            
            if ([todo.completed isEqual: @"YES"]) {
                [self.completedTodos addObject:todo];
            }

            [self.completedTable reloadData];
            
            NSLog(@"Todo Title: %@ - Content: %@ - Completed: %@", todo.title, todo.content, todo.completed);
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.completedTodos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Todo *todo = self.completedTodos[indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"Todo Title: %@ - Content: %@ - Completed: %@", todo.title, todo.content, todo.completed];
    
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}
@end
