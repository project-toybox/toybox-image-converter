using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToyboxImageConverter.Configurations.Enums;

namespace ToyboxImageConverter.Configurations
{
    public class HeifConfiguration
    {
        public int Quality { get; set; } = 50;

        public int Effort { get; set; } = 4;

        public int Speed { get; set; } = 5;

        public int BitDepth { get; set; } = 12;

        public bool Lossless { get; set; } = false;

        public SubsamplingMode SubsamplingMode { get; set; } = SubsamplingMode.Auto;
    }
}
