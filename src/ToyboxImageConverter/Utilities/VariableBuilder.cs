using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyboxImageConverter.Utilities
{
    internal static class VariableBuilder
    {
        #region ::I/O::

        internal static string GetBaseDirectory()
        {
            return AppDomain.CurrentDomain.BaseDirectory;
        }

        #endregion
    }
}
