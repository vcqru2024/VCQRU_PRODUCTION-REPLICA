using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

/// <summary>
/// Summary description for cls_Validation
/// </summary>
public class cls_Validation
{
    public  bool IsValidUserName(string username)
    {
        string pattern = "^[A-Za-z\\s]+$";
        return Regex.IsMatch(username, pattern);
    }
    public  bool IsEmailValid(string emailAddress)
    {
        string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
        Regex regex = new Regex(pattern);
        Match match = regex.Match(emailAddress);
        return match.Success;
    }
    public  bool IsMobileNumberValid(string mobileNumber)
    {
        string pattern = @"^[5-9][0-9]{9}$";
        Regex regex = new Regex(pattern);
        Match match = regex.Match(mobileNumber);
        return match.Success;
    }
    public  bool IsValidAge(string dobString, int requiredAge, out string validationMessage)
    {
        DateTime dob;
        if (DateTime.TryParse(dobString, out dob))
        {

            DateTime today = DateTime.Today;
            int age = today.Year - dob.Year;
            if (dob > today.AddYears(-age)) age--;
            if (age >= requiredAge)
            {
                validationMessage = "Valid age.";
                return true;
            }
            else
            {
                validationMessage = "You must be at least 18 years old.";
                return false;
            }
        }
        else
        {
            validationMessage = "Invalid date format. Please enter a valid date of birth.";
            return false;
        }
    }
    public   bool IsValidPAN(string pan)
    {
        string pattern = @"^[A-Z]{5}[0-9]{4}[A-Z]{1}$";
        return Regex.IsMatch(pan, pattern);
    }
}