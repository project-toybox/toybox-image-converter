package main

import (
	"fmt"
	//"ics/cache"
	//"ics/fs"
	"ics/options"
	//"ics/vips"
)

func main() {
	var signature string = `
 _____         _               ___ ___ ___ 
|_   _|__ _  _| |__  _____ __ |_ _/ __/ __|
  | |/ _ \ || | '_ \/ _ \ \ /  | | (__\__ \
  |_|\___/\_, |_.__/\___/_\_\ |___\___|___/
	  |__/                             `;

	fmt.Println(signature);
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
