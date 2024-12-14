# Server Setup



## Create a new user

Create user and add them to the groups sudo and docker:
```shell
sudo useradd -m username

sudo usermod -aG docker,sudo username

sudo passwd username
```

Verify the user was added and belongs to the correct groups by checking:
```shell
id username

groups username
```


## Install Oh-My-ZSH

1. Install ohmyzsh
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Change theme to gnzh

```shell
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gnzh"/g' ~/.zshrc
```

3. Add docker to 

```shell
sed -i 's/plugins=(git)/plugins=(git docker)/g' ~/.zshrc
```

4. Apply the changes
```shell
source ~/.zshrc
```
