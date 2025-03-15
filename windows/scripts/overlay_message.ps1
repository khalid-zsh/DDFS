Add-Type -TypeDefinition @"
using System;
using System.Windows.Forms;
public class Overlay {
    public static void Show() {
        MessageBox.Show("Data Extraction Process is On...", "DDFS", MessageBoxButtons.OK, MessageBoxIcon.Information);
    }
}
"@ -Language CSharp

[Overlay]::Show()
