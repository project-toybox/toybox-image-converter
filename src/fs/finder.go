package fs

import (
	"os"
)

func IsFileExists(filename string) bool {
	info, err := os.Stat(filename);

	if os.IsNotExist(err) {
	   return false;
	}

	return !info.IsDir();
}

func IsDirectoryExists(dirname string) bool {
	info, err := os.Stat(dirname);

	if os.IsNotExist(err) {
	   return false;
	}

	return info.IsDir();
 }