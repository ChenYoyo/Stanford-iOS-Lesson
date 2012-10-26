//
//  CalculatorBrain.m
//  Lecture_2_MyFirstiOSAPP
//
//  Created by Yoyo_Chen on 9/28/12.
//  Copyright (c) 2012 Yoyo_Chen. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray*) programStack
{
    if (_programStack == nil) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}
/*
- (void) setOperandStack:(NSMutableArray *)operandStack;
{
    _operandStack = operandStack;
}
*/
- (void) pushOperand:(double) operand {
    //remember to check the opperandStack pointer's availability
    //Q1: synthesize doesn't do anymore allocate
    //Q2: If I don't use nonatomic ,what would happen?
    // it would get a warning 
    [[self programStack] addObject:[NSNumber numberWithDouble:operand]];
    
}
/*
- (double) popOperand {
    NSNumber *operandObject = [[self operandStack] lastObject];
    if (operandObject) {
        [[self operandStack] removeLastObject];
    }
    return [operandObject doubleValue];
}
*/

//don't synthesize ,
//2 problems : 1. self.programStack is an internal state . we don't want to return our state to public method .
// copy 1.sent it mutable array return immutable array that cannot be modified
- (id)program
{
    return [self.programStack copy];
}

- (double) performOperation:(NSString *)operation {
    
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

+ (NSString *) descriptionOfProgram:(id)program{
    return @"Implement this in assignment";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack{
    double result = 0;
    //use id because we are not sure it's type  (operation(NSString),number(double)
    id topOfStack = [stack lastObject];
    if (topOfStack) {
        [stack removeLastObject];
    }
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result =[topOfStack doubleValue];
    }else if ([topOfStack isKindOfClass:[NSString class]]){
        NSString *operation = topOfStack;
        if([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrahend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffStack:stack];
            if (divisor) {
                result = [self popOperandOffStack:stack] / divisor;
            }
        } else if ([operation isEqualToString:@"Sin"]){
            result = sin([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"Cos"]){
            result = cos([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"Sqrt"]){
            result = sqrt([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"Pi"]){
            result = [self popOperandOffStack:stack] * M_PI;
        }
    } 
    return result;
}

+ (double)runProgram:(id)program{
    // stack is nil in iOS 5.0
    NSMutableArray *stack;
    //introspection
    if ([program isKindOfClass:[NSArray class]]) {
        //stack is static type, mutableCopy return id ,
        stack = [program mutableCopy];
    }
    
    return [self popOperandOffStack:stack];
}

- (void) dealloc {
    [[self programStack] removeAllObjects];
}
@end
