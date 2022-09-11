package main

import (
	"fmt"
	"ics/options"
	"ics/server"
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
	opt, opt_err := options.ParseArguments();

	if (opt_err != nil) {
		fmt.Println(opt_err);
		return;
	}

	// Open a server.
	serv_err := server.Open(opt);

	if (serv_err != nil) {
		fmt.Println(serv_err);
		return;
	}
}
