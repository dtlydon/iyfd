using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IYFD.Models;
using IYFD.Utility;
using System.IO;

namespace IYFD.Controllers
{
    public class AdminController : UserController
    {
        IYFDData _data = new IYFDData();

        public ActionResult Index()
        {
            UserHasAccess(Models.Content.AdminHome);
            return View();
        }

        public ActionResult MatchUps(string id)
        {
            try
            {
                UserHasAccess(Models.Content.Matchups);

                ViewBag.Rounds = _data.GetAllRounds();
                if (string.IsNullOrEmpty(id))
                    return View(new List<MatchUp>());
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin MatchUps", ex.Message);
            }

            return View(_data.GetAllMatchups(id));
        }

        public ActionResult TournyEntry()
        {
            UserHasAccess(Models.Content.TournyEntry);
            List<Team> teams = _data.GetCurrentTeams();
            List<Region> regions = _data.GetAllRegions();
            List<Rank> ranks = _data.GetAllRanks();
            List<Tourny> entries = _data.GetAllTournies();

            ViewBag.Teams = teams;
            ViewBag.Regions = regions;
            ViewBag.Ranks = ranks;
            ViewBag.Tournies = entries;

            return View();
        }

        [HttpPost]
        public ActionResult TournyEntry(string teams, string regions, string rounds, string ranks)
        {
            try
            {
                UserHasAccess(Models.Content.TournyEntry);
                Tourny tournyEntry = new Tourny
                {
                    Team = new Team
                    {
                        ID = Convert.ToInt32(teams)
                    },
                    Region = new Region
                    {
                        ID = Convert.ToInt32(regions)
                    },
                    Rank = Convert.ToInt32(ranks)
                };

                _data.CreateTourny(tournyEntry);

                List<Team> teamList = _data.GetCurrentTeams();
                List<Region> regionList = _data.GetAllRegions();
                List<Rank> rankList = _data.GetAllRanks();
                List<Tourny> entries = _data.GetAllTournies();

                ViewBag.Teams = teamList;
                ViewBag.Regions = regionList;
                ViewBag.Ranks = rankList;
                ViewBag.Tournies = entries;
                ViewBag.PageMessages = "<span style='color: green'>Success!</span>";
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin TournyEntry", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
            }
            return View();
        }

        public ActionResult Teams()
        {
            UserHasAccess(Models.Content.Teams);
            List<Team> teams = _data.GetCurrentTeams();
            ViewBag.Teams = teams;
            return View();
        }

        [HttpPost]
        public ActionResult Teams(string name)
        {
            try
            {
                UserHasAccess(Models.Content.Teams);
                    
                if (_data.CheckIfTeamExists(new Models.Team { Name = name }))
                {
                    ViewBag.ErrorMessage = "<span style='color: red'>Team already exists!</span>";
                }
                else
                {
                    _data.UpsertTeam(new Models.Team { Name = name });
                    ViewBag.ErrorMessage = "<span style='color: green'>Team created!</span>";
                }
                List<Team> teams = _data.GetCurrentTeams();
                ViewBag.Teams = teams;
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin Teams", ex.Message);
                ViewBag.ErrorMessage = GenericErrorMessage;
            }
            return View();
        }

        public ActionResult Regions()
        {
            try
            {
                UserHasAccess(Models.Content.Regions);
                List<Region> regions = _data.GetAllRegions();
                ViewBag.Regions = regions;
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin Regions", ex.Message);
            }
            return View();
        }

        [HttpPost]
        public ActionResult Regions(string name)
        {
            try
            {
                UserHasAccess(Models.Content.Regions);
                //if (_data.CheckIfTeamExists(new Models.Region { Name = name }))
                //{
                //    ViewBag.ErrorMessage = "<span style='color: red'>Team already exists!</span>";
                //}
                //else
                //{
                _data.UpsertRegion(new Models.Region { Name = name });
                ViewBag.ErrorMessage = "<span style='color: green'>Team created!</span>";
                List<Region> regions = _data.GetAllRegions();
                ViewBag.Regions = regions;
                //}
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin Regions", ex.Message);
                ViewBag.ErrorMessage = GenericErrorMessage;
            }
            return View();
        }

        public ActionResult GenerateTourny()
        {
            UserHasAccess(Models.Content.GenTourny);
            return View();
        }

        [HttpPost]
        public ActionResult GenerateTourny(string id)
        {
            try
            {
                UserHasAccess(Models.Content.GenTourny);
                _data.GenerateFirstRoundMatchups();
                ViewBag.PageMessages = "<span style='color: green'>Success!</span>";
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin GenTourny", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
            }
            return View();
        }

