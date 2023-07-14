clearvars
clc;
clear;
close all;

posx=[644.132680133535	691.721424350760	301.760058468270	770.458137945529	612.174890925808	150.739496787713	706.263637480424	177.362043774218	904.488326584785	874.674307332286	851.824725372474	879.549541898559	251.030412718603	952.942336508878	300.878842686364	546.441612934141	196.771005371458	90.1499183790865	187.125972205646	595.724107875004	640.202862579832	376.823100185069	216.685967587839	339.368240977801	88.4111464949593	797.665353495706	711.352356605420	296.089033698722	275.241910184100	792.192249423989	50.3365765810105	862.364084341725	309.545770935439	539.322839842854	60.7676848405296	931.039330247171	118.355596851141	300.001601195746	656.217546503779	778.508563377216	478.728899793064	549.187604491825	59.6209114253973	482.580859126777	342.805226989209	605.088046002887	661.482105035203	577.820051095709	777.319801566022	470.604318353448	841.852704365975	766.639579429069	763.590164645481	459.881106458728	293.303827881567	926.028616255638	145.213268094080	893.750444340903	851.188331580125	926.000211250801	528.100664614302	179.645737113151	156.308530576257	613.586244650307	731.302945642490	973.976377272467	901.712976940705	874.109404098772	847.550262561697	959.884475323722	75.1440053888787	961.059472063457	932.281942265587	138.293246882420	407.492506834105	224.708886548267	101.385179999969	685.841118013878	891.401767727372	445.986295483579	885.029374156899	795.842622844165	620.176269381209	146.061045487498	245.682916413389	260.138600243540	608.924532442044	250.579386083627	11.2850212392475	643.596938016399	385.266949577157	888.129591635809	352.615079800291	560.734891789643	851.781062950678	945.934154782245	67.2111882455044	197.185271200558	296.112803352921	216.348236706125];
posy=[407.307395585411	695.268568653786	832.079260048842	986.868308239219	365.637961305712	975.700356675667	766.585653189381	240.518333498242	733.798381059945	267.734756181228	828.338355226310	53.7511553050095	853.769837363927	131.588197055904	51.9092747961227	436.695159768290	204.636450685895	4.52093509188833	651.350077499493	942.288013820397	449.175040208124	8.79007885083871	443.192321750266	140.140637041523	3.73111696646455	293.663016898885	443.497241116738	262.062227838900	73.7013140896307	300.424791025954	336.091550352029	151.861223131031	530.871149133982	794.497837875105	842.682724072832	759.259203248080	125.964228433316	376.687963417636	846.683736068520	698.830074886309	392.181687636536	595.028056701018	919.210360308339	73.5834521861951	540.715814912947	776.784526255746	655.713497763003	287.445829709382	521.644117571933	123.602721867068	155.351633244972	48.0175572098605	350.508156315623	48.5355742638932	745.346387590054	752.651195263199	346.983421546869	141.769783070216	477.534513094796	541.409440262695	842.075578348273	276.169145514343	784.108735845911	631.053132943444	118.357834097237	124.467282660163	79.2069274493014	604.860188754782	715.178068878210	193.622739507481	84.1323276998058	965.241337687973	686.906840088052	647.749744535459	703.502813415060	995.599827896049	818.112331041775	395.169886846344	382.262868208066	872.385076890101	207.787915387991	691.429967090675	404.717363139943	46.4976987309360	172.979087885868	956.673482447943	608.558797959612	785.001302865601	123.473488811845	901.491767886539	767.315890991487	75.9655243970787	963.996051967761	849.555295342507	723.875899421331	696.686239958025	290.057304074911	157.380672937732	257.477799251388	526.025944469512];
  
scatter (posx,posy)
hold on

%alvo
a=[500];
b=[500];
scatter (a,b);
hold on

%drones
dronea=[0];
droneb=[0];
scatter (dronea,droneb);
hold on

distances = sqrt((dronea-a) .^ 2 + (droneb-b) .^ 2);
fprintf('xy: %d\n', distances); 

n = 1;
while n < 500
    if (posx(n) == dronea(n))
        dronea(n)=n+10;
        dronea(n)=n;
    else
    dronea(n)=n;
    droneb(n)=n;
    n = n+1;
    end
end
    line(dronea,droneb);
    hold on

