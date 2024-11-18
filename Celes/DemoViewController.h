//
//  DemoViewController.h
//  Celes
//
//  Created by Celestial on 11/11/24.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoViewController : UIViewController <UITextFieldDelegate>

- (IBAction)signUp:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet TextFieldValidator *idTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *emailTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *nameTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *contactTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *passwordTextField;

@property (weak, nonatomic) IBOutlet TextFieldValidator *confirmTextField;


@end

NS_ASSUME_NONNULL_END
