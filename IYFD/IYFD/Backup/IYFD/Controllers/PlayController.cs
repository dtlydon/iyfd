using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IYFD.Utility;

namespace IYFD.Controllers
{
    public class PlayController : UserController
    {
        private IYFDData _data = new IYFDData();

        public ActionResult Index(string id)
        {
            int roundId;
            try
            {
                CheckUser(Models.Content.Play);
                ViewBag.Rounds = _data.GetAllRounds();
                if (!_data.IsItTimeToPlay())
                {
                    ViewBag.PageMessages = "<span style='color: red'>Games are playing!</span>";
                    return View();
                }

                if (!int.TryParse(id, out roundId))
                    roundId = _data.GetAllRounds().FirstOrDefault(x => x.Name == 1).ID;                
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Play Index", ex.Message);
                roundId = 2;
                ViewBag.PageMessages = GenericErrorMessage;
                ViewBag.Rounds = string.Empty;
            }
            return View(_data.GetMatchupsForUserByRound(roundId, UserID.Value));
        }

        [HttpPost]
        public ActionResult Index(string id, List<string> teams)
        {
            int roundId;
            int choiceId;
            try
            {
                CheckUser(Models.Content.Play);
                if (!_data.IsItTimeToPlay())
                {
                    ViewBag.PageMessages = "<span style='color: red'>Games are playing!</span>";
                    return View();
                }
                List<int> choiceIds = new List<int>();

                if (!int.TryParse(id, out roundId))
                    roundId = _data.GetAllRounds().FirstOrDefault(x => x.Name == 1).ID;
                foreach (string choice in teams)
                {
                    if (int.TryParse(choice, out choiceId))
                        choiceIds.Add(choiceId);
                }
                ViewBag.Rounds = _data.GetAllRounds();
                _data.SetUserChoices(choiceIds, roundId, UserID.Value);

                ViewBag.PageMessages = "<span style='color: green'>Success!</span>";
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Play Index", ex.Message);
                roundId = 2;
                ViewBag.PageMessages = GenericErrorMessage;
            }
            return View(_data.GetMatchupsForUserByRound(roundId, UserID.Value));
        }

    }
}
