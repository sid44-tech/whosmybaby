//
//  ObesityCalculator.h
//  whosmybaby
//
//  Created by iSB on 3/23/13.
//  Copyright (c) 2013 AppGenomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObesityCalculator : NSObject

+(NSString*)calculateObesityPercentage;
+(NSString*)calculateObesityPercentage:(NSString*)unitsIn maternalHeight1:(NSString*)maternalHeight1 maternalHeight2:(NSString*)maternalHeight2 maternalWeight:(NSString*)maternalWeight paternalHeight1:(NSString*)paternalHeight1 paternalHeight2:(NSString*)paternalHeight2 paternalWeight:(NSString*)paternalWeight householdMembersIn:(NSString*)householdMembersIn maternalOccupationIn:(NSString*)maternalOccupationIn gestationalSmokingIn:(NSString*)gestationalSmokingIn birthWeight1In:(NSString*)birthWeight1In birthWeight2In:(NSString*)birthWeight2In;
+(NSString*)convertPoundsAndOuncesToKg:(NSString*)pounds ounces:(NSString*)ounces;
+(NSString*)conertKgToPounds:(NSString*)kg;
+(NSArray*)convertKgToPoundsAndOunces:(NSString*)kg;
+(NSArray*)convertMetersToFeetAndInches:(NSString*) meters;
+(NSString*)convertFeetAndInchesToMeter:(NSString*)feet inches:(NSString*)inches;

@end
