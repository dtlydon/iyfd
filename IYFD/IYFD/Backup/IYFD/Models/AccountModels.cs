using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;
using System.Data.Entity;

namespace IYFD.Models
{
    public class User
    {
        public int? ID { get; set; }

        [Required]
        [Display(Name = "Username")]
        public string Username { get; set; }

        [Required]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Required]
        [Display(Name = "Password")]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Current password")]
        public string OldPassword { get; set; }
        
        [Required]
        [Display(Name = "Email Address")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        public bool Active { get; set; }
    }

    public class Role
    {
        public int ID { get; set; }
        public string Name { get; set; }
    }

    public enum Content
    {
        Home = 1,       //Home
        HowToPlay,      //Home
        LeaderBoard,    //Home
        Legends,        //Home
        Login,          //Account
        Register,       //Account
        Profile,        //Account - My Profile
        Score,          //Tourny - My Score
        Bracket,        //Tourny - My Bracket
        Winners,        //AdminTourny - Choose Winners
        Matchups = 11,       //AdminTourny - Create Matchups
        Teams,          //AdminTourny - Add teams
        Users,          //AdminAccount - Add users
        Play,           //Users Playing
        AdminHome,
        TournyEntry,
        Regions,
        GenTourny,
        GenMatchup,
        PickWinner,
        UserPanel = 21,
        MimicPlay,
        ActivateUser,
        ChangeUserPass,
        Role
    }
}
