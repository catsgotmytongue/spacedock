#import "DockFlagshipsViewController.h"

#import "DockFlagship+Addons.h"
#import "DockDetailViewController.h"

@class DockShip;
@class DockSquad;

@interface DockFlagshipsViewController ()
@property (nonatomic, strong) DockFlagshipPicked onFlagshipPicked;
@property (nonatomic, weak) DockShip* targetShip;
@property (nonatomic, weak) DockSquad* targetSquad;
@end

@implementation DockFlagshipsViewController

-(void)viewDidLoad
{
    self.cellIdentifer = @"flagship";
    [super viewDidLoad];
}

-(NSString*)entityName
{
    return @"Flagship";
}

// Customize the appearance of table view cells.
-(void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    DockFlagship* flagship = [self.fetchedResultsController objectAtIndexPath: indexPath];
    cell.textLabel.text = flagship.name;
}

-(BOOL)tableView:(UITableView*)tableView shouldHighlightRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (_targetSquad) {
        DockFlagship* flagship = [self.fetchedResultsController objectAtIndexPath: indexPath];
        return [flagship compatibleWithShip: _targetShip];
    }
    
    return YES;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (_targetSquad) {
        DockFlagship* flagship = [self.fetchedResultsController objectAtIndexPath: indexPath];
        _onFlagshipPicked(flagship);
        [self clearTarget];
    } else {
        [self performSegueWithIdentifier: @"ShowFlagshipDetails" sender: self];
    }
}

-(void)tableView:(UITableView*)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath
{
    [self.tableView selectRowAtIndexPath: indexPath animated: NO scrollPosition: UITableViewScrollPositionMiddle];
    [self performSegueWithIdentifier: @"ShowFlagshipDetails" sender: self];
}

-(void)targetSquad:(DockSquad*)squad ship:(DockShip*)ship onPicked:(DockFlagshipPicked)onPicked
{
    _targetSquad = squad;
    _targetShip = ship;
    _onFlagshipPicked = onPicked;
}

-(void)clearTarget
{
    _targetSquad = nil;
    _onFlagshipPicked = nil;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString*)identifier sender:(id)sender
{
    return NO;
}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    NSString* identifier = [segue identifier];
    id destination = [segue destinationViewController];

    if ([identifier isEqualToString: @"ShowFlagshipDetails"]) {
        DockDetailViewController* controller = (DockDetailViewController*)destination;
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject* target = [self.fetchedResultsController objectAtIndexPath: indexPath];
        controller.target = target;
    }
}

@end
