#import "DockShip.h"

@interface DockShip (Addons)
-(NSAttributedString*)styledDescription;
+(DockShip*)shipForId:(NSString*)externalId context:(NSManagedObjectContext*)context;
-(DockShip*)counterpart;
-(NSString*)plainDescription;
-(NSString*)factionCode;
-(BOOL)isBreen;
-(BOOL)isJemhadar;
-(BOOL)isDefiant;
-(BOOL)isUnique;
-(BOOL)isFederation;
-(BOOL)isBajoran;
-(int)techCount;
-(int)weaponCount;
-(int)crewCount;
-(NSArray*)actionStrings;
@end
