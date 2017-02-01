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
        // POST: /Account/Login
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(user model)
        {
            if (ModelState.IsValid)
            {
                UserManager UM = new UserManager();
                String password = UM.getUserPassword(model.email);
                if(password.Equals(UserManager.sha256_hash(model.password)))
                {
                    FormsAuthentication.SetAuthCookie(model.email, false);
                    return RedirectToAction("FrontPage", "Account");
                }
                else
                    ModelState.AddModelError("", "Invalid credentials.");
            }
            // somthing went wrong so return to page if there is an error
            return View(model);
        }

        //
        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
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
                    FormsAuthentication.SetAuthCookie(model.email, false);
                    return RedirectToAction("FrontPage", "Account");
                }
                else
                    ModelState.AddModelError("", "Email is already in use.");
            }
            // somthing went wrong so return to page if there is an error
            return View(model);
        }

        //
        // GET: /Account/FrontPage
        [Authorize]
        public ActionResult FrontPage()
        {
            return View();
        }


        //
        // GET: /Account/Groups
        [Authorize]
        public ActionResult Groups()
        {
            return View();
        }

        //
        // GET: /Account/CreateGroup
        [Authorize]
        public ActionResult CreateGroup()
        {
            return View();
        }

        //
        // POST: /Account/CreateGroup
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateGroup(group model)
        {
            if (ModelState.IsValid)
            {
                return RedirectToAction("Groups", "Account");
            }
            // somthing went wrong so return to page if there is an error
            return View(model);
        }

        //
        // GET: /Account/Search
        [Authorize]
        public ActionResult Search()
        {
            return View();
        }

        //
        // POST: /Account/Search
        [HttpPost]
        public ActionResult Search(group model)
        {
            if (ModelState.IsValid)
            {
                
            }
            // somthing went wrong so return to page if there is an error
            return View(model);
        }
    }
}