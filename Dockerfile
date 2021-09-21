# Lineage:
# rocker scripts: https://github.com/rocker-org/rocker-versioned2/tree/master/scripts
### rocker/r-ver:4.1.0-cuda11.1     https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/Dockerfile_r-ver_4.1.0-cuda11.1
# FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04
# RUN /rocker_scripts/install_R.sh
# RUN /rocker_scripts/config_R_cuda.sh
# RUN /rocker_scripts/install_python.sh
### rocker/ml:4.1.0-cuda10.1   https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/Dockerfile_ml_4.1.0-cuda11.1
# FROM rocker/r-ver:4.1.0-cuda11.1
# RUN /rocker_scripts/install_rstudio.sh
# RUN /rocker_scripts/install_pandoc.sh
# RUN /rocker_scripts/install_tidyverse.sh | https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_tidyverse.sh
### rocker/ml:latest
# FROM rocker/ml:4.1.0-cuda10.1

# FROM rocker/shiny:latest
FROM rocker/ml:latest

# install from cran: https://stackoverflow.com/a/60767841
RUN apt-get update && apt-get install -y \
   r-cran-igraph \
   r-cran-wordcloud \
   r-cran-tidyverse \
   r-cran-glmnet 

# utils
RUN R -e "install.packages('renv', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# data processing
# tidyverse, data.table already installed
# RUN R -e "install.packages('tidyverse', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('multidplyr', dependencies=TRUE, repos='http://cran.rstudio.com/')"

# blogging
RUN R -e "install.packages('distill', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('postcards', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('blogdown', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN installGithub.r r-lib/hugodown

# Table formatting
RUN R -e "install.packages('gt', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('gtsummary', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('formattable', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('kableExtra', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('DT', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('skimr', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# data viz
# RUN R -e "install.packages('shiny', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('ggthemes', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('ggalluvial', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('plotly', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('flexdashboard', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('survminer', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('ggsurvplot', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('gghighlight', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('dotwhisker', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('directlabels', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# tidymodels
RUN R -e "install.packages('tidymodels',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('finetune', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('stacks', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('vip', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('themis', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('infer', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('corrr', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('textrecipes', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('poissonreg', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('usemodels', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('tidypredict', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('butcher', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('lantern', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('applicable', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('baguette', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('discrim', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('rules', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('censored', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('plsmod', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('tidyposterior', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('embed', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('probably', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN installGithub.r curso-r/treesnip

# bayesian
RUN R -e "install.packages('rstan', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('rstanarm', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('shinystan', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('bayestestR', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# time series
RUN R -e "install.packages('modeltime', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('prophet', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('fable', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('feasts', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('tsibble', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('fasster', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# Model Interpretation
RUN R -e "install.packages('margins', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# Machine Learning
# https://www.tidymodels.org/find/parsnip/
# RUN R -e "install.packages('glmnet', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('xgboost', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('lightgbm', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('C50', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('earth', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('nnet', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('kknn', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('randomForest', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('ranger', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('rpart', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('survival', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('flexsurv', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('kernlab', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('xrf', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('Cubist', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('forecast', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN installGithub.r curso-r/treesnip
RUN installGithub.r davpinto/fastknn
RUN installGithub.r mukul13/rword2vec
RUN R -e "devtools::install_url('https://github.com/catboost/catboost/releases/download/v0.26.1/catboost-R-Linux-0.26.1.tgz', INSTALL_opts = c(\"--no-multiarch\"))"
RUN R -e "install.packages('tensorflow', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('spacyr', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
# keras is already installed
# RUN R -e "install.packages('keras', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
# RUN R -e "keras::install_keras()" 

# Text mining
# wordcloud, SnowballC are already installed by the above packages
# RUN R -e "install.packages('wordcloud', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
# RUN R -e "install.packages('SnowballC', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('tidytext', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('widyr', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('topicmodels', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('text2vec', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('quanteda', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# Network analysis
# igraph already installed above
# RUN R -e "install.packages('igraph', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('networkD3', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('ggraph', dependencies=TRUE, repos='http://cran.rstudio.com/')" 



# Heavy ML packages
# tensorflow is ~1Gb
RUN R -e "tensorflow::install_tensorflow()"  
# Install spacy 
# TODO(20210810): install via docker: https://github.com/quanteda/spacyr/issues/176
# Need to install conda
# https://gist.github.com/pangyuteng/f5b00fe63ac31a27be00c56996197597
# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda
# https://github.com/quanteda/spacyr/issues/176
# RUN R -e "spacyr:::install_miniconda()" 
# RUN R -e "spacyr::spacy_install(conda='auto')" 

# Command line tools
RUN conda install -y gh --channel conda-forge
# RUN pip install glances # (like htop)
# https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
RUN apt-get install -y \
   tree \
   htop \
   vim \
   openssh-client \
   zsh 
# Powerlevel10k: https://github.com/romkatv/powerlevel10k#manual
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k

RUN R -e "install.packages('easypackages', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
# cmd +shift +p: style active file
RUN R -e "install.packages('styler', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('pkgdown', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('tictoc', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('scriptuRs', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('xaringan', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('reactable', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN installGithub.r gadenbuie/xaringanExtra
RUN installGithub.r bergant/airtabler
# Enable saving of gt() objects as plots
RUN R -e "webshot::install_phantomjs()"
RUN R -e "install.packages('reactable', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# R + VS Code
RUN conda install -y radian --channel conda-forge
RUN apt-get install -y tmux
RUN R -e "install.packages('languageserver', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('httpgd', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN curl -fsSL https://code-server.dev/install.sh | sh
 



# Install fonts
# NOTE: I don't know how to install them using the font-manager cli, if there is one?
# Install the fonts on linux:
# sudo apt-get install -y ttf-mscorefonts-installer # manually run, needs to accept EULA
# sudo fc-cache -vr; fc-list

# Then https://stackoverflow.com/a/68642855
# remotes::install_version("Rttf2pt1", version = "1.3.8")
# extrafont::font_import(prompt=FALSE)"
# ggplot on extrafont: https://isabella-b.com/blog/ib-r-package/


# zsh: https://github.com/deluan/zsh-indocker
# RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
   #  -t https://github.com/denysdovhan/spaceship-prompt \
   #  -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
   #  -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
   #  -p git \
   #  -p ssh-agent \
   #  -p https://github.com/zsh-users/zsh-autosuggestions \
   #  -p https://github.com/zsh-users/zsh-completions

######### TODO:
# todo: shrink this down. This size is totally unnecesssary
# cool, but not necessary
# library(espnscrapeR)
# TODO: instead of installing from ML, install from shiny? (if shiny server is needed)
# TODO: install java for h2o
# RUN R -e "install.packages('shiny', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
# already installed
# ml: already installed by above?
# todo: install java for h2o
# RUN R -e "install.packages('h2o', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
# RUN R -e "install.packages('mlr3', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

CMD ["/init"]