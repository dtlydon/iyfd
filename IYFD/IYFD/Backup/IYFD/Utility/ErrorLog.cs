using System;
using System.IO;
using System.Web;

namespace IYFD.Utility
{
    public static class ErrorLog
    {
        public static void WriteError(string contentOfOccurence, string error)
        {
            if (true)
                return;
            if (!error.ToLower().Contains("thread was being aborted"))
            {
                string file = HttpContext.Current.Request.ApplicationPath + @"\Errors\" + contentOfOccurence +
                    ".txt";

                using (TextWriter logWriter = new StreamWriter(file, true))
                {
                    logWriter.WriteLine("An exception occurred at " + DateTime.Now + ".");
                    logWriter.WriteLine(error);
                    logWriter.WriteLine();
                    logWriter.WriteLine();
                    logWriter.Close();
                }
            }
        }
    }
}