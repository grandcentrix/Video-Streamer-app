#import "FilesViewController.h"


@interface FilesViewController ()
- (void)setupDocumentControllerWithURL:(NSURL *)url;
@property (nonatomic, retain) UIDocumentInteractionController *docInteractionController;
@end


@implementation FilesViewController

@synthesize tableView = tableView_;
@synthesize sectionHeaderView = sectionHeaderView_;
@synthesize sectionHeaderLabel = sectionHeaderLabel_;
@synthesize docInteractionController = docInteractionController_;
@synthesize documentUrls = documentUrls_;


#pragma mark -
#pragma mark FilesViewController

- (void)dealloc
{
    [tableView_ release];
    [sectionHeaderView_ release];
    [sectionHeaderLabel_ release];
    [docInteractionController_ release];
    [documentUrls_ release];
    
    [super dealloc];
}

- (void)setupDocumentControllerWithURL:(NSURL *)url
{
    if (self.docInteractionController == nil)
    {
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }
    else
    {
        self.docInteractionController.URL = url;
    }
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark -
#pragma mark UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self;
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)interactionController
{
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:selectedRowIndexPath animated:YES];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.documentUrls.count;    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    
    // Number of rows determines if singular or plural form used in copy
    if ([self tableView:tableView numberOfRowsInSection:section] == 1)
    {
        title = @"Ready to stream this file to your Playstation 3 or Xbox 360. Exiting this app will stop streaming.";
    }
    else
    {
        title = @"Ready to stream these files to your Playstation 3 or Xbox 360. Exiting this app will stop streaming.";
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    // The file name
    NSURL *fileUrl = [self.documentUrls objectAtIndex:indexPath.row];
    cell.textLabel.text = [[fileUrl path] lastPathComponent];
    
    // Displays the highest resolution icon available for the file type.
    [self setupDocumentControllerWithURL:fileUrl];
    NSArray *icons = self.docInteractionController.icons;
    if ([icons count] > 0)
    {
        cell.imageView.image = [icons objectAtIndex:[icons count] - 1];
    }
    
    cell.detailTextLabel.text = self.docInteractionController.UTI;
    
    return cell;
}


#pragma mark -
#pragma mark UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // Presents a preview of the document if supported
//    NSURL *fileUrl = [self.documentUrls objectAtIndex:indexPath.row];
//    [self setupDocumentControllerWithURL:fileUrl];
//    BOOL canPreview = [self.docInteractionController presentPreviewAnimated:YES];
//    
//    // If cannot preview the document, then deselect the row
//    if (!canPreview)
//    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.sectionHeaderLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    return self.sectionHeaderView;
}

@end
