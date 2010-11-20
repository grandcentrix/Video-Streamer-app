#import "InstructionsViewController.h"
#import "UpnpServer.h"


@interface InstructionsViewController ()
@property (nonatomic, retain) DirectoryWatcher *directoryWatcher;
@property (nonatomic, retain) NSMutableArray *documentUrls;
@property (nonatomic, retain) UIDocumentInteractionController *docInteractionController;
@end


@implementation InstructionsViewController

@synthesize directoryWatcher = directoryWatcher_;
@synthesize documentUrls = documentUrls_;
@synthesize docInteractionController = docInteractionController_;
@synthesize containerView = containerView_;
@synthesize infoView = infoView_;
@synthesize addFromiTunesView = addFromiTunesView_;
@synthesize tableView = tableView_;
@synthesize sectionHeaderView = sectionHeaderView_;
@synthesize sectionHeaderLabel = sectionHeaderLabel_;


#pragma mark -
#pragma mark InstructionsViewController

- (void)dealloc
{
    [directoryWatcher_ release];
    [documentUrls_ release];
    [docInteractionController_ release];
    [containerView_ release];
    [infoView_ release];
    [addFromiTunesView_ release];
    [tableView_ release];
    [sectionHeaderView_ release];
    [sectionHeaderLabel_ release];

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

-(IBAction)switchInfo:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.containerView cache:YES];
    	
	// If the info view is hidden, hide other views and show
    if (self.infoView.hidden)
    {
        self.infoView.hidden = NO;
        self.addFromiTunesView.hidden = YES;
        self.tableView.hidden = YES;
    }
    // If switching from hidden view, determine which view to show based on if 
    // files in directory
    else
    {
        [self directoryDidChange:self.directoryWatcher];
    }
    
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark DirectoryWatcherDelegate

- (void)directoryDidChange:(DirectoryWatcher *)folderWatcher
{
	[self.documentUrls removeAllObjects];	

    NSArray *files = [UpnpServer documentsDirectoryContents];
    if (files == nil || [files count] == 0)
    {
        self.infoView.hidden = YES;
        self.addFromiTunesView.hidden = NO;
        self.tableView.hidden = YES;
    }
    else
    {        
        // Iterates through all files in the Documents directory
        for (NSString* file in [files objectEnumerator])
        {
            NSString *filePath = [[UpnpServer filePath] stringByAppendingPathComponent:file];
            NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
            
            BOOL isDirectory;
            [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            // Add the document URL to our list (ignore the "Inbox" folder)
            if (!(isDirectory && [file isEqualToString: @"Inbox"]))
            {
                [self.documentUrls addObject:fileUrl];
            }
        }
        
        [self.tableView reloadData];
        
        self.infoView.hidden = YES;
        self.addFromiTunesView.hidden = YES;
        self.tableView.hidden = NO;
    }
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Start monitoring the document directory
    NSMutableArray *documentUrls = [[NSMutableArray alloc] init];
    self.documentUrls = documentUrls;
    [documentUrls release];
    self.directoryWatcher = [DirectoryWatcher watchFolderWithPath:[UpnpServer filePath] delegate:self];
    
    // Switch views based on if files in directory
    [self directoryDidChange:self.directoryWatcher];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Supports all orientations
    return YES;
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
        title = @"Ready to stream this file to your Xbox 360 or Playstation 3. Exiting this app will stop streaming.";
    }
    else
    {
        title = @"Ready to stream these files to your Xbox 360 or Playstation 3. Exiting this app will stop streaming.";
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
    // Presents a preview of the document if supported
    NSURL *fileUrl = [self.documentUrls objectAtIndex:indexPath.row];
    [self setupDocumentControllerWithURL:fileUrl];
    BOOL canPreview = [self.docInteractionController presentPreviewAnimated:YES];
    
    // If cannot preview the document, then deselect the row
    if (!canPreview)
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.sectionHeaderLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    return self.sectionHeaderView;
}

@end
