package options

import (
	"errors"
	"fmt"
	"github.com/jessevdk/go-flags"
	"ics/fs"
	"os"
	"strings"
)

var cliArguments struct {
	Port int `required:"true" short:"p" long:"port" description:"Set a port which is used by ICS(0~65535)." default:"49696"`;
	ConversionFormat string `required:"true" short:"f" long:"conversion-format" description:"Set the conversion format."`;
	ConversionOptions string `short:"o" long:"conversion-options" descriptions:"Set conversion options(KEY=VALUE). Each item is separated by '|(Vertical Bar)' letter."`;
	
	UseCaching bool `long:"use-caching" description:"Set whether or not to use cache." default:"true"`;
	CacheDuration int `long:"cache-duration" description:"Sets the cache duration(unit: min, 1~60)." default:"10"`;
	
	UsePreloading bool `long:"use-cache" description:"Set whether or not to use cache." default:"false"`;
	ItemsToPreload string `long:"items-to-preload" description:"Set paths(absoulte path) to be preloaded. Each item is separated by '|(Vertical Bar)' letter."`;
}

func ParseArguments() (*options, error) {
	var resultOptions *options = newOptions();
	var resultError error = nil;

	// Parse CLI Arguments
	args := os.Args;
	args, err := flags.ParseArgs(&cliArguments, args);

	if err != nil {
		panic(err);
	}

	// CHECK: Port

	if (cliArguments.Port >= 0 && cliArguments.Port <= 65535) {
		resultOptions.Port = cliArguments.Port;
	} else {
		resultError = errors.New("The port number is out of range.");
	}

	// CHECK: Conversion Format
	conversionFormat := strings.ToLower(cliArguments.ConversionFormat);

	if (conversionFormat == "avif" || conversionFormat == "jpeg" || conversionFormat == "png" || conversionFormat == "web") {
		resultOptions.ConversionFormat = cliArguments.ConversionFormat;
	} else {
		resultError = errors.New("The conversion format is not available.");
	}

	// CHECK and PARSE: Conversion Options
	optionChunks := strings.Split(cliArguments.ConversionOptions, "|");

	for _, optionChunk := range optionChunks {
		optionKeyValuePair := strings.Split(optionChunk, "="); // [0]: Key, [1]: Value

		// Check equal sign.
		if (len(optionKeyValuePair) != 2) {
			resultError = errors.New("A Key-Value pair must have only one equal sign.");
		}

		// Check the key already exists.
		_, exists := resultOptions.ConversionOptions[optionKeyValuePair[0]];
		
		if !exists {
			resultError = errors.New("The same option has been set more than once.");
		}

		resultOptions.ConversionOptions[optionKeyValuePair[0]] = optionKeyValuePair[1];
	}

	// CHECK: Use Caching
	resultOptions.UseCaching = cliArguments.UseCaching;

	// CHECK: Cache Duration
	if (cliArguments.UseCaching && cliArguments.CacheDuration >= 1 && cliArguments.CacheDuration <= 60) {
		resultOptions.CacheDuration = cliArguments.CacheDuration;
	}

	// CHECK: Use Preloading
	resultOptions.UsePreloading = cliArguments.UsePreloading;
	
	// CHECK and PARSE: Items to Preload
	if (cliArguments.UsePreloading) {
		itemsToPreload := strings.Split(cliArguments.ConversionOptions, "|");

		for _, item := range itemsToPreload {
			if (fs.IsFileExists(item) || fs.IsDirectoryExists(item)) {
				resultOptions.ItemsToPreload = append(resultOptions.ItemsToPreload, item);
			} else {
				resultError = errors.New(fmt.Sprintf("An item to preload does not exist(%s).", item));
			}
		}
	}

	return resultOptions, resultError;
}