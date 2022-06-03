adder_test

* 工艺库
.lib "../PTM-MG/modelfiles/models" ptm7lstp

* 原件库电路网表
.inc "./common_elements.net"
.inc "./special_elements.net"

* 加法器电路网表
.inc "./accurate_adder.net"
.inc "./approx_adder.net"

.option acct list post probe
.global VDD_DESIGN VDD_LOAD VSS_COM
.temp 25

.param SUPPLY = 0.7v



.end