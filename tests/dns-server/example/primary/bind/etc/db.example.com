;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	example.com. root.example.com. (
			      1		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	ns1.example.com.
@	IN	NS	ns2.example.com.
@	IN	A	127.0.0.1
@	IN	AAAA	::1

ns1			A	172.17.0.2		; Change to desired NS1 IP
ns2			A	172.17.0.3		; Change to desired NS2 IP

@		IN	SOA	ns.example.com. hostmaster.example.com. (
				2021011301 ; serial
				60         ; refresh (1 minute)
				15         ; retry (15 seconds)
				1800       ; expire (30 minutes)
				10         ; minimum (10 seconds)
				)
		IN	NS	ns.example.com.
ns		IN	A	127.0.0.1