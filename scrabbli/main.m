//
//  main.m
//  scrabbli
//
//  Created by Kristen Mills on 11/12/12.
//  Copyright (c) 2012 Kristen Mills. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
	return macruby_main("rb_main.rb", argc, argv);
}
