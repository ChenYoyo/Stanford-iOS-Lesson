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
        
        UILabel *myDisplay = [self display];//self.display
        
        //hold option key and choose message to display doc
        NSString *currentText = [myDisplay text];
/*
        NSRange stringRange =[currentText rangeOfString:@"."];
        if (stringRange.location == NSNotFound){
            
        }
*/
        NSString *newText = [currentText stringByAppendingString:digit];
        myDisplay.text = newText;

    } else  {
        self.display.text = digit;
        [self setUserIsInTheMiddleOfEnteringANumber:YES];
        
    }
           //short for
    //self.display.text = [self.display.text stringByAppendingString::digit];
    //self.display.text = [[[self display] text] stringByAppendingString:digit];
    
}


- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    [self setUserIsInTheMiddleOfEnteringANumber:NO];
    
}

- (IBAction)operationPressed:(UIButton *)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    NSLog(@"operation pressed = %@", resultString);

}
@end
