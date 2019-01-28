//
//  ViewController.m
//  BBSpeak
//
//  Created by 程肖斌 on 2019/1/24.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "BBSpeak.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *word_tf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSURL fileURLWithPath:@""];
}

- (IBAction)speek:(UIButton *)sender {
    [BBSpeak.sharedManager speakString:self.word_tf.text];
}


@end
