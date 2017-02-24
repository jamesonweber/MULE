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
        // GET: /Account/FrontPage
        [Authorize]
        public ActionResult Group(int g_id)
        {
            GroupManager GM = new GroupManager();
            group g = GM.getGroup(g_id);
            if (g != null)
            {
                return View(g);
            }
            return View();
        }

        //
        // POST: /Account/FrontPage
        [HttpPost]
        [Authorize]
        public ActionResult Group(group model, string groupBut)
        {
            GroupManager GM = new GroupManager();


            if (groupBut.Equals("Join Group"))
            {
                GM.AddMember(model, User.Identity.Name);
                return View(model);
            }   
            else if (groupBut.Equals("Leave Group"))
            {
                GM.RemoveMember(model, User.Identity.Name);
                return RedirectToAction("Groups", "Account");
            }
            return View(model);
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

                GroupManager GM = new GroupManager();
                if (!GM.doesGroupExist(model.group_name))
                {
                    GM.AddGroup(model, User.Identity.Name);
                    return RedirectToAction("Groups", "Account");
                }
                else
                    ModelState.AddModelError("", "Group name is already in use.");
                
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
        public ActionResult Search(group g)
        {
            if (ModelState.IsValid)
            {
                ViewBag.searchedGroupName = g.group_name;
                return View(g);
            }
            // somthing went wrong so return to page if there is an error
            return View(g);
        }
    }
}