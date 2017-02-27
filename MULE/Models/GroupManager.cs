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

        public void RemoveMember(group g, string email)
        {
            UserManager UM = new UserManager();

            int id = UM.getUserId(email);

            using (muleEntities db = new muleEntities())
            {
                var record = db.user_group.FirstOrDefault(m => m.group_id == g.group_id
                                                                && m.user_id == id);
              
                if (record != null)
                {
                    db.user_group.Remove(record);
                    db.SaveChanges();
                }
                
            }
        }

        public void AddMember(group g, string email)
        {
            UserManager UM = new UserManager();

            int id = UM.getUserId(email);

            using (muleEntities db = new muleEntities())
            {
                user_group nug = new user_group();
                nug.group_id = g.group_id;
                nug.user_id = id;
                nug.is_approved = 0;

                db.user_group.Add(nug);
                db.SaveChanges();

            }

        }

        public void approveMember(int u_id, int g_id)
        {

            using (muleEntities db = new muleEntities())
            {
                var record = db.user_group.Where(x => x.user_id.Equals(u_id) && x.group_id.Equals(g_id)).FirstOrDefault();

                if(record != null)
                {
                    record.is_approved = 1;
                }

                db.SaveChanges();

            }
        }

        public void declineMember(int u_id, int g_id)
        {

            using (muleEntities db = new muleEntities())
            {
                var record = db.user_group.FirstOrDefault(m => m.group_id == g_id
                                                                && m.user_id == u_id);

                if (record != null)
                {
                    db.user_group.Remove(record);
                    db.SaveChanges();
                }

            }
        }

        public bool checkActive(int u_id, int g_id)
        {
            using (muleEntities db = new muleEntities())
            {
                return db.user_group.Where(o => (o.group_id.Equals(g_id) && o.user_id.Equals(u_id) && o.is_approved==1)).Any();
            }
        }

        public bool checkOwnership(int u_id, int g_id)
        {
            using (muleEntities db = new muleEntities())
            {
                return db.groups.Where(o => (o.group_id.Equals(g_id) && o.user_owner_id.Equals(u_id))).Any();
            }
        }

        public bool checkMembership(int u_id, int g_id)
        {
            using (muleEntities db = new muleEntities())
            {
                return db.user_group.Where(o => (o.group_id.Equals(g_id) && o.user_id.Equals(u_id))).Any();
            }
        }

        public group getGroup(int id)
        {
            using (muleEntities db = new muleEntities())
            {
                var group = db.groups.Where(o => o.group_id.Equals(id));
                if (group.Any())
                    return group.FirstOrDefault();
                else
                    return null;
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