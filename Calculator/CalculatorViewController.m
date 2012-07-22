//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Navid Rahimi on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userEnteredFloat;
@end

@implementation CalculatorViewController
@synthesize opDisplay;
@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userEnteredFloat;
@synthesize brain = _brain;

- (CalculatorBrain *)brain{
    if (! _brain){
        _brain = [[CalculatorBrain alloc] init];
    }
    
    return _brain;
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.opDisplay.text = [self.opDisplay.text stringByAppendingString:@" "];
    self.opDisplay.text = [self.opDisplay.text stringByAppendingString:self.display.text];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userEnteredFloat = NO;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit= [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber){
        self.display.text = [self.display.text stringByAppendingString:digit];
    }else{
        if ([digit isEqualToString:@"."]) digit = [NSString stringWithString:@"0."];
            
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    } 
}

- (IBAction)dotPressed:(UIButton *)sender {
    if (! self.userEnteredFloat) {
        self.userEnteredFloat = YES;
        [self digitPressed:sender];
    }
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    self.opDisplay.text = [self.opDisplay.text stringByAppendingString:@" "];
    self.opDisplay.text = [self.opDisplay.text stringByAppendingString:operation];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)clearPressed {
    self.opDisplay.text = [NSString stringWithFormat:@""];
    self.display.text = [NSString stringWithFormat:@"0"];
    [self.brain clearStack];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userEnteredFloat = NO;
}

- (void)viewDidUnload {
    [self setOpDisplay:nil];
    [super viewDidUnload];
}
@end
