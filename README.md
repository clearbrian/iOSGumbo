iOSGumbo - An Objective-C HTML5 parser.
=====================================
OCGumbo is an Mac Objective-C wrapper of the [Google Gumbo HTML5 parser](https://github.com/google/gumbo-parser).

iOSGumbo is an iOS port of [OCGumbo](https://github.com/tracy-e/OCGumbo)..


To use Google Gumbo in your own project

 1. Copy the <PROJROOT>/OCGumbo folder from this project to your own project directory.
 I placed it parallel to the xcode project.
 2. Drag the <PROJROOT>/OCGumbo folder into your XCode project.
 
 2. You only need certain files to use gumbo so DELETE > REMOVE REFERENCES for all file under OCGumbo except the following
 
 /OCGumbo/OCGumbo.h
 /OCGumbo/OCGumbo.m
 /OCGumbo/OCGumbo+Query.h
 /OCGumbo/OCGumbo+Query.m
 /OCGumbo/gumbo/src     < and all its contents
 
 delete >> remove references all other files under /OCGumbo/gumbo/
  
In an objective-C class
```objective-c
#import "OCGumbo+Query.h"
```


```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
    BOOL _debugOn = TRUE;
    
    NSLog(@"\n\n===============London Bus info ==================");
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
        //Find all links in this div with 
    	/*
		<div class="vertical-button-container">
			<a href="?Query=Barking and Dagenham" class="plain-button external-link" target="_parent">Barking and Dagenham</a>
			<a href="?Query=Barnet" class="plain-button external-link" target="_parent">Barnet</a>
			<a href="?Query=Bexley" class="plain-button external-link" target="_parent">Bexley</a>
	
		*/
        //-----------------------------------------------------------------------------------
		//Find all links in this div with 
        NSArray *hrefArray_ = busDoc_.Query(@"div.vertical-button-container").find(@"a");
        
        for (OCGumboNode *hrefNode_ in hrefArray_) {
            NSLog(@"TEXT:'%@'\n", hrefNode_.text());
            NSLog(@"href:'%@'\n", hrefNode_.attr(@"href"));
            
        }
        //-----------------------------------------------------------------------------------
        /*
        <div class="multi-document-download-container">
			   <a class="document-download-wrap  pdf pdf" href="/cdn/static/cms/documents/bus-route-maps/barking-longbridge-road-261013.pdf" target="_parent">
				  <div class="document-download-text">
					 <p>Barking (Longbridge Road)</p>
				  </div>
				  <div class="document-download-icon download-doc" />
			   </a>
			   <a class="document-download-wrap  pdf pdf" href="/cdn/static/cms/documents/bus-route-maps/barking-310813.pdf" target="_parent">
				  <div class="document-download-text">
					 <p>Barking</p>
				  </div>
				  <div class="document-download-icon download-doc" />
			   </a>
        
        */
        
        
        
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

```

Contact
=======

Email: support@cityoflondonconsulting.com


License
=======

[Apache License](http://www.apache.org/licenses/)






Doc below are from OCGumbo copied for ease

Basic Usage
===========

 1. Add [Gumbo](https://github.com/google/gumbo-parser/tree/master/src) sources or lib to your project.
 2. Add [OCGumbo](https://github.com/tracy-e/OCGumbo/tree/master/OCGumbo) file and import "OCGumbo.h", then use OCGumboDocument to parse an html string.

####Objects####

<table>
<tr><th>Class</th><th>Description</th></tr>
<tr><td>OCGumboDocument</td><td>the root of a document tree</td></tr>
<tr><td>OCGumboElement</td><td>an element in an HTML document</td></tr>
<tr><td>OCGumboText</td><td>the textual content of an element</td></tr>
<tr><td>OCGumboNode	</td><td>a single node in the document tree</td></tr>
<tr><td>OCGumboAttribute</td><td>an attribute of an Element object</td></tr>
</table>

####Examples####

```objective-c
OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString:htmlString];
OCGumboElement *root = document.rootElement;
//document: do something with the document.
//rootElement: do something with the html tree.
```

Extension
========

Now, OCGumbo add more Query support, add "OCGumbo+Query.h" and enjoy it.

####Query APIs####

<table>
<tr><th width="100">Method</th><th>Description</th></tr>
<tr><td>.Query( )</td><td>Query children elements from current node by selector</td></tr>
<tr><td>.text( )</td><td>Get the combined text contents of current object</td></tr>
<tr><td>.html( )</td><td>Get the raw contents of current element</td></tr>
<tr><td>.attr( )</td><td>Get the attribute value of the element by attributeName</td></tr>
<tr><td>.find( )</td><td>Find elements that match the selector in the current collection</td></tr>
<tr><td>.children( )</td><td>Get immediate children of each element in the current collection matching the selector</td></tr>
<tr><td>.parent( )</td><td>Get immediate parents of each element in the collection matching the selector</td></tr>
<tr><td>.parents( )</td><td>Get all ancestors of each element in the collection matching the selector</td></tr>
<tr><td>.first( )</td><td>Get the first element of the current collection</td></tr>
<tr><td>.last( )</td><td>Get the last element of the current collection</td></tr>
<tr><td>.get ( )</td><td>Get the element by index from current collection</td></tr>
<tr><td>.index( )</td><td>Get the position of an element in current collection</td></tr>
<tr><td>.hasClass( )</td><td>Check if any elements in the collection have the specified class</td></tr>
</table>

####Examples####

```objective-c
NSLog(@"options: %@", document.Query(@"body").find(@"#select").find(@"option"));
NSLog(@"title: %@", document.Query(@"title").text());
NSLog(@"attribute: %@", document.Query(@"select").first().attr(@"id"));
NSLog(@"class: %@", document.Query(@"#select").parents(@".main"));
NSLog(@"tag.class: %@", document.Query(@"div.theCls"));
NSLog(@"tag#id : %@", document.Query(@"div#theId"));
```

