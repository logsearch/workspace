# Editing Files in the Workspace

There are several ways to edit files inside the Workspace.

0.  Inside the workspace shell
    
    Command line text editors `vi` and `nano` are installed, and can be used to edit any of the files in your workspace.  Eg:

        vi ~/environments/local/test/logsearch/manifest.yml

0.  Using your local text editor [Vagrant + Mac only] 

    When using Vagrant on a Mac, the `~/environments` and `~/src` folders are shared to the host filesystem under `logsearch-workspace/workspace/` via a NFS shared.  You can edit these using your favourite text editor.

0.  Via your web browser using the Cloud9 IDE

    Inside your workspace shell, run `cloud9` to download & launch the Cloud9 IDE editor (downloads ~100Mb on first run).
    Look for the:

        =================================================
        Launching Cloud9 IDE at http://192.168.50.4:10000
        =================================================

    line, and open the URL provided in a (non IE) browser.