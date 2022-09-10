package fs

import (
	"os"
	"path/filepath"
	"golang.org/x/exp/slices"
	"strings"
)

func ScanFiles(dirname string, extensions []string) ([]string, error) {
	var resultFiles = []string{};
	var resultError error = nil;

	// Scan all files recursively.
	err := filepath.Walk(dirname, func(path string, file os.FileInfo, err error) error {
		if err != nil {
			return err;
		}

		// Check the item is a file or a directory.
		if (!file.IsDir()) {
			// Check an extension.
		    currentFileExtension := strings.ToLower(filepath.Ext(path));
		
		    if (extensions == nil || len(extensions) == 0) {
			    resultFiles = append(resultFiles, path);
		    } else if (slices.IndexFunc(extensions, func (extension string) bool {return (strings.ToLower(extension) == currentFileExtension)}) != -1) {
			    resultFiles = append(resultFiles, path);
		    }
		}

		return nil;
    })

    if err != nil {
        resultError = err;
    }

	return resultFiles, resultError;
}
