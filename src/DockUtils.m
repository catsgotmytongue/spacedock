#import "DockUtils.h"

#import "DockResource+Addons.h"
#import "DockSquad+Addons.h"
#import "DockUpgrade.h"

NSString* intToString(int v)
{
    return [NSString stringWithFormat: @"%d", v];
}

NSSet* allAttributes(NSManagedObjectContext* context, NSString* entityName, NSString* attributeName)
{
    NSMutableSet* allSpecials = [NSMutableSet setWithCapacity: 0];
    NSEntityDescription* entity = [NSEntityDescription entityForName: entityName inManagedObjectContext: context];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity: entity];
    NSError* err;
    NSArray* existingItems = [context executeFetchRequest: request error: &err];

    if (existingItems.count > 0) {
        for (id item in existingItems) {
            NSString* attributeValue = [item valueForKey: attributeName];

            if ([attributeValue length] > 0) {
                [allSpecials addObject: attributeValue];
            }
        }
    }

    return [NSSet setWithSet: allSpecials];
}


NSString* factionCode(id target)
{
    NSString* faction = [target faction];
    return [faction substringToIndex: 3];
}

NSString* resourceCost(DockSquad* targetSquad)
{
    DockResource* res = targetSquad.resource;
    if (res) {
        if (res.isFlagship || res.isFighterSquadron || res.isSideboard) {
            return @"Inc";
        }
        return [NSString stringWithFormat: @"%@", res.cost];
    }
    return @"";
}

NSString* otherCost(DockSquad* targetSquad)
{
    NSNumber* additionalPoints = targetSquad.additionalPoints;
    if (additionalPoints && [additionalPoints intValue] > 0) {
        return [NSString stringWithFormat: @"%@", additionalPoints];
    }
    return @"";
}

NSMutableDictionary* createExistingItemsLookup(NSManagedObjectContext* context, NSEntityDescription* entity)
{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity: entity];
    NSError* err;
    NSArray* existingItems = [context executeFetchRequest: request error: &err];
    NSMutableDictionary* existingItemsLookup = [NSMutableDictionary dictionaryWithCapacity: existingItems.count];

    for (id existingItem in existingItems) {
        NSString* externalId = [existingItem externalId];

        if (externalId) {
            existingItemsLookup[externalId] = existingItem;
        }
    }

    return existingItemsLookup;
}

id processAttribute(id v, NSInteger aType)
{
    switch (aType) {
    case NSInteger16AttributeType:
        v = [NSNumber numberWithInt: [v intValue]];
        break;

    case NSBooleanAttributeType:
        v = [NSNumber numberWithBool: [v isEqualToString: @"Y"]];
        break;

    case NSStringAttributeType:
        v = [v stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        break;
    }
    return v;
}
