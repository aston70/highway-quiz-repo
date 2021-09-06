using NLog;
using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;

namespace HighwayQuiz.BL
{

    public class UtilityBL
    {
        // NLog Logger object
        private static ILogger _log;

        public static string AppPath { get; } = System.AppDomain.CurrentDomain.BaseDirectory;

        public static string BasePath { get; } = System.IO.Path.GetDirectoryName(
            System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase);

        public UtilityBL(ILogger logService)
        {
            _log = logService;
        }

        public void CheckDirectory(string dir)
        {
            if (!Directory.Exists(dir))
            {
                Directory.CreateDirectory(dir);
                //log.LogMsg("Directory did not exist, but was created successfully: {0}", dir);
            }
        }

        public void CheckDirectories(List<string> directories)
        {
            foreach (var directory in directories)
                CheckDirectory(directory);
        }

        public string AppVersion()
        {
            Assembly execAssembly = Assembly.GetCallingAssembly();
            AssemblyName name = execAssembly.GetName();
            return string.Format("{0}{1} {2:0}.{3:0} for .Net ({4}){0}", Environment.NewLine, name.Name, name.Version.Major.ToString(), name.Version.Minor.ToString(), execAssembly.ImageRuntimeVersion);
        }
    }

}
