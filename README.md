# Docker R/Python Environment for ML

> Notes: takes up to 10Gb of space. Be careful with a docker pull.

Contains great pre-installs like:

* R ML: `tidymodels`, `keras`, `tensorflow` (installed), `mlr3`, `modeltime`, `fable`, `prophet`, `rstan`, `rstanarm`, and mostly any back end `parsnip` wants.
* Text mining: `tidytext`, `widyr`, `spacy`
* Blogging tools: `blogdown`, `hugodown`, `distill`
* utils: `git`, `vim`, `zsh` + `powerline10k`
* Python 3.8 and `virtualenv` (used in `reticulate`)

Built from [Rocker's](https://github.com/rocker-org/rocker-versioned2) /ml [container](https://hub.docker.com/r/rocker/ml), so it comes with R Studio.

Notes:

* [This GitHub](https://github.com/bryanwhiting/docker_r_env)
* [Docker hub bryanwhiting/r_env](https://hub.docker.com/repository/docker/bryanwhiting/r_env)
* Takes 4.5 hrs to build
* Takes up <10Gb of space on my Mac. If this is too much, remove what you don't want and build your own docker
* I have config files mounted to my local mac because I edit them and re-build
the image occasionally. I don't want those configs to be lost. You might have different configs - see the `docker run` command below.

Why did I build this?

* I'm tired of re-installing R every few months to get new packages to work
* I deleted Xcode of my mac and hit problems installing `git`. So instead of 10Gb of
Xcode I don't use, I have 10Gb of a docker container with packages I do (eh...probably won't use either)
* I like prototyping and playing around with different tools to see how they work, 
this is a useful playground
* This is my entire R environment. I don't use R on my Mac anymore. Just this
container.
* I want to share my image with others (TBD: maybe I'll blog and this will provide a reproducible environment.)
* I want to keep up with the Joneses by learning docker
 
# Usage

Pull the image using the tag:
```
docker pull bryanwhiting/r_env:<tagname>
docker pull bryanwhiting/r_env:0.1
```

Run Docker.
```
docker run \
  -e PASSWORD=mu \
  -p 8787:8787 \
  --name r_env \
  bryanwhiting/r_env
```

**How I use it:** I mount some directories that are local git folders.
I mount my dot files, which are saved in this config. If you follow my
approach, don't edit the dotfiles in the `docker_r_env/config` folder while the docker image
is running, since those dot files are mounted elsewhere in the drive. Just edit the files on your local (I use VS Code) or where they live within the running container.

```
# CONFIGS 
# add :Z so ~/home/rstudio/.config/R can be accessed https://stackoverflow.com/a/54787364 
# root password: rstudio https://www.rocker-project.org/use/managing_users/
export DIR_CONFIGS=/Users/bryanwhiting/github/docker_r_env/configs
docker run \
  -d \
  -v $HOME/data:/home/rstudio/data \
  -v $DIR_CONFIGS/rstudio:/home/rstudio/.config/rstudio \
  -v $DIR_CONFIGS/.bashrc:/home/rstudio/.bashrc:Z \
  -v $DIR_CONFIGS/.profile:/home/rstudio/.profile:Z \
  -v $DIR_CONFIGS/.zshrc:/root/.zshrc:Z \
  -v $DIR_CONFIGS/.p10k.zsh:/root/.p10k.zsh:Z \
  -v $DIR_CONFIGS/.zcompdump:/root/.zcompdump:Z \
  -p 80:8787 \
  -e DISABLE_AUTH=true \
  -e PASSWORD=mu \
  -e ROOT=true \
  -u root \
  --name renv \
  bryanwhiting/r_env:latest
```

# Development

> These steps must be done on your host machine, not within docker.

Build docker image:

```
docker build -t bryanwhiting/r_env:latest .
```

Tag and push image to dockerhub. First check the dockerhub [bryanwhiting/r_env](https://github.com/bryanwhiting/docker_r_env) for the latest and increment.

```
docker image ls
# Copy latest tag
export tagname=0.2
docker image tag 9771039e5975 bryanwhiting/r_env:${tagname}
docker push bryanwhiting/r_env:${tagname}
```
 
Copy files out of docker (e.g., a `.dotfile`):

```
docker cp r_env:/home/rstudio/.bashrc configs/.
```

# Github Workflow

## Authorize

```
gh auth login
# ? What account do you want to log into? GitHub.com
# ? What is your preferred protocol for Git operations? SSH
# ? Generate a new SSH key to add to your GitHub account? Yes
# ? Enter a passphrase for your new SSH key (Optional) ********
# Tip: you can generate a Personal Access Token here https://github.com/settings/tokens
# The minimum required scopes are 'repo', 'read:org', 'admin:public_key'.
# ? Paste your authentication token: ****************************************
```

## New projects

1. Enable git config
```
source docker_r_env/gitconfig
```

1. Make repo on gh, add R .gitignore
1. gh repo clone bryanwhiting/xxxxxxx

```
export repo=generalconference
gh repo clone bryanwhiting/${repo}
find ${repo} -type f -exec chmod 777 {} \;
chown rstudio ${repo} 
chgrp rstudio ${repo}
```

For a one-off page:
1. Enable pages: https://github.com/bryanwhiting/emdat/settings/pages
1. `Rscript -e "styler::style_file('index.Rmd'); rmarkdown::render('index.Rmd')"`

# Possible future enhancements

- [x] Install gh, conda, ssh-keygen
- [ ] Install hugo.
- [ ] Install Java for h2o.

# Known issues
- [ ] After doing a gh repo clone from zsh, I couldn't make new files in the repo. Presumably it's because my zsh `gh repo clone` command was called from sudo, but my R Studio is running as `rstudio`. Workaround: create the file outside of the folder and copy it in. Changes save thereafter. NOTE: need to chmod files if use sudo for gh clone. 
- [ ] Can't knit in folder (sudo): `Rscript -e "rmarkdown::render('test.Rmd')"`
- [ ] Can use `gh browse` to open on the host machine. Workaround: it provides url that host machine can click.
- [ ] When I restart the container, I get the weird message in the R Studio R Console. I think this is telling me that the Add-ins are breaking and not working. Workaround: Restart R session. Add-ins load.

Errors:
```
16 Aug 2021 22:30:56 [rsession-rstudio] ERROR r error 4 (R code execution error) [errormsg: ]; OCCURRED AT rstudio::core::Error rstudio::r::exec::executeSafely(rstudio_boost::function<void()>) src/cpp/r/RExec.cpp:239; LOGGED FROM: void rstudio::session::{anonymous}::processEvents() src/cpp/session/SessionHttpMethods.cpp:99
```