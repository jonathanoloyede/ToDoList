//
//  AddToDoItemViewController.h
//  ToDoList
//
//  Created by Jonathan on 02/03/2018.
//  Copyright © 2018 Jonathan Oloyede. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface AddToDoItemViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property ToDoItem *toDoItem;
- (IBAction)unwindAddToList:(UIStoryboardSegue *)segue;

@end
