using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IYFD.Models;

namespace IYFD.Controllers
{
    public class UserController : Controller
    {
        private int _userId;
        private IYFD.Utility.IYFDData _data = new Utility.IYFDData();

        public void SetUserID(int userId)
        {
            Response.Cookies.Add(new HttpCookie("IYFD_ID", userId.ToString()));
        }

        public bool UserHasAccess(Content content)
        {
            if (UserID.HasValue)
            {
                if (!_data.CheckUser(UserID.Value, content))
                    Response.Redirect("~/");
                return true;
            }
            else
                Response.Redirect("~/Account/Logon");
            return false;
        }

        public void ClearUser()
        {
            HttpCookie currentUser = HttpContext.Request.Cookies["IYFD_ID"];
            HttpContext.Response.Cookies.Remove("IYFD_ID");
            currentUser.Expires = DateTime.Now.AddDays(-1);
            currentUser.Value = null;
            HttpContext.Response.Cookies.Add(currentUser);

            //HttpContext.Request.Cookies.Clear();            
        }

        #region Properties

        public int? UserID
        {
            get 
            {
                if (HttpContext.Request.Cookies.Count > 0 && int.TryParse(HttpContext.Request.Cookies["IYFD_ID"].Value, out _userId))
                    return _userId;
                else
                    return null;
            }
        }

        public const string GenericErrorMessage = "<span style='color: red;'>An error occurred.  Please contact Dan Lydon at dtlydon@gmail.com.";
        
        #endregion
    }
}
