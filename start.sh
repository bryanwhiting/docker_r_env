export DIR_CONFIGS=/Users/bryanwhiting/github/docker_r_env/configs

docker run \
  -d \
  -v $HOME/github/docker_r_env:/home/rstudio/docker_r_env \
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
  -u root \
  -e ROOT=TRUE \
  --name renv \
  bryanwhiting/r_env:latest


# List remote tocker tags
# linux: wget -q https://registry.hub.docker.com/v1/repositories/bryanwhiting/r_env/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'
# mac  : curl -s https://registry.hub.docker.com/v1/repositories/bryanwhiting/r_env/tags | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'