        public ActionResult GenerateMatchups()
        {
            try
            {
                UserHasAccess(Models.Content.GenMatchup);
                ViewBag.Rounds = _data.GetAllRoundsNoInMatchUp();
                GenerateRegionSelect();
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin GenMatchup", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
            }
            return View();
        }

        [HttpPost]
        public ActionResult GenerateMatchups(string roundId, string region)
        {
            int rId;
            bool success = false;
            try
            {
                UserHasAccess(Models.Content.GenMatchup);
                IEnumerable<Round> rounds = _data.GetAllRoundsNoInMatchUp();
                ViewBag.Rounds = rounds;
                GenerateRegionSelect();
                if (!_data.CheckPreviousRoundMatchups(roundId) || !int.TryParse(roundId, out rId))
                {
                    ViewBag.PageMessages = "<span style='color: red'>Not yet! Previous round is not over!</span>";
                    return View();
                }

                Round round = rounds.FirstOrDefault(x => x.ID == rId);

                switch (round.Name)
                {
                    //Championship
                    case 6:
                        success = _data.GenerateFinal(round.ID);
                        break;
                    //Final Four
                    case 5:
                        success = GenerateFinalFour(roundId, region);
                        break;
                    default:
                        success = _data.GenerateNextRoundMatchups(round);
                        break;
                }
                IEnumerable<Round> rounds2 = _data.GetAllRoundsNoInMatchUp();
                ViewBag.Rounds = rounds2;
                ViewBag.PageMessages = "<span style='color: green'>Success!</span>";
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin GenMatchUps", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
            }
            return View();
        }

        public ActionResult PickWinner(string id)
        {
            int matchupId;
            try
            {
                UserHasAccess(Models.Content.PickWinner);
                if (!int.TryParse(id, out matchupId) || matchupId <= 0)
                    return RedirectToAction("Index");
                ViewBag.Rounds = _data.GetAllRounds();
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin PickWinner", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
                matchupId = 0;
            }

            return View(_data.GetMatchupById(matchupId));
        }

        [HttpPost]
        public ActionResult PickWinner(string id, string winner)
        {
            int matchupId;
            int winnerId;
            int roundId;

            try
            {
                UserHasAccess(Models.Content.PickWinner);
                if (!int.TryParse(id, out matchupId) || matchupId <= 0 ||
                    !int.TryParse(winner, out winnerId) || winnerId <= 0)
                    return RedirectToAction("Index");

                roundId = _data.ChooseWinners(matchupId, winnerId);
                ViewBag.PageMessages = "<span style='color: green'>Success!</span>";
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin PickWinner", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
                roundId = 2;
            }
            return RedirectToAction("MatchUps", new { id = roundId });
        }

        public ActionResult UserPanel()
        {
            try
            {
                UserHasAccess(Models.Content.UserPanel);
                List<Round> rounds = _data.GetAllRounds();
                ViewBag.Round = rounds.Single(x => x.Name == 1).ID;
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin UserPanel", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
            }
            return View(_data.GetAllUsers());
        }

        public ActionResult MimicPlay(string id, string round)
        {
            int mimicUserId;
            int roundId;
            try
            {
                UserHasAccess(Models.Content.MimicPlay);
                if (!int.TryParse(id, out mimicUserId))
                    return RedirectToAction("Index", "Home");
                if (!int.TryParse(round, out roundId))
                    return RedirectToAction("Index", "Home");

                ViewBag.MimicUserID = id;
                ViewBag.Rounds = _data.GetAllRounds();
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin GenTourny", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
                roundId = mimicUserId = 0;

            }

            return View(_data.GetMatchupsForUserByRound(roundId, mimicUserId));
        }

        [HttpPost]
        public ActionResult MimicPlay(string id, string round, List<string> teams)
        {
            int roundId;
            int choiceId;
            int mimicUserId;
            try
            {
                UserHasAccess(Models.Content.MimicPlay);

                List<int> choiceIds = new List<int>();

                ViewBag.MimicUserID = id;
                ViewBag.Rounds = _data.GetAllRounds();

                if (!int.TryParse(round, out roundId))
                    roundId = _data.GetAllRounds().FirstOrDefault(x => x.Name == 1).ID;
                if (!int.TryParse(id, out mimicUserId))
                    return View();

                foreach (string choice in teams)
                {
                    if (int.TryParse(choice, out choiceId))
                        choiceIds.Add(choiceId);
                }
                ViewBag.Rounds = _data.GetAllRounds();
                _data.SetUserChoices(choiceIds, roundId, mimicUserId);

                ViewBag.PageMessages = "<span style='color: green'>Success!</span>";
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin GenTourny", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
                roundId = mimicUserId = 0;

            }
            return View(_data.GetMatchupsForUserByRound(roundId, mimicUserId));
        }

