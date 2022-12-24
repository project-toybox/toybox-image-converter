using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToyboxImageConverter.Configurations.Enums;

namespace ToyboxImageConverter.Configurations
{
    public class WebpConfiguration
    {
        public int Quality { get; set; } = 50;

        public int Effort { get; set; } = 4;

        public int ReductionEffort { get; set; } = 4;

        public bool Lossless { get; set; } = false;

        public WebpPreset Preset { get; set; } = WebpPreset.Default;

        public string Profile { get; set; } = string.Empty;

        public bool NearLossless { get; set; } = false;

        public int AlphaQuality { get; set; } = 100;

        public bool MinSize { get; set; } = false;

        public int KMin { get; set; } = int.MaxValue - 1;

        public int KMax { get; set; } = int.MaxValue;

        public bool SmartSubsample { get; set; } = false;

        public bool Mixed { get; set; } = false;
    }
}
