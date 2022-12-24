using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyboxImageConverter.Configurations.Enums
{
    /// <summary>
    /// Set JPEG/HEIF subsampling mode.
    /// </summary>
    public enum SubsamplingMode
    {
        /// <summary>Prevent subsampling when quality > 90.</summary>
        Auto = 0, // "auto"

        /// <summary>Always perform subsampling.</summary>
        On = 1, // "on"

        /// <summary>Never perform subsampling.</summary>
        Off = 2 // "off"
    }
}
