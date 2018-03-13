//
//  ToDoItem.m
//  ToDoList
//
//  Created by Jonathan on 02/03/2018.
//  Copyright © 2018 Jonathan Oloyede. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

-(id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.itemName = [decoder decodeObjectForKey:@"itemName"];
        self.completed = [decoder decodeBoolForKey:@"completed"];
        self.creationDate = [decoder decodeObjectForKey:@"creationDate"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.itemName forKey:@"itemName"];
    [encoder encodeBool:self.completed forKey:@"completed"];
    [encoder encodeObject:self.creationDate forKey:@"creationDate"];
}
@end
