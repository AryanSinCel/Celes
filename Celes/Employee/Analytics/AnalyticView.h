//
//  AnalyticView.h
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnalyticView : UIViewController

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *email;
@property (weak, nonatomic) IBOutlet UILabel *pendingProject;
@property (weak, nonatomic) IBOutlet UILabel *completedProject;
@property (weak, nonatomic) IBOutlet UILabel *pendingTask;
@property (weak, nonatomic) IBOutlet UILabel *completedTask;
@property (weak, nonatomic) IBOutlet UILabel *totalAttendace;

@end

NS_ASSUME_NONNULL_END
