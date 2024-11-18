#import "AnalyticView.h"
#import "CoreData/CoreData.h"
#import "../../CoreDataManager.h"

@interface AnalyticView ()
@property (strong, nonatomic) NSArray *project;
@property (strong, nonatomic) NSArray *task;
@property (strong, nonatomic) NSArray *attendance;

@end

@implementation AnalyticView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.id && self.email) {
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] manageobjectcontext];
        
        NSError *error = nil;

        // Fetch projects
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"EmpProject"];
        request.predicate = [NSPredicate predicateWithFormat:@"email == %@", self.email];
        self.project = [context executeFetchRequest:request error:&error];
        
        if (error) {
            NSLog(@"Error fetching projects: %@", error.localizedDescription);
        }

        // Fetch tasks
        NSFetchRequest *request2 = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
        request2.predicate = [NSPredicate predicateWithFormat:@"email == %@", self.email];
        self.task = [context executeFetchRequest:request2 error:&error];
        
        if (error) {
            NSLog(@"Error fetching tasks: %@", error.localizedDescription);
        }

        // Fetch attendance
        NSFetchRequest *request3 = [NSFetchRequest fetchRequestWithEntityName:@"Attendance"];
        request3.predicate = [NSPredicate predicateWithFormat:@"email == %@", self.email];
        self.attendance = [context executeFetchRequest:request3 error:&error];
        
        if (error) {
            NSLog(@"Error fetching attendance: %@", error.localizedDescription);
        }
        

        NSLog(@"Project : %@", self.project);
        NSLog(@"Task : %@", self.task);
        NSLog(@"Attendance : %@", self.attendance);
        
        
        
        
        self.totalAttendace.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.attendance.count];
        int pendingTasks = 0;
        int pendingProjects = 0;
        int completedTasks = 0;
        int completedProjects = 0;
        
        
        for(NSManagedObject *t in self.task){
         
            if([[t valueForKey:@"completion"]isEqualToString:@"Completed"]){
                completedTasks++;
            }else{
                pendingTasks++;
            }
            
            
        }
        for(NSManagedObject *p in self.project){
         
            if([[p valueForKey:@"completed"]isEqualToString:@"Completed"]){
                completedProjects++;
            }else{
                pendingProjects++;
            }
            
        }
        self.pendingTask.text = [NSString stringWithFormat:@"%i",pendingTasks];
        self.completedTask.text = [NSString stringWithFormat:@"%i",completedTasks];
        self.pendingProject.text = [NSString stringWithFormat:@"%i",pendingProjects];
        self.completedProject.text = [NSString stringWithFormat:@"%i",completedProjects];
        
    }
}

@end
