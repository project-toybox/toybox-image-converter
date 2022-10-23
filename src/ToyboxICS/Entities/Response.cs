using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyboxICS.Entities
{
    internal class Response
    {
        internal int StatusCode { get; set; } = 200;

        internal string Message { get; set; } = string.Empty;
    }
}
