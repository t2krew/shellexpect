#! /bin/bash

# 服务器配置项

# ssh username@6.6.6.6
s1[0]="server1"
s1[1]="6.6.6.6"
s1[2]=0
s1[3]=username
s1[4]=password

# 跳板模式 跳板账号密码与目标机器账号密码一致
s2[0]="server2"
s2[1]="1.1.1.1"
s2[2]=1
s2[3]=username
s2[4]=password

# 跳板模式 跳板账号密码与目标机器账号密码不一致
s3[0]="server3"
s3[1]="8.8.8.8"
s3[2]=2
s3[3]=username1
s3[4]=password1
s3[5]=username2
s3[6]=password2

# 服务器组
servers=(s1 s2 s3)

LoopChar() {
	char=""
    for (( c=1; c<=$1; c++ ))
	do  
	   char=$char"$2"
	done
	echo $char
}

# 边框
Display(){
	width=$(echo -e "lines\ncols"|tput cols)
	echo $(LoopChar $width "#")
}

# 列表展示
List() {
	echo -e "\033[0;32m$1\033[0m";
	for i in ${!servers[@]};
	do
	    eval server=\${${servers[$i]}[@]}
	    server=(${server})
	    index=$[i+1]
	    if [ $index -lt 10 ]
	    then
	    	idx="0"$[i+1]
	    else
	    	idx=$[i+1]
	    fi
	    text="# $idx) 【${server[0]}】== [${server[1]}]"

	    echo -e "\033[0;32m$text\033[0m";
	done
	echo -e "\033[0;32m$1\033[0m";
}



border=$(Display)

List $border

read -p "输入服务器序号:" number

select=${servers[number-1]}
eval select=\${${select}[@]}
select=(${select})
name=${select[0]}
addr=${select[1]}
type=${select[2]}
username=${select[3]}
password=${select[4]}


if [ $type == 0 -o $type == 1 ]
then
	./expect.sh $type $addr $username $password
else
	username2=${select[5]}
	password2=${select[6]}
	./expect.sh $type $addr $username $password $username2 $password2
fi

exit