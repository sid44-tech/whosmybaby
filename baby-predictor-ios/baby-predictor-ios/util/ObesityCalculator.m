//
//  ObesityCalculator.m
//  whosmybaby
//
//  Created by iSB on 3/23/13.
//  Copyright (c) 2013 AppGenomix. All rights reserved.
//

#import "ObesityCalculator.h"

@implementation ObesityCalculator

+(NSString*)calculateObesityPercentage {
    //sqlite3 *database;
    NSString* unitsIn = @"-1";
    NSString* motherHeight1 = nil;
    NSString* motherHeight2 = nil;
    NSString* motherWeight = nil;
    NSString* fatherHeight1 = nil;
    NSString* fatherHeight2 = nil;
    NSString* fatherWeight = nil;
    NSString* householdMembers = nil;
    NSString* professionalCategoryIn = @"-1";
    NSString* gestationalSmokingIn = @"-1";
    NSString* babyWeight1 = nil;
    NSString* babyWeight2 = nil;
    
    return [self calculateObesityPercentage:unitsIn maternalHeight1:motherHeight1 maternalHeight2:motherHeight2 maternalWeight:motherWeight paternalHeight1:fatherHeight1 paternalHeight2:fatherHeight2 paternalWeight:fatherWeight householdMembersIn:householdMembers maternalOccupationIn:professionalCategoryIn gestationalSmokingIn:gestationalSmokingIn birthWeight1In:babyWeight1 birthWeight2In:babyWeight2];
}

