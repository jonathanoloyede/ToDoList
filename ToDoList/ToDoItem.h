//
//  ToDoItem.h
//  ToDoList
//
//  Created by Jonathan on 02/03/2018.
//  Copyright © 2018 Jonathan Oloyede. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ToDoItem : NSObject <NSCoding>

@property NSString *itemName;
@property BOOL completed;
@property NSDate *creationDate;

@end
