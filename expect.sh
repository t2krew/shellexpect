#! /usr/bin/expect

set timeout 100

set type [lindex $argv 0]
set target [lindex $argv 1]
set username [lindex $argv 2]
set password [lindex $argv 3]

if { $type == 0 } {
	spawn ssh $username@$target
	expect ":"
	send "$password\n"

	interact
	
} elseif { $type == 1 } {

	spawn ssh $username@$target
	expect ":"
	send "$password\n"

	expect "*$username"

	send "ssh $target\r"
	expect ":"
	send "$password\n"

	interact
} else {
	set username2 [lindex $argv 4]
	set password2 [lindex $argv 5]
	spawn ssh $username@$target
	expect ":"
	send "$password\n"

	expect "*$username"

	send "ssh $username2@$target\r"
	expect ":"
	send "$password2\n"

	interact
}


