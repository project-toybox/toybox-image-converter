using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyboxImageConverter.Configurations.Enums
{
    /// <summary>
    /// The PNG filter to use.
    /// </summary>
    [Flags]
    public enum PngFilter
    {
        /// <summary>No filtering.</summary>
        None = 0x08, // "none"

        /// <summary>Difference to the left.</summary>
        Sub = 0x10, // "sub"

        /// <summary>Difference up.</summary>
        Up = 0x20, // "up"

        /// <summary>Average of left and up.</summary>
        Avg = 0x40, // "avg"

        /// <summary>Pick best neighbor predictor automatically.</summary>
        Paeth = 0x80, // "paeth"

        /// <summary>Adaptive.</summary>
        All = None | Sub | Up | Avg | Paeth // "all"
    }
}
