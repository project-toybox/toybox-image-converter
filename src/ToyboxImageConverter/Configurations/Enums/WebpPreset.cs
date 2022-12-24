using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyboxImageConverter.Configurations.Enums
{
    /// <summary>
    /// Tune lossy encoder settings for different image types.
    /// </summary>
    public enum WebpPreset
    {
        /// <summary>Default preset.</summary>
        Default = 0, // "default"

        /// <summary>Digital picture, like portrait, inner shot.</summary>
        Picture = 1, // "picture"

        /// <summary>Outdoor photograph, with natural lighting.</summary>
        Photo = 2, // "photo"

        /// <summary>Hand or line drawing, with high-contrast details.</summary>
        Drawing = 3, // "drawing"

        /// <summary>Small-sized colorful images/</summary>
        Icon = 4, // "icon"

        /// <summary>Text-like.</summary>
        Text = 5 // "text"
    }
}
