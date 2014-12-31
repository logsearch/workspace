---
title: "Develop the LogSearch Website (www.logsearch.io)"
---

0. Connect to your LogSearch Workspace shell
0. Ensure you have setup the public src projects using `~/bin/setup_public_src_projects`
0. Build:

        cd ~/src/logsearch-website
        grunt

0. View the site in your browser:

        cd ~/src/logsearch-website
        grunt server

   Look for the lines similar to:

        Running "connect:server" (connect) task
        Started connect web server on http://0.0.0.0:8000

    And open the url provided in your browser (replacing `0.0.0.0` with your workspaces' IP (probably `192.168.50.4`))

0. Edit the files under `~/src/logsearch-website/templates` & refresh your browser to see the changes
0. Commit!