+(NSString*)calculateObesityPercentage:(NSString*)unitsIn maternalHeight1:(NSString*)maternalHeight1 maternalHeight2:(NSString*)maternalHeight2 maternalWeight:(NSString*)maternalWeight paternalHeight1:(NSString*)paternalHeight1 paternalHeight2:(NSString*)paternalHeight2 paternalWeight:(NSString*)paternalWeight householdMembersIn:(NSString*)householdMembersIn maternalOccupationIn:(NSString*)maternalOccupationIn gestationalSmokingIn:(NSString*)gestationalSmokingIn birthWeight1In:(NSString*)birthWeight1In birthWeight2In:(NSString*)birthWeight2In {
    
    NSInteger units = [unitsIn integerValue];
    NSInteger maternalOccupation = [maternalOccupationIn integerValue];
    NSInteger gestationalSmoking = [gestationalSmokingIn integerValue];
    
        if (maternalHeight1 == nil || maternalHeight1 == (id)[NSNull null] || [[maternalHeight1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 || maternalWeight == nil || maternalWeight == (id)[NSNull null] || [[maternalWeight stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 || paternalHeight1 == nil || paternalHeight1 == (id)[NSNull null] || [[paternalHeight1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 || paternalWeight == nil || paternalWeight == (id)[NSNull null] || [[paternalWeight stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 || householdMembersIn == nil || householdMembersIn == (id)[NSNull null] || [[householdMembersIn stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 || maternalOccupation == 0 || gestationalSmoking == 0 || birthWeight1In == nil || birthWeight1In == (id)[NSNull null] || [[birthWeight1In stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
            return nil;
        }
    
    double motherHeight1 = [[NSDecimalNumber decimalNumberWithString:maternalHeight1] doubleValue];
    double motherHeight2 = 0;
    if (maternalHeight2 != nil && maternalHeight2 != (id)[NSNull null] && [[maternalHeight2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
        motherHeight2 = [[NSDecimalNumber decimalNumberWithString:maternalHeight2] doubleValue];
    }
    double motherWeight = [[NSDecimalNumber decimalNumberWithString:maternalWeight] doubleValue];;
    double fatherHeight1 = [[NSDecimalNumber decimalNumberWithString:paternalHeight1] doubleValue];;
    double fatherHeight2 = 0;
    if (paternalHeight2 != nil && paternalHeight2 != (id)[NSNull null] && [[paternalHeight2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
        fatherHeight2 = [[NSDecimalNumber decimalNumberWithString:paternalHeight2] doubleValue];
    }
    double fatherWeight = [[NSDecimalNumber decimalNumberWithString:paternalWeight] doubleValue];;
    double householdMember = [[NSDecimalNumber decimalNumberWithString:householdMembersIn] doubleValue];;
    double professionalCategory = [[NSNumber numberWithDouble:maternalOccupation] doubleValue];
    double smoking = [[NSNumber numberWithDouble:(gestationalSmoking-1)] doubleValue];
    double birthWeight1 = [[NSDecimalNumber decimalNumberWithString:birthWeight1In] doubleValue];;
    double birthWeight2 = 0;
    if (birthWeight2In != nil && birthWeight2In != (id)[NSNull null] && [[birthWeight2In stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
        birthWeight2 = [[NSDecimalNumber decimalNumberWithString:birthWeight2In] doubleValue];
    }
    
    double motherBMI = -1;
    double fatherBMI = -1;
    double babyKg = -1;

    if (units == 0) {
        double motherInches  = [self convertFtAndInchesToInches:motherHeight1 inches:motherHeight2];
        double fatherInches = [self convertFtAndInchesToInches:fatherHeight1 inches:fatherHeight2];
        motherBMI = [self calculateBMIImperial:motherWeight inches:motherInches];
        fatherBMI = [self calculateBMIImperial:fatherWeight inches:fatherInches];
        babyKg = [self convertPoundAndOuncesToKg:birthWeight1  ounces:birthWeight2];
    } else {
        motherBMI = [self calculateBMIMetric:motherWeight meters:motherHeight1];
        fatherBMI = [self calculateBMIMetric:fatherWeight meters:fatherHeight1];
        babyKg = birthWeight1;
    }
    
    NSDecimalNumber* result = [self calculateObesityPercentage:motherBMI paternalBMI:fatherBMI householdMembers:householdMember maternalOccupation:professionalCategory gestationalSmoking:smoking birthWeight:babyKg];
    
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    result = [result decimalNumberByRoundingAccordingToBehavior:behavior];
    
    return [[result stringValue] stringByAppendingString:@"%"];
}

+(NSDecimalNumber*)calculateObesityPercentage:(double)maternalBMI paternalBMI:(double)paternalBMI householdMembers:(double)householdMembers maternalOccupation:(double)maternalOccupation gestationalSmoking:(double)gestationalSmoking birthWeight:(double)birthWeight{
    
    double factors = (double)-10.61 + ((double)0.12 * maternalBMI) + ((double)0.18 * paternalBMI) - ((double)0.31 * householdMembers) -
    ((double)0.69 * maternalOccupation) + ((double)0.61 * gestationalSmoking) + ((double)0.75 * birthWeight);
    
    double top = exp(factors);
    double bottom = (double)1 + exp(factors);
    
    return [[NSDecimalNumber alloc] initWithDouble:((top/bottom)*(double)100)];
}

+(double)calculateBMIImperial:(double)pounds inches:(double)inches {
    return (pounds / (inches * inches)) * (double)703;
}

+(double)calculateBMIMetric:(double)kilograms meters:(double)meters {
    return (kilograms / (meters * meters));
}

+(double)convertFtAndInchesToInches:(double)feet inches:(double)inches {
    return (feet * (double)12) + inches;
}

+(double)convertPoundAndOuncesToKg:(double)pounds ounces:(double)ounces {
    return (pounds + (ounces / (double)16)) * (double)0.453592;
}

+(NSString*)convertPoundsAndOuncesToKg:(NSString*)pounds ounces:(NSString*)ounces {
    if (pounds == nil || pounds == (id)[NSNull null] || [[pounds stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return @"";
    }
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:pounds];
    double poundsTotal = [myNumber doubleValue];
    
    if (ounces != nil && ounces != (id)[NSNull null] && [[ounces stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
        NSNumber * myNumber2 = [f numberFromString:ounces];
        double ouncesTotal = [myNumber2 doubleValue] / (double)16;
        poundsTotal = poundsTotal + ouncesTotal;
    }
    
    double totalKg = poundsTotal * (double)0.453592;
    
    NSDecimalNumber* kg = [[NSDecimalNumber alloc] initWithDouble:totalKg];
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    kg = [kg decimalNumberByRoundingAccordingToBehavior:behavior];
    
    return [kg stringValue];

}

+(NSString*)conertKgToPounds:(NSString*)kg {
    if (kg == nil || kg == (id)[NSNull null] || [[kg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return @"";
    }
    
    double kgTotal = [[NSDecimalNumber decimalNumberWithString:kg] doubleValue];
    NSDecimalNumber* poundsTotal = [[NSDecimalNumber alloc] initWithDouble:(kgTotal * (double)2.20462)];
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    poundsTotal = [poundsTotal decimalNumberByRoundingAccordingToBehavior: behavior];
    return [poundsTotal stringValue];
}

+(NSArray*)convertKgToPoundsAndOunces:(NSString*)kg {
    if (kg == nil || kg == (id)[NSNull null] || [[kg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return [NSArray arrayWithObjects:@"", @"", nil];
    }
    
    double kgTotal = [[NSDecimalNumber decimalNumberWithString:kg] doubleValue];
    NSDecimalNumber* poundsTotal = [[NSDecimalNumber alloc] initWithDouble:(kgTotal * (double)2.20462)];
    
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *whole = [poundsTotal decimalNumberByRoundingAccordingToBehavior: behavior];
    NSDecimalNumber *decimal = [poundsTotal decimalNumberBySubtracting: whole];
    decimal = [decimal decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithInt:16]];
    decimal = [decimal decimalNumberByRoundingAccordingToBehavior:behavior];
    NSString* stringKg = [whole stringValue];
    NSString* stringLbs = [decimal stringValue];
    
    return [NSArray arrayWithObjects:stringKg, stringLbs, nil];
}

+(NSString*)convertFeetAndInchesToMeter:(NSString*)feet inches:(NSString*)inches {
    if (feet == nil || feet == (id)[NSNull null] || [[feet stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return @"";
    }
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:feet];
    int totalInches = [myNumber intValue] * 12;
    
    if (inches != nil && inches != (id)[NSNull null] && [[inches stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
        totalInches = totalInches + [[f numberFromString:inches] intValue];
    }
    
    double totalMeters = (double)totalInches * (double)0.0254;
    NSDecimalNumber* meters = [[NSDecimalNumber alloc] initWithDouble:totalMeters];
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    meters = [meters decimalNumberByRoundingAccordingToBehavior:behavior];
    
    return [meters stringValue];
}

+(NSArray*)convertMetersToFeetAndInches:(NSString*) meters {
    if (meters == nil || meters == (id)[NSNull null] || [[meters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return [NSArray arrayWithObjects:@"", @"", nil];
    }
    
    double metersTotal = [[NSDecimalNumber decimalNumberWithString:meters] doubleValue];
    NSDecimalNumber* feetTotal = [[NSDecimalNumber alloc] initWithDouble:(metersTotal * (double)3.28084)];
    
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];

    NSDecimalNumber *whole = [feetTotal decimalNumberByRoundingAccordingToBehavior: behavior];
    NSDecimalNumber *decimal = [feetTotal decimalNumberBySubtracting: whole];
    decimal = [decimal decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithInt:12]];
    decimal = [decimal decimalNumberByRoundingAccordingToBehavior:behavior];
    NSString* stringFt = [whole stringValue];
    NSString* stringIn = [decimal stringValue];
    
    return [NSArray arrayWithObjects:stringFt, stringIn, nil];
}

@end
