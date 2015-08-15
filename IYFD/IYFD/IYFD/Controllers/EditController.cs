using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IYFD.Models;
using IYFD.Utility;

namespace IYFD.Controllers
{
    public class EditController : UserController
    {
        private Utility.IYFDData _data = new IYFDData();

        public ActionResult Teams(string id)
        {
            int teamId;
            Team team = new Team();

            try
            {
                UserHasAccess(Models.Content.Teams);
                if (int.TryParse(id, out teamId))
                {
                    team = _data.GetTeamById(teamId);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Edit Team", ex.Message);
            }
            return View(team);
        }

        [HttpPost]
        public ActionResult Teams(string id, string name)
        {
            try
            {
                UserHasAccess(Models.Content.Teams);
                int teamId;

                if (int.TryParse(id, out teamId))
                {
                    Team team = new Team
                    {
                        ID = teamId,
                        Name = name
                    };
                    _data.UpsertTeam(team);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Edit Team", ex.Message);
            }
            return RedirectToAction("Teams", "Admin");
        }
    }
}
