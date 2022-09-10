package main

import (
	"fmt"
	//"ics/cache"
	//"ics/fs"
	"ics/options"
	//"ics/vips"
)

func main() {
	fmt.Println("Toybox Image Conversion Server");
	fmt.Println("Copyright (c) 2022 Project Toybox all rights reserved.");

	// Get CLI args.
	options, err := options.ParseArguments();

	if (err != nil) {
		fmt.Println(err);
		return;
	}

	fmt.Printf(options.ConversionFormat);

}
