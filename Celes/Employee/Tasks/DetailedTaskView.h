//
//  DetailedTaskView.h
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailedTaskView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descTextField;

@property (weak, nonatomic) IBOutlet UITextField *completionTextField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

- (IBAction)addTask:(id)sender;

@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *email;

@property (strong,nonatomic) NSDictionary *taskDetail;



@end


NS_ASSUME_NONNULL_END
