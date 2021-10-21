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
RUN R -e "install.packages(c(\
  'easypackages', \
  'pkgdown', \
  'styler', \
  'tictoc', \
  'renv' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN installGithub.r bergant/airtabler

# data processing
# tidyverse, data.table already installed
# RUN R -e "install.packages('tidyverse', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c( \
  'multidplyr', \
  'sparklyr' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')"

# blogging
RUN R -e "install.packages(c( \
  'blogdown', \
  'metathis', \
  'postcards', \
  'xaringan' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN installGithub.r r-lib/hugodown
RUN installGithub.r gadenbuie/xaringanExtra
RUN installGithub.r rstudio/fontawesome
RUN installGithub.r rstudio/distill # bleeding edge

# Tables
RUN R -e "install.packages(c( \
  'DT', \
  'formattable', \ 
  'gt', \
  'gtsummary', \
  'kableExtra', \
  'reactable'  \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "webshot::install_phantomjs()"

# data viz, networks
# igraph already installed
RUN R -e "install.packages(c( \
  'directlabels', \
  'dotwhisker', \
  'flexdashboard', \
  'ggalluvial', \
  'gghighlight', \
  'ggraph', \
  'ggsurvplot', \
  'ggthemes', \
  'networkD3', \
  'plotly', \
  'shiny', \
  'skimr', \
  'survminer', \
  'vip' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# tidymodels (big install)
RUN R -e "install.packages('tidymodels',dependencies=TRUE, repos='http://cran.rstudio.com/')"

# tidymodels appendages
RUN R -e "install.packages(c(\
  'applicable', \
  'baguette', \
  'butcher', \
  'censored', \
  'censored', \
  'corrr', \
  'discrim', \
  'embed', \
  'finetune', \
  'infer', \
  'lantern', \
  'plsmod', \
  'poissonreg', \
  'probably', \
  'rules', \
  'stacks', \
  'textrecipes', \
  'themis', \
  'tidyposterior', \
  'tidypredict', \
  'usemodels' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN installGithub.r curso-r/treesnip

# bayesian
RUN R -e "install.packages(c( \
  'bayestestR', \
  'rstan', \
  'rstanarm', \
  'shinystan' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# time series
RUN R -e "install.packages(c( \
  'fable', \
  'fasster', \
  'feasts', \
  'modeltime', \
  'prophet', \
  'tsibble' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# Model Interpretation
RUN R -e "install.packages(c( \
  'margins', \
  'DALEXtra' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# Machine Learning
# https://www.tidymodels.org/find/parsnip/
# glmnet, keras are pre-installed
RUN R -e "install.packages(c( \
  'C50', \
  'Cubist', \
  'earth', \
  'flexsurv', \
  'forecast', \
  'kernlab', \
  'kknn', \
  'lightgbm', \
  'nnet', \
  'randomForest', \
  'ranger', \
  'rpart', \
  'survival', \
  'tensorflow', \
  'xgboost', \
  'xrf' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN installGithub.r curso-r/treesnip
RUN installGithub.r davpinto/fastknn
RUN installGithub.r mukul13/rword2vec
RUN R -e "devtools::install_url('https://github.com/catboost/catboost/releases/download/v0.26.1/catboost-R-Linux-0.26.1.tgz', INSTALL_opts = c(\"--no-multiarch\"))"

# Text mining
# wordcloud, SnowballC are already installed by the above packages
# RUN R -e "install.packages('wordcloud', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
# RUN R -e "install.packages('SnowballC', dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages(c( \
  'quanteda', \
  'spacyr', \
  'text2vec', \
  'tidytext', \
  'topicmodels', \
  'widyr' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# Geo Spatial
RUN R -e "install.packages(c( \
  'ggmap', \
  'leaflet', \
  'sf' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# Gospel Analysis
RUN R -e "install.packages('scriptuRs', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# APIs and model deployment
RUN R -e "install.packages('plumber', dependencies=TRUE, repos='http://cran.rstudio.com/')" 

# Heavy ML packages
# tensorflow is ~1Gb
RUN R -e "keras::install_keras()" 
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
RUN conda install -y \
  gh \
  glances \
  radian \ 
  ipykernel \
  --channel conda-forge
# https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
RUN apt-get install -y \
   htop \
   openssh-client \
   tmux \
   tree \
   vim \
   zsh 
RUN pip install glances 
# Powerlevel10k: https://github.com/romkatv/powerlevel10k#manual
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k

# VSCODE
# install vscode and codercom
RUN R -e "install.packages(c( \
  'httpgd', \
  'languageserver' \
  ), dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN curl -fsSL https://code-server.dev/install.sh | sh

# JAVA (for h2o + spark): https://stackoverflow.com/a/44058196
# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;
# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;
# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

CMD ["/init"]

# TODO: expose ports for codercom
# TODO: initialize codercom on startup

##### MANUAL STEPS #####
# Install fonts
# NOTE: I don't know how to install them using the font-manager cli, if there is one?
# Install the fonts on linux:
# sudo apt-get install -y ttf-mscorefonts-installer # manually run, needs to accept EULA
# sudo fc-cache -vr; fc-list

# Then https://stackoverflow.com/a/68642855
# remotes::install_version("Rttf2pt1", version = "1.3.8")
# extrafont::font_import(prompt=FALSE)"
# ggplot on extrafont: https://isabella-b.com/blog/ib-r-package/

# manually install spacyr (when needed)
# RUN R -e "spacyr::spacy_install(conda='auto')" 
