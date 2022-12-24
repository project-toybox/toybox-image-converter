using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Serilog;
using Serilog.Events;
using ToyboxImageConverter.Configurations;
using ToyboxImageConverter.Services;
using ToyboxImageConverter.Utilities;

namespace ToyboxImageConverter
{
    public class Program
    {
        private static IHost? _host = null; 

        public static void Main(string[] args)
        {
            InitializeLogger();
            InitializeGlobalExceptionHandler();
            InitializeHost();
        }

        private static void InitializeLogger()
        {
            string fileName = Path.Combine(VariableBuilder.GetBaseDirectory(), @"logs\.log");
            string outputTemplate = "{Timestamp:HH:mm:ss.ms} [{Level}] {Message}{NewLine}{Exception}";

            var logger = new LoggerConfiguration();
            logger.WriteTo.Async(config => config.Console(restrictedToMinimumLevel: LogEventLevel.Verbose, outputTemplate: outputTemplate));
            logger.WriteTo.Async(config => config.File(fileName, restrictedToMinimumLevel: LogEventLevel.Verbose, outputTemplate: outputTemplate, rollingInterval: RollingInterval.Day, rollOnFileSizeLimit: true, fileSizeLimitBytes: 1048576), bufferSize: 1024);
            logger.Enrich.FromLogContext();

            Log.Logger = logger.CreateLogger();

            Log.Information("The logger has been initialized.");
        }

        private static void InitializeGlobalExceptionHandler()
        {
            var handler = delegate (object sender, UnhandledExceptionEventArgs e)
            {
                Log.Fatal((Exception)e.ExceptionObject, "An unhandled exception has occurred.");
            };

            AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(handler);

            Log.Information("The global exception handler has been initialized.");
        }

        private static void InitializeHost()
        {
            // Configure and build a host
            var hostBuilder = Host.CreateDefaultBuilder();
            hostBuilder.ConfigureAppConfiguration((hostBuilderContext, configBuilder) =>
            {
                configBuilder.SetBasePath(VariableBuilder.GetBaseDirectory());
                configBuilder.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
            });
            hostBuilder.ConfigureServices((hostBuilderContext, services) =>
            {
                services.Configure<AvifConfiguration>(hostBuilderContext.Configuration.GetSection("AvifConfiguration"));
                services.Configure<HeifConfiguration>(hostBuilderContext.Configuration.GetSection("HeifConfiguration"));
                services.Configure<JxlConfiguration>(hostBuilderContext.Configuration.GetSection("JxlConfiguration"));
                services.Configure<PngConfiguration>(hostBuilderContext.Configuration.GetSection("PngConfiguration"));
                services.Configure<WebpConfiguration>(hostBuilderContext.Configuration.GetSection("WebpConfiguration"));

                services.AddHostedService<CommunicationService>();
                services.AddHostedService<ProcessingService>();
            });

            _host = hostBuilder.Build();

            // Run the host
            _host.Run();

            Log.Information("The host has been initialized.");
        }
    }
}