//
//  FMMailHelper.m
//   v.1.1
//  HabitSeed
//
//  Created by TW on 4/24/13.
//  Copyright (c) 2013 fluidmobile. All rights reserved.
//

#import "FMMailHelper.h"

#import <MessageUI/MessageUI.h>
@interface FMMailHelper () <MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) NSString *alertMessage;
@property (nonatomic, strong) NSString *alertTitle;
@property (nonatomic, strong) FMMailCompleteBlock completeBlock;
@end

@implementation FMMailHelper

- (void)mailOnViewController:(UIViewController *)viewController subject:(NSString *)subject toRecipients:(NSArray *)recipients completeAlertMessage:(NSString *)completeAlertMessage completeAlertTitle:(NSString *)completeAlertTitle completeBlock:(FMMailCompleteBlock)completeBlock{
	return [self mailOnViewController:viewController subject:subject toRecipients:recipients completeAlertMessage:completeAlertMessage completeAlertTitle:completeAlertTitle body:nil html:NO completeBlock:completeBlock];
}

- (void)mailOnViewController:(UIViewController *)viewController subject:(NSString *)subject toRecipients:(NSArray *)recipients completeAlertMessage:(NSString *)completeAlertMessage completeAlertTitle:(NSString *)completeAlertTitle body:(NSString *)body html:(BOOL)html completeBlock:(FMMailCompleteBlock)completeBlock{
	self.alertMessage = completeAlertMessage;
	self.alertTitle = completeAlertTitle;
    self.completeBlock = [completeBlock copy];
	MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    
    mailComposer.navigationBar.tintColor = [UIColor whiteColor];
    
	if ([MFMailComposeViewController canSendMail]) {
		mailComposer.mailComposeDelegate = self;
		if (recipients) {
                [mailComposer setToRecipients:recipients];
		}
		[mailComposer setSubject:subject];

		[mailComposer setMessageBody:body isHTML:html];
		[viewController presentViewController:mailComposer animated:YES completion:nil];
	}
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *) LINT_SUPPRESS_UNUSED_ATTRIBUTE error {
//	switch (result) {
//		case MFMailComposeResultCancelled:
//			[FMAppAnalyzer logEvent:FM_ANALYZER_EVENT_ABOUT_EMAIL_CANCEL];
//			break;
//
//		case MFMailComposeResultSaved:
//			[FMAppAnalyzer logEvent:FM_ANALYZER_EVENT_ABOUT_EMAIL_SAVE];
//			break;
//
//		case MFMailComposeResultFailed:
//			[FMAppAnalyzer logEvent:FM_ANALYZER_EVENT_ABOUT_EMAIL_FAIL];
//			break;
//
//		case MFMailComposeResultSent:
//			[FMAppAnalyzer logEvent:FM_ANALYZER_EVENT_ABOUT_EMAIL_SUCCESSFULL];
//
//		default:
//			break;
//	}

	if (result == MFMailComposeResultSent && _alertMessage) {
		UIAlertView *alert = [[UIAlertView alloc] init];
		[alert setTitle:_alertTitle];
		[alert setMessage:_alertMessage];
		[alert addButtonWithTitle:@"OK"];
		[alert show];
	}
    if (_completeBlock != NULL){
        _completeBlock();
    }
	[controller dismissViewControllerAnimated:YES completion:nil];
}

@end
