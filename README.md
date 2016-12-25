# Study
<img src="images/git_work_flow.jpg">

$ git init <br>
Create an empty Git repository or reinitialize an existing one<br><br>

$ git add .<br>
Adds the file to your local repository and stages it for commit. To unstage a file, use 'git reset HEAD YOUR-FILE'.<br><br>

$ git commit -m "Comment" <br>
Commits the tracked changes and prepares them to be pushed to a remote repository.<br><br>

$ git checkout (branch) <br>
Switch branches or restore working tree files<br><br>

$ git push origin (branch) <br>
Update remote refs along with associated objects<br><br>

$ git fetch (brance)<br>
Fetch ONLY. Manual merging<br><br>

$ git pull<br>
Fetch and Merge. Tracked branches<br><br>

Start a new Git repository for an existing code base<br><br>
$ cd /path/to/my/codebase<br>
$ git init      (1)<br>
$ git add .     (2)<br>
$ git commit    (3)<br><br>

(1) Create a /path/to/my/codebase/.git directory.<br>
(2) Add all existing files to the index.<br>
(3) Record the pristine state as the first commit in the history.<br><br>
