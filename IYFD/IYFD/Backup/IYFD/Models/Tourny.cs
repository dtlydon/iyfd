using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace IYFD.Models
{
    public class Team
    {
        public int ID { get; set; }
        [Required]
        [Display(Name = "Team Name")]
        public string Name { get; set; }
    }

    public class Region
    {
        public int ID { get; set; }
        public string Name { get; set; }
    }

    public class Round
    {
        public int ID { get; set; }
        public int Name { get; set; }
    }

    public class Rank
    {
        public int ID { get; set; }
        public int Name { get; set; }
    }

    public class MatchUp
    {
        public int ID { get; set; }
        public Tourny Tourny1 { get; set; }
        public Tourny Tourny2 { get; set; }
        public Tourny Winner { get; set; }
        public int roundId { get; set; }
        public int UserChoiceId { get; set; }
    }

    public class Tourny
    {
        public int Id { get; set; }
        public Team Team { get; set; }
        public Region Region { get; set; }
        public int Rank { get; set; }
        public int Round { get; set; }
    }

    public class UserChoice
    {
        public Tourny Choice { get; set; }
        public MatchUp MatchUp { get; set; }
        public User User { get; set; }
    }
}