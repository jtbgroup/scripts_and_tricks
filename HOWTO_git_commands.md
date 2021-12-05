# HOW TO used to reference most popular git commands

## Register credentials and Github PAT

For Linux, you need to configure the local GIT client with a username and email address,

```
$ git config --global user.name "your_github_username"
$ git config --global user.email "your_github_email"
$ git config -l
```

Once GIT is configured, we can begin using it to access GitHub. Example:

```
$ git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
    > Cloning into `Spoon-Knife`...
$ Username for 'https://github.com' : username
$ Password for 'https://github.com' : give your personal access token here
```

Now cache the given record in your computer to remembers the token:

```
$ git config --global credential.helper cache
```

## Delete global credentials

If needed, anytime you can delete the cache record by:

``` shell
$ git config --global --unset credential.helper
$ git config --system --unset credential.helper
```

## Reset a branch to remote

If name of the branch is master:

``` shell
git reset --hard origin/master
```

For a full clean

``` shell
git reset --hard HEAD
git clean -f -x -d -n
```

then

``` shell
git clean -f -x -d
```

## Create a tag and push it

Creates the local tag, then the remote one

``` shell
git tag 3.2.1
git push --set-upstream origin 3.2.1
```

## Delete a tag

Deletes the local tag, then the remote one

``` shell
git tag -d 3.2.0 
git push --delete origin 3.2.0

```