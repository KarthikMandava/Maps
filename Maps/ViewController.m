//
//  ViewController.m
//  Maps
//
//  Created by User1 on 3/12/17.
//  Copyright © 2017 User1. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController ()
{
    GMSMapView *mapView ;
    GMSPolyline *polyPath;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //17.395274, 78.510135
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:17.395274
                                                            longitude:78.510135
                                                                 zoom:15];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;

    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(17.395274, 78.510135);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;
    
    
    
    GMSMarker *marker1 = [[GMSMarker alloc] init];
    marker1.position = CLLocationCoordinate2DMake(17.395714, 78.503062);
    marker1.title = @"Sydney";
    marker1.snippet = @"Australia";
    marker1.map = mapView;
    
    //17.395714, 78.503062
    
    
//    GMSMutablePath *path = [GMSMutablePath path];
//    [path addCoordinate:CLLocationCoordinate2DMake(@(17.395274).doubleValue,@(78.510135).doubleValue)];
//    [path addCoordinate:CLLocationCoordinate2DMake(@(17.397455).doubleValue,@(78.511830).doubleValue)];
    
//    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//    rectangle.strokeWidth = 2.f;
//    rectangle.map = mapView;
    //self.view=_mapView;

    
    [self drawPath];
}


-(void)drawPath{
    
    
    
    NSString *urlString = [NSString stringWithFormat:
@"https://maps.googleapis.com/maps/api/directions/json?origin=17.395274,78.510135&destination=17.395714,78.503062&sensor=true&key= AIzaSyDBG17QTyTvufECsXVlKsapcDgEdawFKik"];
    
  //  NSLog(@"URL====%@",urlString);
    
  //  NSURL *directionsURL = [NSURL URLWithString:urlString];
    
 
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
   // NSLog(@"Url: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(!connectionError){
            NSDictionary *result        = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *routes1             = [result objectForKey:@"routes"];
            if (routes1.count > 0)
            {
                NSDictionary *firstRoute    = [routes1 objectAtIndex:0];
                NSString *encodedPath       = [firstRoute[@"overview_polyline"] objectForKey:@"points"];
                
                GMSMutablePath *path = [GMSMutablePath pathFromEncodedPath:encodedPath];
                polyPath       = [GMSPolyline polylineWithPath:path];
                polyPath.strokeColor        = [UIColor redColor];
                polyPath.strokeWidth        = 2.5f;
                polyPath.map                = mapView;
            }
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
