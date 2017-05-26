//
//  ViewController.m
//  Cross-Platform-TODO-List
//
//  Created by Christina Lee on 5/8/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "Todo.h"
@import FirebaseAuth;
@import Firebase;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;
@property(strong, nonatomic) NSMutableArray<Todo *> *allTodos;

@property(nonatomic) FIRDatabaseHandle allTodosHandler;


@property (weak, nonatomic) IBOutlet UITableView *todoTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;


@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkUserStatus];
    self.todoTableView.dataSource = self;
    self.todoTableView.delegate = self;
    self.todoTableView.estimatedRowHeight = 50;
    self.todoTableView.rowHeight = UITableViewAutomaticDimension;
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
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.allTodos = [[NSMutableArray<Todo *> alloc]init];

        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            
            Todo *todo = [[Todo alloc] init];
            todo.title = todoData[@"title"];
            todo.content = todoData[@"content"];
            todo.completed = todoData[@"completed"];
            todo.key = todoData[@"key"];
            todo.email = todoData[@"email"];
            
            [self.allTodos addObject:todo];
            [self.todoTableView reloadData];
            
            NSLog(@"Todo Title: %@ - Content: %@ - Completed: %@ - Email: %@", todo.title, todo.content, todo.completed, todo.email);
        }
    }];
}

- (IBAction)logoutButtonPressed:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginController animated:YES completion:nil];
}

- (IBAction)plusButtonPressed:(id)sender {
    if (self.heightConstraint.constant == 0) {
        self.heightConstraint.constant = 160;
        [UIView animateWithDuration:0.6 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        self.heightConstraint.constant = 0;
        [UIView animateWithDuration:0.6 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [self.allTodos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Todo *currentTodo = self.allTodos[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Todo Title: %@ - Content: %@ - Completed: %@", currentTodo.title, currentTodo.content, currentTodo.completed];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"DELETE" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"work on deleting!");
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *completeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"COMPLETED" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        FIRDatabaseReference *userReference = [[FIRDatabase database] reference];
        
        Todo *current = self.allTodos[indexPath.row];
        
        [[[[[[userReference child:@"users"] child:self.currentUser.uid] child:@"todos"] child:current.key]child:@"completed"] setValue:@"YES"];
    }];
    
    completeAction.backgroundColor = [UIColor greenColor];
    
    return @[deleteAction, completeAction];
}

//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewRowAction *doneAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"DONE" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//        //Put functionality for doneButton here!
//        
//    }];
//    
//    doneAction.backgroundColor = [UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0];
//    
//    return @[doneAction];
//}

@end
