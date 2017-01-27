using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using MULE.Models;
using Microsoft.AspNet.Identity.Owin;
using System.Web.Security;

namespace MULE.Controllers
{
    public class AccountController : Controller
    {

        // GET: Account
        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(user model)
        {
            if (ModelState.IsValid)
            {
                UserManager UM = new UserManager();
                if (!UM.doesEmailExist(model.email))
                {
                    UM.AddUserAccount(model);
                    FormsAuthentication.SetAuthCookie(model.first_name, false);
                    return RedirectToAction("Index", "Home");

                }
                else
                    ModelState.AddModelError("", "Email is already in use.");
            }
            // somthing went wrong so return to page if there is an error
            return View(model);
        }
    }
}