//
//  COLCViewController.m
//  iOSGumbo
//
//  Created by Brian Clear (gbxc) on 30/04/2014.
//  Copyright (c) 2014 Brian Clear (gbxc). All rights reserved.
//

#import "COLCViewController.h"
#import "OCGumbo+Query.h"
@interface COLCViewController ()

@end

@implementation COLCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    BOOL _debugOn = TRUE;
    
    
    
    NSLog(@"\n\n===============iOS Feed Info==================");
    NSString *busHTMLString_ = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.tfl.gov.uk/maps_/bus-route-maps?Query=Barking%20and%20Dagenham"]
                                                        encoding:NSUTF8StringEncoding
                                                           error:nil];
    if (busHTMLString_) {
        OCGumboDocument *busDoc_ = [[OCGumboDocument alloc] initWithHTMLString:busHTMLString_];
        
        //Dont panic if these dont have data - have noticed them blank sometimes
        NSLog(@"document:%@", busDoc_);
        NSLog(@"has doctype: %d", busDoc_.hasDoctype);
        NSLog(@"publicID: %@", busDoc_.publicID);
        NSLog(@"systemID:%@", busDoc_.systemID);
        NSLog(@"title:%@", busDoc_.title);
        
        //-----------------------------------------------------------------------------------
        
        NSArray *hrefArray_ = busDoc_.Query(@"div.vertical-button-container").find(@"a");
        
        for (OCGumboNode *hrefNode_ in hrefArray_) {
            NSLog(@"TEXT:'%@'\n", hrefNode_.text());
            NSLog(@"href:'%@'\n", hrefNode_.attr(@"href"));
            
        }
        //-----------------------------------------------------------------------------------
        //PDFs - <div class="multi-document-download-container">
        //OCQueryObject *divPDFs_ = busDoc_.Query(@"div.multi-document-download-container");
        NSArray *pdfsHrefArray_ = busDoc_.Query(@"div.multi-document-download-container").find(@"a");
        for (OCGumboNode *hrefNode_ in pdfsHrefArray_) {
            NSLog(@"TEXT:'%@'\n", hrefNode_.text());
            NSLog(@"href:'%@'\n", hrefNode_.attr(@"href"));
            
        }
        if(_debugOn)NSLog(@"");
        
    }else{
        NSLog(@"ERROR: [%s] busHTMLString_ is nil", __PRETTY_FUNCTION__);
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
