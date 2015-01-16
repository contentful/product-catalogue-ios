//
//  CDASpaceSelectionViewController.m
//
//  Created by Boris Bügling on 09/01/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import <ContentfulStyle/UIColor+Contentful.h>
#import <ContentfulStyle/UIFont+Contentful.h>

#import "CDASpaceSelectionViewController.h"
#import "Constants.h"

NSString* const CDAAccessTokenKey           = @"CDAAccessTokenKey";
NSString* const CDASpaceIdentifierKey       = @"CDASpaceIdentifierKey";
NSString* const CDASpaceChangedNotification = @"CDASpaceChangedNotification";

@interface CDASpaceSelectionViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accessTokenTextField;
@property (weak, nonatomic) IBOutlet UITextView *helpLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *loadSpaceButton;
@property (weak, nonatomic) IBOutlet UILabel *loginInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *productCatalogueLabel;
@property (weak, nonatomic) IBOutlet UITextField *spaceKeyTextField;
@property (weak, nonatomic) IBOutlet UIView *textFieldContainerView;

@end

#pragma mark -

@implementation CDASpaceSelectionViewController

-(BOOL)hasValidContent {
    return self.accessTokenTextField.text.length > 0 && self.spaceKeyTextField.text.length > 0;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    self.accessTokenTextField.delegate = self;
    self.spaceKeyTextField.delegate = self;

    [self.loadSpaceButton addTarget:self
                             action:@selector(loadSpaceTapped)
                   forControlEvents:UIControlEventTouchUpInside];

    self.accessTokenTextField.font = [UIFont bodyTextFont];
    self.helpLabel.font = [UIFont bodyTextFont];
    self.helpLabel.text = FIRST_LAUNCH_MESSAGE;
    self.infoLabel.font = [UIFont bodyTextFont];
    self.loadSpaceButton.backgroundColor = [UIColor contentfulPrimaryColor];
    self.loadSpaceButton.titleLabel.font = [UIFont buttonTitleFont];
    self.loginInfoLabel.font = [UIFont bodyTextFont];
    self.productCatalogueLabel.font = [UIFont titleBarFont];
    self.spaceKeyTextField.font = [UIFont bodyTextFont];

    for (UIView* view in @[ self.loadSpaceButton, self.textFieldContainerView ]) {
        view.layer.cornerRadius = 4.0;
    }

    CAGradientLayer* layer = [CAGradientLayer layer];
    layer.colors = @[(id)[UIColor colorWithRed:0.165 green:0.361 blue:0.847 alpha:1.000].CGColor,
                     (id)[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.000].CGColor];
    layer.endPoint = CGPointMake(1.0, 1.0);
    layer.frame = self.view.bounds;
    layer.startPoint = CGPointMake(0.0, 0.0);

    [self.view.layer insertSublayer:layer atIndex:0];
}

#pragma mark - Actions

-(void)loadSpaceTapped {
    [self.view endEditing:YES];

    NSString* accessToken = self.accessTokenTextField.text;
    NSString* spaceKey = self.spaceKeyTextField.text;
    CDAClient* client = [[CDAClient alloc] initWithSpaceKey:spaceKey accessToken:accessToken];

    [client fetchSpaceWithSuccess:^(CDAResponse *response, CDASpace *space) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CDASpaceChangedNotification
                                                            object:self
                                                          userInfo:@{ CDAAccessTokenKey: accessToken,
                                                                      CDASpaceIdentifierKey: spaceKey }];
    } failure:^(CDAResponse *response, NSError *error) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.loadSpaceButton.enabled = [self hasValidContent];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [self hasValidContent];
}

@end
