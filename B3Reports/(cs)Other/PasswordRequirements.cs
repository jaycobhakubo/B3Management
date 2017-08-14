using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace GameTech.B3Reports
{
    public class PasswordPolicy
    {
        private static int Minimum_Length = GetSecuritySettings.MinPasswordLength;
        private static int Upper_Case_length = 1;
        private static int Lower_Case_length = 1;
        private static int NonAlpha_length = 1;
        private static int Numeric_length = 1;
         public   static string MessageForPasswordLengthRequirements = "";

        public static bool IsValidPComplexOff(string Password)
        {
            if (Password.Length < GetSecuritySettings.MinPasswordLength)//Y 7 after save
            {
                MessageForPasswordLengthRequirements = "The password did not meet the password length requirements.";
                return false;
            }
            else
            {
                return true;
            }
        }

        public static bool IsValid(string Password)
        {
            if (Password.Length < Minimum_Length)
            {
                MessageForPasswordLengthRequirements = "The password did not meet the password length requirements.";
                return false;
            }
            if (UpperCaseCount(Password) < Upper_Case_length)
            {
                MessageForPasswordLengthRequirements = "The password did not meet the password complexity requirements.";
                return false;
            }
            if (LowerCaseCount(Password) < Lower_Case_length)
            {
                MessageForPasswordLengthRequirements = "The password did not meet the password complexity requirements.";
                return false;
            }
            if (NumericCount(Password) < Numeric_length && NonAlphaCount(Password) < NonAlpha_length)
            {
                MessageForPasswordLengthRequirements = "The password did not meet the password complexity requirements.";
                return false;
            }
            //if (NonAlphaCount(Password) < NonAlpha_length)
            //   return false;
            return true;
        }

        private static int UpperCaseCount(string Password)
        {
            return Regex.Matches(Password, "[A-Z]").Count;
        }

        private static int LowerCaseCount(string Password)
        {
            return Regex.Matches(Password, "[a-z]").Count;
        }
        private static int NumericCount(string Password)
        {
            return Regex.Matches(Password, "[0-9]").Count;
        }
        private static int NonAlphaCount(string Password)
        {
            //return Regex.Matches(Password, @"[^0-9a-zA-Z\._]").Count;
            return Regex.Matches(Password, @"[^0-9a-zA-Z]").Count;
        }
    }
}
