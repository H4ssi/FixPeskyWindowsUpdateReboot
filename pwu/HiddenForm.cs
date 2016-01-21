using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pwu
{
    public partial class HiddenForm : Form
    {
        public event Action onStart;
        public event Action onExit;

        public HiddenForm()
        {
            InitializeComponent();
        }

        private void HiddenForm_Load(object sender, EventArgs e)
        {
            if (onStart != null)
            {
                onStart();
            }
        }

        private void HiddenForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (onExit != null)
            {
                onExit();
            }
        }
    }
}