        public ActionResult Activate(string id)
        {
            UserHasAccess(Models.Content.ActivateUser);
            int userId;
            if (int.TryParse(id, out userId) && _data.ActivateUser(userId))
                return RedirectToAction("UserPanel");
            else
                return RedirectToAction("Index");
        }

        public ActionResult ChangeUserPass(string id)
        {
            UserHasAccess(Models.Content.ChangeUserPass);
            return View();
        }

        [HttpPost]
        public ActionResult ChangeUserPass(string id, string password)
        {
            try
            {
                UserHasAccess(Models.Content.ChangeUserPass);
                int userId;
                string s = string.Empty;
                if (int.TryParse(id, out userId) && _data.OverriedUserPassword(userId, password))
                    s = "Success";

                ViewBag.PageMessages = "<span style='color: green'>Success!</span>";
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Admin ChangePass", ex.Message);
                ViewBag.PageMessages = GenericErrorMessage;
            }
            return View();
        }

        public ActionResult Roles(string id)
        {
            UserHasAccess(Models.Content.Role);
            return View();
        }

        [HttpPost]
        public ActionResult Roles(string id, string roleName, List<string> contentIds)
        {
            UserHasAccess(Models.Content.Role);
            return View();
        }

        public ActionResult GamePlayTimes()
        {
            return View(_data.GetGamePlayTimes());
        }

        [HttpPost]
        public ActionResult GamePlayTimes(string startDate, string startTime, string endDate, string endTime)
        {
            DateTime start = new DateTime();
            DateTime end = new DateTime();
            DateTime startD = new DateTime();
            DateTime endD = new DateTime();
            TimeSpan startT = new TimeSpan();
            TimeSpan endT = new TimeSpan();

            if (DateTime.TryParse(startDate, out startD) && DateTime.TryParse(endDate, out endD))
            {
                startT = Convert.ToDateTime(startTime).TimeOfDay;
                endT = Convert.ToDateTime(endTime).TimeOfDay;
                start = startD + startT;
                end = endD + endT;
                _data.SetPlayTimes(start, end);
            }

            return View(_data.GetGamePlayTimes());
        }

        public ActionResult AudioUpload()
        {
            ViewBag.UploadMessage = "Please upload your file!";
            return View();
        }

        [HttpPost]
        public ActionResult AudioUpload(HttpPostedFileBase file)
        {
            if (file != null && file.ContentLength > 0 && file.FileName.ToLower().EndsWith(".m4a"))
            {
                var fileName = Path.GetFileName(file.FileName);
                var path = Server.MapPath("~/Audio/ID10T.m4a");
                file.SaveAs(path);
                ViewBag.UploadMessage = "Success!";
            }
            else
                ViewBag.UploadMessage = "File invalid, please upload a m4a with content";

            return View();
        }

        [ChildActionOnly]
        public ActionResult MinicPlayMenu()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult MatchUpMenu()
        {
            return View();
        }

        private bool GenerateFinalFour(string roundId, string region)
        {
            int round;
            int region1;
            int region2;

            string[] regions = region.Split(',');

            if (!int.TryParse(roundId, out round))
                return false;

            if (regions.Count() != 2)
                return false;

            if (!int.TryParse(regions[0], out region1))
                return false;

            if (!int.TryParse(regions[1], out region2))
                return false;

            return _data.GenerateFinalFour(round, region1, region2);
        }

        private void GenerateRegionSelect()
        {
            string display = "";
            int value = 0;
            int i = 0;
            List<KeyValuePair<string, string>> regionSelect = new List<KeyValuePair<string, string>>();
            foreach (var region in _data.GetAllRegions())
            {
                if (i > 0)
                {
                    regionSelect.Add(
                        new KeyValuePair<string, string>(
                            value.ToString() + "," + region.ID.ToString(), display + " vs " + region.Name
                    ));
                }
                else
                {
                    display = region.Name;
                    value = region.ID;
                }
                i++;
            }

            ViewBag.RegionSelect = regionSelect;
        }
    }
}
