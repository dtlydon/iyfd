using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IYFD.Utility;
using IYFD.Models;

namespace IYFD.Controllers
{
    public class HomeController : UserController
    {
        IYFDData _data = new IYFDData();
        public ActionResult Index()
        {
            ViewBag.Year = DateTime.Today.Year;

            return View();
        }

        public ActionResult HowToPlay()
        {
            return View();
        }

        public ActionResult Legends()
        {
            return View();
        }

        public ActionResult LeaderBoard()
        {
            return View(_data.GetCurrentLeaders());
        }

        public ActionResult LastLeaderBoard()
        {
            return View();
        }
    }
}
