# vagrant-multi-cluster


=================
Demo illustrating vagrant+ansible setup of nginx load balancers and desired number of web nodes behind it.

Please edit variable NODE_COUNT in Vagrantfile before run if you need more than 3 web nodes(default vale). Then run:

```
vagrant up
....
....
==> lb: Balancer status url is http://192.168.50.10/status
```

Private IP(192.168.50.10) of load balancer is hardcoded, but can be also changed in case of conflict with local network.


There is a test script for load balancer:

```
./testlb.sh -h 192.168.50.10 -n 1000
Sending 1000 requests to http://192.168.50.10/...
node1:      332
node2:      334
node3:      334
```
As bonus I've added nginx real-time statistic for upstream status(almost like in haproxy):

http://192.168.50.10/status


To change the cluster edit the NODE_COUNT Vagrantfile and run

```
vagrant up
vagrant provision
```
