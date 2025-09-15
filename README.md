Perfect! ✅

Now you are on the muhsina branch. Any changes you make and commits you create will only affect this branch, leaving master and submaster untouched.

Next Steps You Can Do

Check status of files:

git status


Shows which files are modified, staged, or untracked.

Add changes to staging:

git add .


Adds all modified files to be committed.

Commit changes:

git commit -m "Your commit message here"


Example:

git commit -m "Added task tracking feature"


Push branch to remote (GitHub/GitLab):

git push -u origin muhsina


The -u sets the upstream so next time you can just use git push.

Merge back to master (when work is done):

git switch master
git merge muhsina