# Study

git init <br>
Create an empty Git repository or reinitialize an existing one

git add .<br>
Adds the file to your local repository and stages it for commit. To unstage a file, use 'git reset HEAD YOUR-FILE'.

git commit -m "Comment" <br>
Commits the tracked changes and prepares them to be pushed to a remote repository.

git checkout (branch) <br>
Switch branches or restore working tree files

git push origin (branch) <br>
Update remote refs along with associated objects

Start a new Git repository for an existing code base<br>
$ cd /path/to/my/codebase<br>
$ git init      (1)<br>
$ git add .     (2)<br>
$ git commit    (3)<br>

(1) Create a /path/to/my/codebase/.git directory.<br>
(2) Add all existing files to the index.<br>
(3) Record the pristine state as the first commit in the history.<br>
