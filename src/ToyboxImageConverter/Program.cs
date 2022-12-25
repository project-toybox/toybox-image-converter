using Serilog;
using Serilog.Events;
using ToyboxImageConverter.Utilities;

namespace ToyboxImageConverter
{
    public class Program
    {
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

        }
    }
}