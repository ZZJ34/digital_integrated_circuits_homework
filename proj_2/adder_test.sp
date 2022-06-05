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
.param T      = 26ns 


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


.tran 1ns 'T'

* 功耗测量
.measure tran avg_p AVG p(VVDD_DESIGN) from=0ns to='T'

* 关键路径延迟测量
* 针对精确全加器
* .measure tran critical_t trig v(A[0]) val='supply/2' rise=1 targ v(SUM[31]) val='supply/2' rise=1
* 针对近似加法器
* .measure tran


* 输出设置
.probe tran v(cin)
.probe tran v(A[0])
.probe tran v(A[1])
.probe tran v(A[2])
.probe tran v(A[3])
.probe tran v(A[4])
.probe tran v(A[5])
.probe tran v(A[6])
.probe tran v(A[7])
.probe tran v(A[8])
.probe tran v(A[9])
.probe tran v(A[10])
.probe tran v(A[11])
.probe tran v(A[12])
.probe tran v(A[13])
.probe tran v(A[14])
.probe tran v(A[15])
.probe tran v(A[16])
.probe tran v(A[17])
.probe tran v(A[18])
.probe tran v(A[19])
.probe tran v(A[20])
.probe tran v(A[21])
.probe tran v(A[22])
.probe tran v(A[23])
.probe tran v(A[24])
.probe tran v(A[25])
.probe tran v(A[26])
.probe tran v(A[27])
.probe tran v(A[28])
.probe tran v(A[29])
.probe tran v(A[30])
.probe tran v(A[31])
.probe tran v(B[0])
.probe tran v(B[1])
.probe tran v(B[2])
.probe tran v(B[3])
.probe tran v(B[4])
.probe tran v(B[5])
.probe tran v(B[6])
.probe tran v(B[7])
.probe tran v(B[8])
.probe tran v(B[9])
.probe tran v(B[10])
.probe tran v(B[11])
.probe tran v(B[12])
.probe tran v(B[13])
.probe tran v(B[14])
.probe tran v(B[15])
.probe tran v(B[16])
.probe tran v(B[17])
.probe tran v(B[18])
.probe tran v(B[19])
.probe tran v(B[20])
.probe tran v(B[21])
.probe tran v(B[22])
.probe tran v(B[23])
.probe tran v(B[24])
.probe tran v(B[25])
.probe tran v(B[26])
.probe tran v(B[27])
.probe tran v(B[28])
.probe tran v(B[29])
.probe tran v(B[30])
.probe tran v(B[31])
.probe tran v(SUM[0])
.probe tran v(SUM[1])
.probe tran v(SUM[2])
.probe tran v(SUM[3])
.probe tran v(SUM[4])
.probe tran v(SUM[5])
.probe tran v(SUM[6])
.probe tran v(SUM[7])
.probe tran v(SUM[8])
.probe tran v(SUM[9])
.probe tran v(SUM[10])
.probe tran v(SUM[11])
.probe tran v(SUM[12])
.probe tran v(SUM[13])
.probe tran v(SUM[14])
.probe tran v(SUM[15])
.probe tran v(SUM[16])
.probe tran v(SUM[17])
.probe tran v(SUM[18])
.probe tran v(SUM[19])
.probe tran v(SUM[20])
.probe tran v(SUM[21])
.probe tran v(SUM[22])
.probe tran v(SUM[23])
.probe tran v(SUM[24])
.probe tran v(SUM[25])
.probe tran v(SUM[26])
.probe tran v(SUM[27])
.probe tran v(SUM[28])
.probe tran v(SUM[29])
.probe tran v(SUM[30])
.probe tran v(SUM[31])
.probe tran v(SUM[32])

.end