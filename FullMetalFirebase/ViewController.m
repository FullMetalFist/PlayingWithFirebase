//
//  ViewController.m
//  FullMetalFirebase
//
//  Created by Michael Vilabrera on 8/5/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "ViewController.h"

#import <Firebase/Firebase.h>
#import "Constants.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *postButton;
@property (nonatomic, strong) UIButton *getButton;
@property (nonatomic, strong) NSString *dataToPass;

@property (nonatomic, strong) Firebase *rootReference;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rootReference = [[Firebase alloc] initWithUrl:FIREBASE_URL];

    [self textFieldBuild];
    [self postButtonBuild];
    [self getButtonBuild];
    [self labelBuild];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Firebase methods
- (void) firebasePost
{
    // create a reference to a Firebase URL
    // write data to Firebase
    [self.rootReference setValue:self.dataToPass];
}

- (void) firebaseRead
{
    [self.rootReference observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ : %@", snapshot.name, snapshot.value);
        self.dataToPass = snapshot.value;
    }];
}

#pragma mark UI build methods
- (void) postButtonBuild
{
    self.postButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.postButton.frame = CGRectMake(110.0f, 200.0f, 100.0f, 44.0f);
    [self.postButton setTitle:@"Post"
                     forState:UIControlStateNormal];
    [self.postButton setTitle:@"Posted"
                     forState:UIControlStateHighlighted];
    [self.postButton addTarget:self
                        action:@selector(buttonIsPressed:)
              forControlEvents:UIControlEventTouchDown];
    [self.postButton addTarget:self
                        action:@selector(buttonIsTapped:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.postButton];
}

- (void) getButtonBuild
{
    self.getButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.getButton.frame = CGRectMake(110.0f, 250.0f, 100.0f, 44.0f);
    [self.getButton setTitle:@"Get"
                    forState:UIControlStateNormal];
    [self.getButton setTitle:@"Got"
                    forState:UIControlStateHighlighted];
    [self.getButton addTarget:self
                       action:@selector(buttonIsPressed:)
             forControlEvents:UIControlEventTouchDown];
    [self.getButton addTarget:self
                       action:@selector(buttonIsTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getButton];
}

- (void) buttonIsPressed:(UIButton *)sender
{
    NSLog(@"Transmitting");
    if ([sender isEqual:self.getButton]) {
        NSLog(@"Get button");
        [self firebaseRead];
        self.label.text = self.dataToPass;
    }
    else if ([sender isEqual:self.postButton]) {
        NSLog(@"Post button");
        self.dataToPass = self.textField.text;
        [self firebasePost];
    }
}

- (void) buttonIsTapped:(UIButton *)sender
{
    NSLog(@"Transmit Complete");
}

- (void) labelBuild
{
    CGRect labelFrame = CGRectMake(110.0f, 300.0f, 220.0f, 44.0f);
    self.label = [[UILabel alloc] initWithFrame:labelFrame];
    self.label.text = @"Nothing Retrieved";
    self.label.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:self.label];
}

- (void) textFieldBuild
{
    self.textField = [[UITextField alloc] init];
    self.textField.frame = CGRectMake(38.0f, 130.0f, 220.0f, 31.0f);
    self.textField.delegate = self;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
