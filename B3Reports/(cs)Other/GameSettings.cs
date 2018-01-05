using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameTech.B3Reports._cs_Other
{
    public class GameSettings
    {
        public GameSettings()
        {
            MaxCards = 6;
            MaxBetLevel = 1;
            MaxPatterns = 10;
            MaxCalls = 24;
            MaxPatternsBonus = 12;
            MaxCallsBonus = 30;
            CallSpeed = 500;
            CallSpeedBonus = 500;
            AutoCall = "F";
            AutoPlay = "F";
            Denom1 = "T";
            Denom5 = "T";
            Denom10 = "T";
            Denom25 = "T";
            Denom50 = "T";
            Denom100 = "T";
            Denom200 = "T";
            Denom500 = "T";
            HideCardSerialNumber = "T";
            SingleOfferBonus = "T";
        }        
        
        public int MaxCards { get; set; }
        public int MaxBetLevel { get; set; }
        public int MaxPatterns { get; set; }
        public int MaxCalls { get; set; }
        public int MaxPatternsBonus { get; set; }
        public int MaxCallsBonus { get; set; }
        public int CallSpeed { get; set; }
        public int CallSpeedBonus { get; set; }
        public string AutoCall { get; set; }
        public string AutoPlay { get; set; }
        public string Denom1 { get; set; }
        public string Denom5 { get; set; }
        public string Denom10 { get; set; }
        public string Denom25 { get; set; }
        public string Denom50 { get; set; }
        public string Denom100 { get; set; }
        public string Denom200 { get; set; }
        public string Denom500 { get; set; }
        public string HideCardSerialNumber { get; set; }
        public string SingleOfferBonus { get; set; }

    }
}
