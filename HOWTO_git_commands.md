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

```
$ git config --global --unset credential.helper
$ git config --system --unset credential.helper
```

## Reset a branch to remote

If name if the branch is master:
```
git reset --hard origin/master
```

