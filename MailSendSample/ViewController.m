//
//  ViewController.m
//  MailSendSample
//
//  Created by onishi on 2014/07/16.
//  Copyright (c) 2014年 Kronos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *to;
@property (weak, nonatomic) IBOutlet UITextField *subject;
@property (weak, nonatomic) IBOutlet UITextView *body;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doSend:(id)sender {
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    // メール本文を設定
    [mailPicker setMessageBody:self.body.text isHTML:NO];
    
    // 題名を設定
    [mailPicker setSubject:self.subject.text];
    
    NSArray *tos = [self.to.text componentsSeparatedByString:@","];
    if ([tos count]< 1) {
        return;
    }
    // 宛先を設定
    [mailPicker setToRecipients:tos];
    
    // 添付ファイル名を設定
//    NSString *imagePath = [NSString stringWithFormat:@"%@/test.gif" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
//    NSData* fileData = [NSData dataWithContentsOfFile:imagePath];
//    [mailPicker addAttachmentData:fileData mimeType:@"image/gif" fileName:imagePath];

    [self presentViewController:mailPicker animated:YES completion:nil];
    
}

- (IBAction)doClear:(id)sender {
    self.to.text = @"";
    self.subject.text = @"";
    self.body.text = @"";
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result){
        case MFMailComposeResultCancelled:  // キャンセル
        case MFMailComposeResultSaved:      // 保存
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"キャンセル、または保存しました\n送信されていません。"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            break;
        }
        case MFMailComposeResultSent:       // 送信成功
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"送信に成功しました"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            break;
        }
        case MFMailComposeResultFailed:     // 送信に失敗した場合
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"送信に失敗しました"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            break;
        }
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
