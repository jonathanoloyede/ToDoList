//
//  ToDoListTableViewController.m
//  ToDoList
//
//  Created by Jonathan on 02/03/2018.
//  Copyright © 2018 Jonathan Oloyede. All rights reserved.
//

#import "ToDoListTableViewController.h"
#import "ToDoList/ToDoItem.h"
#import "AddToDoItemViewController.h"

@interface ToDoListTableViewController ()

@property NSMutableArray *toDoItems;

@end

@implementation ToDoListTableViewController
- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    AddToDoItemViewController *source = [segue sourceViewController];
    ToDoItem *item = source.toDoItem;
    if (item != nil) {
        [self.toDoItems addObject:item];
    }
    [self.tableView reloadData];
    [self saveData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoItems =[[NSMutableArray alloc] init];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self loadData];
}

- (void)loadData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *defaultItems = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"toDoItems"]];
    if (defaultItems != nil) {
        self.toDoItems = [defaultItems mutableCopy];
    }
}

- (void)saveData {
    NSData *savedItems = [NSKeyedArchiver archivedDataWithRootObject:self.toDoItems];
    [[NSUserDefaults standardUserDefaults] setObject:savedItems forKey:@"toDoItems"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return the number of rows
    return [self.toDoItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    ToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    if (toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ToDoItem *deletedItem = [self.toDoItems objectAtIndex:indexPath.row];
        [self.toDoItems removeObject:deletedItem];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self saveData];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [self.toDoItems exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    [self saveData];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self saveData];
}

@end
