adder_test

* 工艺库
.lib "../PTM-MG/modelfiles/models" ptm7lstp

* 原件库电路网表
.inc "./common_elements.net"
.inc "./special_elements.net"

* 负载电路
.inc "./load_circuit.net"

* 加法器电路网表
.inc "./accurate_adder.net"
.inc "./approx_adder.net"

* 激励输入
.vec "./stimulus.vect"

.option acct list post probe
.global VDD_DESIGN VDD_LOAD VSS_COM
.temp 25

.param SUPPLY = 0.7v 


Xor4 A0 A1 B0 B1 out VDD_DESIGN VSS_COM or4


* 外部供电
VVDD_DESIGN VDD_DESIGN 0 'SUPPLY'                        
VVDD_LOAD   VDD_LOAD   0 'SUPPLY'
VVSS_COM    VSS_COM    0 0


.tran 0.01ns 25ns

* 输出设置
.probe tran v(A0)
.probe tran v(A1)
.probe tran v(B0)
.probe tran v(B1)
.probe tran v(out)

.end