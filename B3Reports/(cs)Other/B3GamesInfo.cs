using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameTech.B3Reports._cs_Other
{
    public class B3GamesInfo
    {
        public int Id { get; set; }
        public GameIconNameEnum GameIconName { get; set; }
        public string DisplayName { get; set; }
    }

    public enum GameIconNameEnum
    {
        CRAZYBOUT,
        JAILBREAK,
        MAYAMONEY,
        SPIRIT76,
        WILDBALL,
        TIMEBOMB,
    }
}
