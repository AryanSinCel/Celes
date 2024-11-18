//
//  AttendanceView.h
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttendanceView : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *checkInPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *checkOutPicker;
- (IBAction)checkIn:(id)sender;
- (IBAction)checkOut:(id)sender;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *email;
@end

NS_ASSUME_NONNULL_END
