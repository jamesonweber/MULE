﻿using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace MULE.Models
{
    public class UserManager
    {

        public void AddUserAccount(user u)
        {

            using (muleEntities db = new muleEntities())
            {

                user nu = new user();
                nu.first_name = u.first_name;
                nu.last_name = u.last_name;
                nu.email = u.email;
                nu.password = sha256_hash(u.password);
                nu.confirm_password = "Validated";
                nu.is_premium = 1;

                db.users.Add(nu);
                db.SaveChanges();

            }
        }

        public bool doesEmailExist(string email)
        {
            using (muleEntities db = new muleEntities())
            {
                return db.users.Where(o => o.email.Equals(email)).Any();
            }
        }

        //http://stackoverflow.com/questions/16999361/obtain-sha-256-string-of-a-string
        public static String sha256_hash(String value)
        {
            StringBuilder Sb = new StringBuilder();

            using (SHA256 hash = SHA256Managed.Create())
            {
                Encoding enc = Encoding.UTF8;
                Byte[] result = hash.ComputeHash(enc.GetBytes(value));

                foreach (Byte b in result)
                    Sb.Append(b.ToString("x2"));
            }

            return Sb.ToString();
        }

    }
}