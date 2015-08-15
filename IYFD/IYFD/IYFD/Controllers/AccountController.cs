using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using IYFD.Models;
using IYFD.Utility;

namespace IYFD.Controllers
{
    public class AccountController : UserController
    {
        IYFDData _data = new IYFDData();

        public ActionResult LogOn(string username, string password)
        {
            return View();
        }

        [HttpPost]
        public ActionResult LogOn(string username, string password, string url)
        {
            try
            {
                int? userId = _data.LoginUser(new User { Username = username, Password = password });
                if (userId.HasValue)
                {
                    SetUserID(userId.Value);
                    if (string.IsNullOrEmpty(url))
                        return RedirectToAction("Index", "Home");
                    Response.Redirect(url);
                }
                else
                {
                    ViewBag.ErrorMessage = "<span style='color:red'>Invalid username/password.</span>";
                }
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Account Log On", ex.Message);
                ViewBag.ErrorMessage = GenericErrorMessage;
            }
            return View();
        }
        
        public ActionResult LogOff()
        {
            ClearUser();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(string username, string password, string email, string firstname, string lastname)
        {
            try
            {
                ViewBag.ErrorMessage = string.Empty;

                if (_data.CheckUsername(username))
                {
                    ViewBag.ErrorMessage = "<span style='color:red;'>The username already exists!</span>";
                    return View();
                }

                int? userId = _data.UpsertUser(new User { Username = username, Password = password, Email = email, FirstName = firstname, LastName = lastname });
                if (userId.HasValue)
                {
                    SetUserID(userId.Value);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    return View();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Account Register", ex.Message);
                ViewBag.ErrorMessage = GenericErrorMessage;
            }
            return View();
        }

        public ActionResult Profile()
        {
            UserHasAccess(Models.Content.Profile);
            return View(_data.GetCurrentUser(UserID.Value));
        }

        [HttpPost]
        public ActionResult Profile(string username, string email, string password, string confirmPassword, string firstname, string lastname)
        {
            try
            {
                UserHasAccess(Models.Content.Profile);
                User user = new User();
                // TODO: validation messages username, email and password
                if (string.IsNullOrEmpty(username))
                    return View(_data.GetCurrentUser(UserID.Value));

                if (string.IsNullOrEmpty(email))
                    return View(_data.GetCurrentUser(UserID.Value));

                user.ID = UserID;
                user.Username = username;
                user.Email = email;
                user.FirstName = firstname;
                user.LastName = lastname;

                if (!string.IsNullOrEmpty(password) && password == confirmPassword)
                    user.Password = password;

                _data.UpsertUser(user);
            }
            catch (Exception ex)
            {
                ErrorLog.WriteError("Account Profile", ex.Message);
                ViewBag.ErrorMessage = GenericErrorMessage;
            }
            ViewBag.ErrorMessage = "<span style='color: green'>Success!</span>";
            return View(_data.GetCurrentUser(UserID.Value));
        }

        [ChildActionOnly]
        public ActionResult LogonHeader()
        {
            return PartialView(_data.GetCurrentUser(UserID));
        }
    }
}
