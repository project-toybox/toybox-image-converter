using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToyboxImageConverter.Configurations.Enums;

namespace ToyboxImageConverter.Configurations
{
    public class JxlConfiguration
    {
        public int Quality { get; set; } = 75;

        public int Effort { get; set; } = 7;

        public bool Lossless { get; set; } = false;

        public int Tier { get; set; } = 0;

        public double Distance { get; set; } = 1.0;
    }
}
