using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace pwu
{
    class Program
    {
        static void Main(string[] args)
        {
            SystemEvents.PowerModeChanged += SystemEvents_PowerModeChanged;
            Thread.Sleep(Timeout.InfiniteTimeSpan);
        }

        private static void SystemEvents_PowerModeChanged(object sender, PowerModeChangedEventArgs e)
        {
            if (e.Mode != PowerModes.Suspend)
            {
                return;
            }

            TaskScheduler.TaskScheduler t = new TaskScheduler.TaskScheduler();
            t.Connect();

            t.GetFolder("\\Microsoft\\Windows\\UpdateOrchestrator").GetTask("Reboot").Enabled = false;
        }
    }
}
