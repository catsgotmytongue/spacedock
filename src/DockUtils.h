#import <Foundation/Foundation.h>

@class DockSquad;

extern NSString* DockErrorDomain;

NSString* intToString(int v);
NSSet* allAttributes(NSManagedObjectContext* context, NSString* entityName, NSString* attributeName);

NSAttributedString* makeCentered(NSAttributedString* s);
NSString* factionCode(id target);
NSString* resourceCost(DockSquad* targetSquad);
NSString* otherCost(DockSquad* targetSquad);
NSMutableDictionary* createExistingItemsLookup(NSManagedObjectContext* context, NSEntityDescription* entity);
id processAttribute(id v, NSInteger aType);
