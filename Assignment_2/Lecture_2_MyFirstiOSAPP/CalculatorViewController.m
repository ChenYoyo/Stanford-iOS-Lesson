//
//  CalculatorViewController.m
//  Lecture_2_MyFirstiOSAPP
//
//  Created by Yoyo_Chen on 9/27/12.
//  Copyright (c) 2012 Yoyo_Chen. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
// create private property
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

//explanation of setter and getter
@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize CommandLineDisplay = _CommandLineDisplay;

- (CalculatorBrain *) brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    
    return _brain;
}
//typedef IBAction:void
//id: any type of object, good or bad thing

//sender is a pointer to the object that I want to send the message to .which is the object sending me this

//when you change (id)sender to (UIButton*)sender ,the message [send ] will show compatible type
- (IBAction)digitPressed:(UIButton* )sender {
    NSString *digit = [sender currentTitle];
    if ([self userIsInTheMiddleOfEnteringANumber]) {
        
        //UILabel *myDisplay = [self display];//self.display
        
        //hold option key and choose message to display doc
        // var "."
        //, "nothing before .", "many 0s before ."
        //, "at least one . after ."
        
        NSString *currentText = self.display.text;
        

        NSRange dotRangeLocation =[currentText rangeOfString:@"."];
        if (dotRangeLocation.location == NSNotFound){
            if ([digit isEqualToString:@"."] ) {
                currentText = [currentText stringByAppendingString:digit];
                self.display.text = currentText;
                self.CommandLineDisplay.text = [self.CommandLineDisplay.text stringByAppendingString:digit];
            } else if([currentText isEqualToString:@"0"] && [digit isEqualToString:@"0"]){
                // key in "many 0s before ." will have no response 
            } else {
                currentText = [currentText stringByAppendingString:digit];
                self.display.text = currentText;
                self.CommandLineDisplay.text = [self.CommandLineDisplay.text stringByAppendingString:digit];
                NSLog(@"digit pressed = %@", currentText);
            }
        } else if ([digit isEqualToString:@"."]) {
                    //key in "." again will have no response
            
        } else {
            currentText = [currentText stringByAppendingString:digit];
            self.display.text = currentText;
            self.CommandLineDisplay.text = [self.CommandLineDisplay.text stringByAppendingString:digit];
        }


    } else  {
        if (![digit isEqualToString:@"."]) {
            self.display.text = digit;
            self.CommandLineDisplay.text = [self.CommandLineDisplay.text stringByAppendingString:digit];
            [self setUserIsInTheMiddleOfEnteringANumber:YES];
        } else {
            self.display.text = @"";
        }
    }
    
    
           //short for
    //self.display.text = [self.display.text stringByAppendingString::digit];
    //self.display.text = [[[self display] text] stringByAppendingString:digit];
    
}


- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    [self setUserIsInTheMiddleOfEnteringANumber:NO];
    self.CommandLineDisplay.text = [self.CommandLineDisplay.text stringByAppendingString:@" "];
    
}

- (IBAction)operationPressed:(UIButton *)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    self.CommandLineDisplay.text = [self.CommandLineDisplay.text stringByAppendingString:sender.currentTitle];
    NSLog(@"operation pressed = %@", resultString);

}
- (IBAction)clearPressed {
    self.display.text = @"";
    self.CommandLineDisplay.text = @"";
    _brain = nil;
}


@end
