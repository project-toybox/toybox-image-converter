﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace ToyboxImageConversionServer.Core.Utilities
{
    public static class PrivilegeHelper
    {
        public static bool IsAdministrator()
        {
            WindowsIdentity identity = WindowsIdentity.GetCurrent();

            if (identity != null)
            {
                WindowsPrincipal principal = new WindowsPrincipal(identity);
                return principal.IsInRole(WindowsBuiltInRole.Administrator);
            }
            return false;
        }

        public static void RunAsAdiministrator(string filePath)
        {
            ProcessStartInfo startInfo = new ProcessStartInfo();
            startInfo.UseShellExecute = true;
            startInfo.FileName = filePath;
            startInfo.WorkingDirectory = Environment.CurrentDirectory;
            startInfo.Verb = "runas";
            Process.Start(startInfo);

            Environment.Exit(0);
        }
    }
}
