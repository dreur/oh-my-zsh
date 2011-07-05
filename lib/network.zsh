alias hosts_on_standard_lan='nmap -sP 192.168.0.0/24'

# TRAFFIC MONITORING ##
alias tcpf3000='sudo tcpflow -c -i lo0 port 3000'
alias tcpf80='sudo tcpflow -c -i en1 port 80'
alias tcpf8080='sudo tcpflow -c -i lo0 port 8080'

alias tcpdlo="sudo tcpdump -i lo tcp -X -v"
alias tcpd8080="sudo tcpdump -s 0 -A -i lo0 'tcp port 8080 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'"
alias tshark8080='sudo tshark -i lo0 -R "tcp.port == 8080" -w -'
alias ngrep8080='sudo ngrep -q -l -d lo0 port 8080'
alias tcpf8080='sudo tcpflow -c -i lo0 port 8080'

# show open ports
alias op='lsof -i'
alias snsop='sudo netstat -tunl -p tcp'
alias nsop='netstat -tunl -p tcpA'

alias hdiff='diff -EBwdy'
