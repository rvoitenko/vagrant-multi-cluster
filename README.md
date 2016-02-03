# vagrant-multi-cluster


=================
Demo illustrating vagrant+ansible setup of nginx load balancers and desired number of web nodes behind it.

Please edit Vagrantfile before run and define the desirend number of web nodes. 

Private IP(192.168.50.10) of load balancer is hardcoded, but can be also changed in case of conflict with local network.


There is a test script for load balancer:

```
./testlb.sh -h 192.168.50.10 -n 1000
Sending 1000 requests to http://192.168.50.10/...
node1:      332
node2:      334
node3:      334
```
