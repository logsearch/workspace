# Develop a LogSearch Filter

> The instructions below demonstrate how to add a new LogStash filter to the public `logsearch/logsearch-filters-cf` repository.
> You will probably want to create your own (private?) `logsearch-filters-$YOUR_CLUSTER`, and then work with it in a similar way.

0. Connect to your LogSearch Workspace shell
0. Ensure you have setup the public src projects using `~/bin/setup_public_src_projects`
0. Build and run the tests:

        cd ~/src/logsearch-filters-cf
        bin/build-and-test.sh

0. Make changes using the TDD RED-GREEN-REFACTOR workflow
  * RED: Edit the tests under `~/src/logsearch-filters-cf/test/` and then re-run `build-and-test.sh` to see it fail
  * GREEN: Edit the filter under `~/src/logsearch-filters-cf/src/` to make the test pass, and re-run `build-and-test.sh` to see it pass
  * REFACTOR: Clean up the code using `build-and-test.sh` to ensure you haven't broken anything

0. Commit!

0. @todo - link to related help