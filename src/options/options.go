package options

type Options struct {
	Port int;
	ConversionFormat string;
	ConversionOptions map[string]string;

	UseCaching bool;
	CacheDuration int;

	UsePreloading bool;
	ItemsToPreload []string;
}

func newOptions() *Options {
	opt := Options{};
	opt.Port = 49696;
	opt.ConversionFormat = "png";
	opt.ConversionOptions = make(map[string]string);

	opt.UseCaching = true;
	opt.CacheDuration = 10;

	opt.UsePreloading = false;
	opt.ItemsToPreload = []string{};

	return &opt;
}