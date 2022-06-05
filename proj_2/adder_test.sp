adder_test

* 工艺库
.lib "../PTM-MG/modelfiles/models" ptm7lstp

* 原件库电路网表
.inc "./common_elements.net"
.inc "./special_elements.net"

* 负载电路
*.inc "./load_circuit.net"

* 加法器电路网表
.inc "./accurate_adder.net"
.inc "./approx_adder.net"

* 激励输入
.vec "./stimulus.vect"

.option acct list post
.global VDD_DESIGN VDD_LOAD VSS_COM
.temp 25

.param SUPPLY = 0.7v 


Xadder_32_base 
+ A[0]  A[1]  A[2]  A[3]  A[4]  A[5]  A[6]  A[7]  A[8]  A[9]  A[10] A[11] A[12] A[13] A[14] A[15] 
+ A[16] A[17] A[18] A[19] A[20] A[21] A[22] A[23] A[24] A[25] A[26] A[27] A[28] A[29] A[30] A[31]
+ B[0]  B[1]  B[2]  B[3]  B[4]  B[5]  B[6]  B[7]  B[8]  B[9]  B[10] B[11] B[12] B[13] B[14] B[15] 
+ B[16] B[17] B[18] B[19] B[20] B[21] B[22] B[23] B[24] B[25] B[26] B[27] B[28] B[29] B[30] B[31]
+ SUM[0]  SUM[1]  SUM[2]  SUM[3]  SUM[4]  SUM[5]  SUM[6]  SUM[7]  SUM[8]  SUM[9]  SUM[10] SUM[11] SUM[12] SUM[13] SUM[14] SUM[15] 
+ SUM[16] SUM[17] SUM[18] SUM[19] SUM[20] SUM[21] SUM[22] SUM[23] SUM[24] SUM[25] SUM[26] SUM[27] SUM[28] SUM[29] SUM[30] SUM[31] 
+ SUM[32]
+ cin VDD_DESIGN VSS_COM adder_32_base


* 外部供电
VVDD_DESIGN VDD_DESIGN 0 'SUPPLY'                        
VVDD_LOAD   VDD_LOAD   0 'SUPPLY'
VVSS_COM    VSS_COM    0 0


.tran 0.1ns 25ns

* 输出设置
.probe tran 

.end