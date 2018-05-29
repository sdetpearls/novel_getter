#!/bin/bash

clear

# Zenity
GUI=$(zenity --list --checklist \
        --height 400 \
        --width 900 \
        --title "elementary OS Loki Post-Installation scripts" \
        --text "选择要安装的程序，Git和Python为必选" \
        --column=选择 \
        --column=程序 \
        --column=描述 \
        
        TRUE "Update System" "更新当前系统，必选" \
        TRUE "python-software-properties" "安装后可以使用add-apt-repository" \
        TRUE "Git" "最流行的代码版本管理工具，必选" \
        TRUE "pyenv" "安装python版本管理工具pyenv，保留自带的Python2.7和3.5" \
        TRUE "rvm" "安装Ruby版本管理工具rvm" \
        TRUE "remove ibus" "卸载ibus" \
        TRUE "sogoupinyin" "下载搜狗拼音.deb" \
        FALSE "Firefox" "安装Firefox浏览器" \
        FALSE "Chrome" "下载google-chrome浏览器" \
        FALSE "GNU Emacs" "安装并配置emacs" \
        FALSE "Vim" "安装Vim编辑器" \
        FALSE "Code" "安装VS Code" \
        FALSE "oh-my-zh" "安装oh-my-zh" \
        FALSE "samba" "安装Samba server和client" \
        FALSE "vsftpd" "安装ftp server" \
        FALSE "youtube-dl" "安装YouTube Downloader" \
        FALSE "安装gdebi" "安装gdebi，.deb包安装工具" \
        FALSE "Fix Broken Packages" "修复包依赖" \
        FALSE "Clean-up junk" "清除" \
        --separator=',');

# 首先更新系统
if [[ $GUI == *"更新系统"*]]
then
    clear
    echo "更新系统..."
    echo ""
    notify-send -i system-software-update "Post-Installation" "更新系统..." -t 5000
    sudo apt-get update        # Fetches the list of available updates
    sudo apt-get upgrade       # Strictly upgrades the current packages
fi

# 添加软件源管理，依赖于Python2.7
if [[ $GUI == *"python-software-properties"*]]
    clear
    echo "安装python工具..."
    echo ""
    notify-send -i system-software-update "Post-Installation" "python工具..." -t 5000
    sudo apt-get install -y python-software-properties software-properties-common  # 安装后可以使用add-apt-repository
fi

# 安装Git
if [[ $GUI == *"Git"*]]
    clear
    echo "安装Git..."
    echo ""
    notify-send -i system-software-update "Post-Installation" "安装Git..." -t 5000
    sudo apt-get install git
fi

# 安装pyenv
if [[ $GUI == *"pyenv"*]]
    clear
    echo "安装pyenv..."
    echo ""
    notify-send -i system-software-update "Post-Installation" "安装pyenv..." -t 5000
    sudo apt-get install git
fi

# 安装rvm
if [[ $GUI == *"rvm"*]]
    clear
    echo "安装rvm..."
    echo ""
    notify-send -i system-software-update "Post-Installation" "安装rvm..." -t 5000
    sudo apt-get install git
fi

#卸载ibus
if [[ $GUI == *"rvm"*]]
    clear
    echo "安装rvm..."
    echo ""
    notify-send -i system-software-update "Post-Installation" "安装rvm..." -t 5000
    sudo apt-get remove ibus   // 卸载ibus
    sudo apt-get autoremove   // 删除依赖包
    sudo apt-get -f install   // 修正安装过程中出现的依赖性关系
fi

# Install GDebi Action
if [[ $GUI == *"Install GDebi"* ]]
then
	clear
	echo "Installing GDebi..."
	echo ""
	sudo apt-get -y install gdebi
fi

# Install Firefox Action
if [[ $GUI == *"Install Firefox"* ]]
then
	clear
	echo "Installing Firefox..."
	echo ""
	sudo apt-get -y install firefox
fi

# Install Google Chrome Action
if [[ $GUI == *"Install Google Chrome"* ]]
then
	clear
	echo "Installing Google Chrome..."
	echo ""
	if [[ $(uname -m) == "i686" ]]
	then
		wget -O /tmp/google-chrome-stable_current_i386.deb https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
		sudo dpkg -i /tmp/google-chrome-stable_current_i386.deb
	elif [[ $(uname -m) == "x86_64" ]]
	then
		wget -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
		sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
	fi
fi

# Installer zsh
if [[ $GUI == *"oh-my-zh"* ]]
then
	clear
	echo "安装zsh和oh-my-zsh..."
	echo ""
	notify-send -i package "elementary OS Post Install" "Installation de zsh et d'oh-my-zsh" -t 5000
	sudo apt -y install zsh git
	cd /tmp
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
	chsh -s /bin/zsh
fi

# Fix Broken Packages Action
if [[ $GUI == *"Fix Broken Packages"* ]]
then
	clear
	echo "Fixing the broken packages..."
	echo ""
	sudo apt-get -y -f install
fi

# Clean-Up Junk Action
if [[ $GUI == *"Clean-Up Junk"* ]]
then
	clear
	echo "Cleaning-up junk..."
	echo ""
	sudo apt-get -y autoremove
	sudo apt-get -y autoclean
fi

# Notification
clear
notify-send -i utilities-terminal elementary-script "All tasks ran successfully!"