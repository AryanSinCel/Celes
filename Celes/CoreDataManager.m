//
//  CoreDataManager.m
//  Celes
//
//  Created by Celestial on 06/11/24.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"

@implementation CoreDataManager

+(instancetype)sharedManager{
    static CoreDataManager *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[self alloc]init];
    });
    return  sharedInstace;
}


-(NSManagedObjectContext *)manageobjectcontext{
    NSPersistentContainer *container = [(AppDelegate *)[[UIApplication sharedApplication]delegate]persistentContainer];
    return container.viewContext;
}

-(void)savecontext{
    NSManagedObjectContext *context = [self manageobjectcontext];
    if ([context hasChanges]) {
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"Failed to save context: %@, %@", error, [error userInfo]);
            }
    }
    
}


@end
