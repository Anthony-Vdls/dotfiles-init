# This file is sourced in .bashrc

myip4() {
    # Get the network interface connected to the default route
    interface=$(ip route | awk '/default/ {print $5}')

    # Get the local IPv4 address
    localip=$(ip -4 addr show "$interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

    # Get the subnet mask
    subnet_prefix=$(ip -4 addr show "$interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}/\d+' | cut -d'/' -f2)
    netmask=$(ipcalc -m 0.0.0.0/"$subnet_prefix" | awk -F'=' '/Netmask/ {print $2}')

    # Get the public IPv4 address
    publicip=$(curl -s https://api.ipify.org)

    echo "Local IP Address : $localip"
    echo "Public IP Address: $publicip"
    echo "Subnet Mask      : $netmask"
}

# this makes pushing fater
push() {
	if [ -z "$1" ]; then
		echo "Please provide a commit message."
		return 1
	fi
	
	commit_message="$*"

	git add . &&
	git commit -m "$commit_message" &&
	git push
}

# silly function used in bashrc
random_emoji() {
    local emojis=("🐵" "🐶" "🦁" "🐯" "🐮" "🐴" "🐷" "🐭" "🐹" "🐻" "🐰" "🐨" "🐼" "🦅" "🐢" "🐸" "🐲" "🐳" "🐋" "🐬" "🦈" "🦖" "🐞" "🦗" "🪳" "🕷️" "🐜" "🪰" "🪱" "🦠" "🌸" "🪷" "🌺" "🌻" "🌱" "🪴" "🌲" "🌳" "🌴" "🌵" "🌾" "🍀" "☘️" "🐈" "🐈" "🦧" "🦊" "🐱" )
    echo -n "${emojis[$RANDOM % ${#emojis[@]}]}"
}
