using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data.SqlTypes;



namespace GameTech.B3Reports
{

    public class User
    {
        public int id;
        public string username;
        //public char[] Active;//EnableUser
        public string isActive;
    }

    public class userList
    {
        public static List<User> Userlist = new List<User>();
    }

    /// <summary>
    /// Hold value for username and id
    /// </summary>
    public class CurrentUserLoggedIn
    {
        public static int id;
        public static string username;
    }

   public  class GetCurrentUser
    {
       SqlConnection sc = GetSQLConnection.get();

       public List<User> GetCurrentUserActive()
       {
           userList.Userlist.Clear();

           try
           {
               sc.Open();
               using (SqlCommand cmd = new SqlCommand(@"select LogInID, UserName, EnableUser from [dbo].[B3_Login] where enableuser = 'T' order by username asc", sc))
               {
                   SqlDataReader reader = cmd.ExecuteReader();
                   while(reader.Read())
                   {
                       User usersingledata = new User();
                       usersingledata.id = reader.GetInt32(0);
                       usersingledata.username = reader.GetString(1);
                       usersingledata.isActive = reader.GetString(2);
                       userList.Userlist.Add(usersingledata);


                   }
               }
               sc.Close();

              // return userList.Userlist;
           }
           catch (Exception ex)
           {
               MessageBox.Show(ex.Message);
           }

           return userList.Userlist;
       }


       public List<User> GetCurrentUserInActive()
       {
           userList.Userlist.Clear();

           try
           {
               sc.Open();
               using (SqlCommand cmd = new SqlCommand(@"select LogInID, UserName, EnableUser from [dbo].[B3_Login] where enableuser <> 'T' order by username asc", sc))
               {
                   SqlDataReader reader = cmd.ExecuteReader();
                   while (reader.Read())
                   {
                       User usersingledata = new User();
                       usersingledata.id = reader.GetInt32(0);
                       usersingledata.username = reader.GetString(1);
                       usersingledata.isActive = reader.GetString(2);
                       userList.Userlist.Add(usersingledata);


                   }
               }
               sc.Close();

               // return userList.Userlist;
           }
           catch (Exception ex)
           {
               MessageBox.Show(ex.Message);
           }

           return userList.Userlist;
       }


       public List<User> GetCurrentUserAll()
       {
           userList.Userlist.Clear();

           try
           {
               sc.Open();
               using (SqlCommand cmd = new SqlCommand(@"select LogInID, UserName, EnableUser from [dbo].[B3_Login]  order by username asc", sc))
               {
                   SqlDataReader reader = cmd.ExecuteReader();
                   while (reader.Read())
                   {
                       User usersingledata = new User();
                       usersingledata.id = reader.GetInt32(0);
                       usersingledata.username = reader.GetString(1);
                       usersingledata.isActive = reader.GetString(2);
                       userList.Userlist.Add(usersingledata);


                   }
               }
               sc.Close();

               // return userList.Userlist;
           }
           catch (Exception ex)
           {
               MessageBox.Show(ex.Message);
           }

           return userList.Userlist;
       }

    }

}
