using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToyboxImageConverter.Configurations.Enums;

namespace ToyboxImageConverter.Configurations
{
    public class PngConfiguration
    {
        public int Quality { get; set; } = 100;

        public int Effort { get; set; } = 7;

        public int Compression { get; set; } = 6;

        public int BitDepth { get; set; } = 8;

        public bool Interlace { get; set; } = false;

        public int Colours { get; set; } = 256;

        public string Profile { get; set; } = "sRGB";

        public PngFilter Filter { get; set; } = PngFilter.None;

        public bool Palette { get; set; } = false;

        public double Dither { get; set; } = 1.0;
    }
}
