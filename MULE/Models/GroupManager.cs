using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MULE.Models
{
    public class GroupManager
    {

        public void AddGroup(group g, string email)
        {

            UserManager UM = new UserManager();

            int id = UM.getUserId(email);

            using (muleEntities db = new muleEntities())
            {

                group ng = new group();
                ng.user_owner_id = id;
                ng.group_name = g.group_name;
                ng.description = g.description;
                ng.private_flag = 0;

                db.groups.Add(ng);
                db.SaveChanges();

                user_group ug = new user_group();
                ug.group_id = getGroupId(g.group_name);
                ug.user_id = id;
                ug.is_approved = 1;

                db.user_group.Add(ug);
                db.SaveChanges();
            }
        }

        public bool doesGroupExist(string name)
        {
            using (muleEntities db = new muleEntities())
            {
                return db.groups.Where(o => o.group_name.Equals(name)).Any();
            }
        }

        public int getGroupId(string name)
        {
            using (muleEntities db = new muleEntities())
            {
                var group = db.groups.Where(o => o.group_name.ToLower().Equals(name));
                if (group.Any())
                    return group.FirstOrDefault().group_id;
                else
                    return -1;
            }
        }


    }
}