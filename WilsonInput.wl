(* ::Package:: *)

(* 1961 Perry Wilson *)
(* start preamble *)
BeginPackage["WilsonInput`"]


SetOptions[Plot,PlotStyle->Black];
SetOptions[Plot,ImageSize->300];
SetOptions[Plot,Frame->True];
SetOptions[Plot,BaseStyle->FontSize->14];


mega=10^6;
giga=10^9;
milli=10^(-3);
nano=10^(-9);
c=Quantity[299792458,"Meters"/"Seconds"];
(* f *)
frequency=Quantity[9.3*giga,"Seconds"^(-1)];
(* omega fundamental frequency of cavity *)  
omega=2*Pi*frequency;
(* pzero power flow at the input to the structure *)
pzero=Quantity[1.7*mega,"Watt"];
(* r shunt impedance *)
r=Quantity[144*mega,"Ohm"/"Meters"];
(* structure Q *)
Q=6800;
(* L structure length *)
L=Quantity[0.6,"Meters"];
(* duty percentage of maximum output power *)
duty=0.0008;
(* izero the initial beam current at the start of the structure *)
izero=Quantity[0.07,"Amperes"];
(* attenuation tau *)
tauList={0.5,1.0,1.25};
iZeroMin=0;
iZeroMax=0.3;
plotstyledashed={{Black,Dashed},{Gray,Dashed},{Blue,Dashed}};
plotstyle={Black,Gray,Blue};


Begin["`Private`"]
End[]
EndPackage[]
