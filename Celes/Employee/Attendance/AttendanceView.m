//
//  AttendanceView.m
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import "AttendanceView.h"
#import "CoreData/CoreData.h"
#import "../../CoreDataManager.h"


@interface AttendanceView (){
    NSDate *date;
    NSString *checkIn;
    NSString *checkOut;
}

@end

@implementation AttendanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    date = [NSDate date];
    NSLog(@"Date : %@",date);
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)checkOut:(id)sender {
    // Get the selected time from the date picker
    NSDate *selectedTime = self.checkOutPicker.date;

        // Format the time to display only the hour and minute
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm"]; // Use "hh:mm a" for 12-hour format
        
        // Convert to a string for display or further use
        NSString *formattedTime = [timeFormatter stringFromDate:selectedTime];
        
        NSLog(@"Selected Time: %@", formattedTime);
        // You can now use `formattedTime` (e.g., display in a label or store it)
    checkIn = formattedTime;
    
    if(checkIn && checkOut){
        
        NSManagedObjectContext *context = [[CoreDataManager sharedManager]manageobjectcontext];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
        NSDate *dateOnly = [calendar dateFromComponents:components];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Attendance"];
        request.predicate = [NSPredicate predicateWithFormat:@"email == %@ AND date == %@",self.email,dateOnly];
        NSError *error;
        NSArray *existing = [context executeFetchRequest:request error:&error];
        if(existing.count > 0){
            NSLog(@"Already Checkout");
            return;
        }
        
        NSManagedObject *attendance = [NSEntityDescription insertNewObjectForEntityForName:@"Attendance" inManagedObjectContext:context];
        [attendance setValue:self.id forKey:@"id"];
        [attendance setValue:self.email forKey:@"email"];
        [attendance setValue:dateOnly forKey:@"date"];
        [attendance setValue:checkIn forKey:@"checkin"];
        [attendance setValue:checkOut forKey:@"checkout"];
        
        [[CoreDataManager sharedManager]savecontext];
        NSLog(@"User Checked Out for %@",dateOnly);
        
    }
    
}

- (IBAction)checkIn:(id)sender {
    // Get the selected time from the date picker
    NSDate *selectedTime = self.checkInPicker.date;

        // Format the time to display only the hour and minute
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm"]; // Use "hh:mm a" for 12-hour format
        
        // Convert to a string for display or further use
        NSString *formattedTime = [timeFormatter stringFromDate:selectedTime];
        
        NSLog(@"Selected Time: %@", formattedTime);
        // You can now use `formattedTime` (e.g., display in a label or store it)
    checkOut = formattedTime;
}

@end
