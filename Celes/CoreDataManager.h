//
//  CoreDataManager.h
//  Celes
//
//  Created by Celestial on 06/11/24.
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"



NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject


+(instancetype)sharedManager;
-(NSManagedObjectContext *)manageobjectcontext;
-(void)savecontext;

@end

NS_ASSUME_NONNULL_END
