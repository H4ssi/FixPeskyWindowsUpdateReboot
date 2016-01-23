using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace pwu
{
    class Program
    {
        static void Main(string[] args)
        {
            HiddenForm f = new HiddenForm();
            f.onStart += () =>
            {
                SystemEvents.PowerModeChanged += SystemEvents_PowerModeChanged;
            };
            f.onExit += () =>
            {
                SystemEvents.PowerModeChanged -= SystemEvents_PowerModeChanged;
                disableRebootWakeTimer();
            };
            Application.Run(f);
        }

        private static void SystemEvents_PowerModeChanged(object sender, PowerModeChangedEventArgs e)
        {
            if (e.Mode != PowerModes.Suspend)
            {
                return;
            }

            disableRebootWakeTimer();
        }

        private static void disableRebootWakeTimer()
        {
            TaskScheduler.TaskScheduler t = new TaskScheduler.TaskScheduler();
            t.Connect();

            t.GetFolder("\\Microsoft\\Windows\\UpdateOrchestrator").GetTask("Reboot").Enabled = false;
        }
    }
}
