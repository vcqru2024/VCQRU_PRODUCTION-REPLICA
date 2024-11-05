using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for cls_Zydex
/// </summary>
public class cls_Zydex
{
    public  string Decrypt(string TextToBeDecrypted)
    {
        RijndaelManaged RijndaelCipher = new RijndaelManaged();
        string Password = "CSC";
        string DecryptedData;
        try
        {
            string dummyData = TextToBeDecrypted.Trim().Replace(" ", "+");
            if (dummyData.Length % 4 > 0)
                dummyData = dummyData.PadRight(dummyData.Length + 4 - dummyData.Length % 4, '=');
            byte[] EncryptedData = Convert.FromBase64String(dummyData);
            byte[] Salt = Encoding.ASCII.GetBytes(Password.Length.ToString());
            PasswordDeriveBytes SecretKey = new PasswordDeriveBytes(Password, Salt);
            ICryptoTransform Decryptor = RijndaelCipher.CreateDecryptor(SecretKey.GetBytes(32), SecretKey.GetBytes(16));
            MemoryStream memoryStream = new MemoryStream(EncryptedData);
            CryptoStream cryptoStream = new CryptoStream(memoryStream, Decryptor, CryptoStreamMode.Read);
            byte[] PlainText = new byte[EncryptedData.Length];
            int DecryptedCount = cryptoStream.Read(PlainText, 0, PlainText.Length);
            memoryStream.Close();
            cryptoStream.Close();
            DecryptedData = Encoding.Unicode.GetString(PlainText, 0, DecryptedCount);
        }
        catch
        {
            DecryptedData = TextToBeDecrypted;
        }
        return DecryptedData;
    }
    public  string Encrypt(string TextToBeEncrypted)
    {
        RijndaelManaged RijndaelCipher = new RijndaelManaged();
        string Password = "CSC";
        byte[] PlainText = System.Text.Encoding.Unicode.GetBytes(TextToBeEncrypted);
        byte[] Salt = Encoding.ASCII.GetBytes(Password.Length.ToString());
        PasswordDeriveBytes SecretKey = new PasswordDeriveBytes(Password, Salt);
        ICryptoTransform Encryptor = RijndaelCipher.CreateEncryptor(SecretKey.GetBytes(32), SecretKey.GetBytes(16));
        MemoryStream memoryStream = new MemoryStream();
        CryptoStream cryptoStream = new CryptoStream(memoryStream, Encryptor, CryptoStreamMode.Write);
        cryptoStream.Write(PlainText, 0, PlainText.Length);
        cryptoStream.FlushFinalBlock();
        byte[] CipherBytes = memoryStream.ToArray();
        memoryStream.Close();
        cryptoStream.Close();
        string EncryptedData = Convert.ToBase64String(CipherBytes);
        return EncryptedData;
    }
    public void ShowErrorMessage(Page page, string message)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), "Invalid", "showAlert('Error', '" + message + "', 'error');", true);
    }

    public void ShowSuccessMessage(Page page, string message)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), "Success", "showAlert('Success', '" + message + "', 'success');", true);
    }
    public void ShowSuccessMessagewithredirect(Page page, string message, string URL)
    {
        string script = "showMessagewithredirect('Success', '" + message + "', 'success', '" + URL + "');";
        ScriptManager.RegisterStartupScript(page, page.GetType(), "Success", script, true);
    }
}