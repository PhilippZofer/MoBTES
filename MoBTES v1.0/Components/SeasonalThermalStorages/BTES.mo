within MoBTES.Components.SeasonalThermalStorages;
model BTES "BTES model"
	Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a BTESflow(medium=BHEmedium) "flow for storage chrging " annotation(Placement(
		transformation(extent={{-10,-10},{10,10}}),
		iconTransformation(extent={{-115,185},{-85,215}})));
	Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b BTESreturn(medium=BHEmedium) "return for storage charging" annotation(Placement(
		transformation(extent={{-10,-10},{10,10}}),
		iconTransformation(extent={{85,185},{115,215}})));
	Modelica.Blocks.Interfaces.RealInput Tsurface if not settingsData.useAverageSurfaceTemperature "Temperature at ground surface" annotation(Placement(
		transformation(extent={{-120,30},{-80,70}}),
		iconTransformation(extent={{-220,130},{-180,170}})));
	Modelica.Blocks.Sources.RealExpression TsurfaceAverage(y=location.Taverage)if settingsData.useAverageSurfaceTemperature;
	Modelica.SIunits.Temperature Tflow(displayUnit="°C") "BTES flow temperature";
	Modelica.SIunits.Temperature Treturn(displayUnit="°C") "BTES return temperature";
	Modelica.SIunits.Temperature Tstorage(displayUnit="°C") "Average temperature inside storage volume";
	Modelica.SIunits.Temperature TboreholeWall[nBHEelementsR](displayUnit="°C") "Borehole wall temperature at half BHE depth";
	Modelica.SIunits.VolumeFlowRate V_BTES(displayUnit="l/s") "BTES volume flow (flow-> return)";
	Modelica.SIunits.Power P_BTES(displayUnit="kW") "Thermal power";
	Modelica.SIunits.Energy Q_BTES(
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal ernergy balance";
	Modelica.SIunits.Energy Q_BTESin(
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal energy charged into storage";
	Modelica.SIunits.Energy Q_BTESout(
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal energy discharged from storage";
	Modelica.SIunits.Pressure dp "Pressure drop flow->return";
	inner parameter Integer nBHEs(
		min=1,
		max=1000)=100 "Number of borehole heat exchangers (BHE)" annotation(Dialog(
		group="Dimensions",
		tab="Storage"));
	inner parameter Modelica.SIunits.Length BHElength(
		displayUnit="m",
		min=20,
		max=2000)=100 "Length of BHEs" annotation(Dialog(
		group="Dimensions",
		tab="Storage"));
	parameter Modelica.SIunits.Length BHEstart(
		displayUnit="m",
		min=0.5,
		max=10)=1 "Depth of BHE heads" annotation(Dialog(
		group="Dimensions",
		tab="Storage"));
	parameter Modelica.SIunits.Length BHEspacing(
		displayUnit="m",
		min=1,
		max=20)=3 "Minimal disctance D between BHEs" annotation(Dialog(
		group="Dimensions",
		tab="Storage"));
	parameter Utilities.Types.BTESlayout BTESlayout=.MoBTES.Utilities.Types.BTESlayout.circle "BTES layout" annotation(Dialog(
		group="Layout",
		groupImage=if Integer(BTESlayout)==1 then "modelica://MoBTES/Utilities/BTESlayout1.png"else if Integer(BTESlayout)==2 then "modelica://MoBTES/Utilities/BTESlayout2.png"else "modelica://MoBTES/Utilities/BTESlayout3.png",
		tab="Storage"));
	replaceable parameter Examples.ExampleData.BenchmarkLocation location constrainedby MoBTES.Parameters.Locations.LocationPartial "Local geology" annotation(
		choicesAllMatching=true,
		Dialog(
			group="Location",
			tab="Storage"));
	replaceable model BHEmodel = .MoBTES.Components.BoreholeHeatExchangers.DoubleUsegment constrainedby MoBTES.Components.BoreholeHeatExchangers.BHEsegment_partial "BHE type" annotation(
		choicesAllMatching=true,
		Placement(transformation(extent={{-10, -10}, {10, 10}})),
		Dialog(
			group="Heat Exchanger type",
			tab="BHEs"));
	replaceable parameter Examples.ExampleData.BenchmarkBHEdata BHEdata constrainedby MoBTES.Parameters.BoreholeHeatExchangers.BHEparameters "BHE dataset" annotation(
		choicesAllMatching=true,
		Dialog(
			group="Heat Exchanger type",
			tab="BHEs"));
	replaceable model GLOBALmodel = .MoBTES.Components.Ground.GlobalElement_circular constrainedby MoBTES.Components.Ground.GlobalElement_partial "Global problem modeling approach" annotation(
		choicesAllMatching=true,
		Dialog(
			group="Global problem",
			tab="Modeling"));
	replaceable model LOCALmodel = .MoBTES.Components.Ground.LocalElement_steadyFlux constrainedby MoBTES.Components.Ground.LocalElement_partial "Local problem modeling approach" annotation(
		choicesAllMatching=true,
		Dialog(
			group="Local problem",
			tab="Modeling"));
	protected
		Modelica.SIunits.Temperature TflowArray(displayUnit="°C") "BHE array inlet temperature";
		Modelica.SIunits.Temperature TreturnArray(displayUnit="°C") "BHE array outlet temperature";
		final parameter Real rEquivalent=if Integer(BTESlayout) == 1 then BHEspacing / sqrt(Modelica.Constants.pi) elseif Integer(BTESlayout) == 2 then (nBHEelementsR - 0.5) * BHEspacing / sqrt(nBHEs) else 3 ^ (1 / 4) * BHEspacing / sqrt(2 * Modelica.Constants.pi) "Radius of BHE volume" annotation(Evaluate=true);
		final parameter Real heights[nElementsZ]=Utilities.Functions.ElementHeights(MoBTES.Utilities.Functions.SupermeshZ(BHEstart, if useUpperGroutSection then lengthUpperGroutSection else 0, BHElength, settingsData.relativeModelDepth, location.layerThicknessVector), integer(floor(settingsData.nBHEelementsZdesired / 2)), settingsData.dZminDesired, settingsData.growthFactor, nElementsZ) "Vector for vertical discretization" annotation(Evaluate=true);
		final parameter Real meshZ[nElementsZ+1]=cat(1, {0}, array(sum(heights[i] for i in 1:j) for j in 1:nElementsZ)) "Vector containing absolute depth of mesh nodes" annotation(Evaluate=true);
		final parameter Real meshR[nElementsR+1]=Utilities.Functions.MeshR(nBHEsPerRingVector, rEquivalent, nElementsR) "Vector containing absolute radius of mesh nodes" annotation(Evaluate=true);
		final parameter Integer nElementsZ=Utilities.Functions.nElementsZ(MoBTES.Utilities.Functions.SupermeshZ(BHEstart, if useUpperGroutSection then lengthUpperGroutSection else 0, BHElength, settingsData.relativeModelDepth, location.layerThicknessVector), integer(floor(settingsData.nBHEelementsZdesired / 2)), settingsData.dZminDesired, settingsData.growthFactor) "Number of elements in vertcial direction" annotation(Evaluate=true);
		final parameter Integer nElementsR=nBHEelementsR + 3 + settingsData.nAdditionalElementsR "Number of elements in radial direction" annotation(Evaluate=true);
		final parameter Integer nBHEelementsR=if nSeries == 1 then Utilities.Functions.NumberOfBHErings(nBHEs) else nSeries "Number of rings containg a BHE" annotation(Evaluate=true);
		final parameter Integer nBHEelementsZ=iBHEbottomElement - iBHEheadElement + 1 "Number of layers containing  a BHE" annotation(Evaluate=true);
		inner parameter Integer nSeries=if mod(nBHEs, nBHEsInSeries) == 0 then nBHEsInSeries else 1 "Number of BHEs in series" annotation(Evaluate=true);
		parameter Integer nBHEsPerRingVector[nBHEelementsR]=if nSeries == 1 then MoBTES.Utilities.Functions.NumberOfBHEsPerRing(nBHEs, nBHEelementsR) else fill(integer(nBHEs / nBHEelementsR), nBHEelementsR) "Vector containing the number of BHEs per ring" annotation(Evaluate=true);
		parameter Integer iBHEheadElement=Utilities.Functions.BHE_HeadElementIndex(meshZ, BHEstart) "Index of the element containg the BHE head" annotation(Evaluate=true);
		parameter Integer iGroutChange=if useUpperGroutSection then Modelica.Math.Vectors.find(BHEstart + lengthUpperGroutSection, meshZ) else 0 "Index of the first element of the main/lower grout section." annotation(Evaluate=true);
		parameter Integer iBHEbottomElement=Utilities.Functions.BHE_BottomElementIndex(meshZ, BHEstart, BHElength) "Index of the element containg the BHE bottom" annotation(Evaluate=true);
		parameter Real GROUND_innerRadiusMatrix[nElementsZ,nElementsR]=fill(meshR[1:nElementsR], nElementsZ) "Inner radii of volume elements" annotation(Evaluate=true);
		parameter Real GROUND_outerRadiusMatrix[nElementsZ,nElementsR]=fill(meshR[2:nElementsR + 1], nElementsZ) "Outer radii of volume elements" annotation(Evaluate=true);
		parameter Real GROUND_elementHeightsMatrix[nElementsZ,nElementsR]=transpose(fill(heights, nElementsR)) "Matrix containg heights for each element of the global problem" annotation(Evaluate=true);
		parameter Real GROUND_TinitialMatrix[nElementsZ,nElementsR]=array(location.Taverage + (meshZ[z] + heights[z] / 2) * location.geoGradient for r in 1:nElementsR, z in 1:nElementsZ) "Matrix containg initial temperature for each element of the global problem" annotation(Evaluate=true);
		parameter Real GROUND_groundDataMatrix[3,nElementsZ,nElementsR]=MoBTES.Utilities.Functions.ElementGroundData(heights, nElementsR, location) "Matrix containg thermal properties for each element of the global problem {rho,cp,lamda}" annotation(Evaluate=true);
		parameter Real GROUND_capacityMatrix[nElementsZ,nElementsR]=array(GROUND_groundDataMatrix[1, z, r] * GROUND_groundDataMatrix[2, z, r] * Modelica.Constants.pi * GROUND_elementHeightsMatrix[z, r] * (GROUND_outerRadiusMatrix[z, r] ^ 2 - GROUND_innerRadiusMatrix[z, r] ^ 2) for r in 1:nElementsR, z in 1:nElementsZ) "Matrix containg the thermal capacity for each element of the global problem" annotation(Evaluate=true);
		parameter Real GROUND_storageCapacity=sum(GROUND_capacityMatrix[z, r] for z in iBHEheadElement:iBHEbottomElement, r in 1:nBHEelementsR) annotation(Evaluate=true);
		parameter Real BHE_groutDataMatrix[3,nBHEelementsZ,nBHEelementsR]={array(if z >= iGroutChange then groutData.rho else groutDataUpper.rho for r in 1:nBHEelementsR, z in 1:nBHEelementsZ), array(if z >= iGroutChange then groutData.cp else groutDataUpper.cp for r in 1:nBHEelementsR, z in 1:nBHEelementsZ), array(if z >= iGroutChange then groutData.lamda else groutDataUpper.lamda for r in 1:nBHEelementsR, z in 1:nBHEelementsZ)} annotation(Evaluate=true);
		parameter Integer BHE_BHEsPerRingMatrix[nBHEelementsZ,nBHEelementsR]=fill(nBHEsPerRingVector, nBHEelementsZ) "Matrix containg number of BHEs within the ring for each element of the local problem" annotation(Evaluate=true);
		replaceable BHEmodel BHE_SegmentMatrix[nBHEelementsZ,nBHEelementsR] constrainedby MoBTES.Components.BoreholeHeatExchangers.BHEsegment_partial(
			segmentLength(each fixed=true)=GROUND_elementHeightsMatrix[iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
			Tinitial(each fixed=true)=GROUND_TinitialMatrix[iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
			each BHEmedium=BHEmedium,
			each BHEdata=BHEdata,
			groutData(
				rho(each fixed=true)=BHE_groutDataMatrix[1],
				cp(each fixed=true)=BHE_groutDataMatrix[2],
				lamda(each fixed=true)=BHE_groutDataMatrix[3]),
			each useTRCMmodel=useTRCMmodel) "Borehole heat exchanger type" annotation(
			Placement(transformation(extent={{-10,-10},{10,10}})),
			Dialog(
				group="Heat Exchanger type",
				tab="BHEs"));
	public
		parameter Boolean useUpperGroutSection=false "=true, if grout is divided into an upper and a lower section." annotation(Dialog(
			group="Grout",
			tab="BHEs"));
		replaceable parameter Examples.ExampleData.BenchmarkGrout groutData constrainedby MoBTES.Parameters.Grouts.GroutPartial "Grout dataset" annotation(
			choicesAllMatching=true,
			Dialog(
				group="Grout",
				tab="BHEs"));
		replaceable parameter Examples.ExampleData.BenchmarkGrout groutDataUpper constrainedby MoBTES.Parameters.Grouts.GroutPartial "Grout dataset" annotation(
			choicesAllMatching=true,
			Dialog(
				group="Grout",
				tab="BHEs",
				enable=useUpperGroutSection));
		parameter Modelica.SIunits.Length lengthUpperGroutSection(
			displayUnit="m",
			min=1,
			max=0.5 * BHElength)=1 "Length of upper grout section." annotation(Dialog(
			group="Grout",
			tab="BHEs",
			enable=useUpperGroutSection));
		parameter Integer nBHEsInSeries(
			min=1,
			max=nBHEs)=1 "Number of BHEs connected in series" annotation(Dialog(
			group="Hydraulics",
			tab="BHEs"));
		replaceable parameter Examples.ExampleData.BenchmarkFluid BHEmedium constrainedby Modelica.Thermal.FluidHeatFlow.Media.Medium "Medium inside the BHE" annotation(
			choicesAllMatching=true,
			Dialog(
				group="Hydraulics",
				tab="BHEs"));
		parameter Boolean useTRCMmodel=true "=true, if BHE model considers thermal capaciities " annotation(Dialog(
			group="Borehole heat exchanger",
			tab="Modeling"));
		replaceable parameter Parameters.Settings.SettingsDefault settingsData constrainedby MoBTES.Parameters.Settings.SettingsPartial "Numerical settings" annotation(Dialog(
			group="Model",
			tab="Modeling"));
	protected
		replaceable GLOBALmodel GLOBAL_elementMatrix[nElementsZ,nElementsR] constrainedby MoBTES.Components.Ground.GlobalElement_partial(
			groundData(
				rho(each fixed=true)=GROUND_groundDataMatrix[1],
				cp(each fixed=true)=GROUND_groundDataMatrix[2],
				lamda(each fixed=true)=GROUND_groundDataMatrix[3]),
			elementHeight(each fixed=true)=transpose(fill(heights, nElementsR)),
			innerRadius(each fixed=true)=GROUND_innerRadiusMatrix,
			outerRadius(each fixed=true)=GROUND_outerRadiusMatrix) "Global problem modeling approach" annotation(
			Placement(transformation(extent={{-10,-10},{10,10}})),
			Dialog(
				group="Global problem",
				tab="Modeling"));
		replaceable LOCALmodel LOCAL_elementMatrix[nBHEelementsZ,nBHEelementsR] constrainedby MoBTES.Components.Ground.LocalElement_partial(
			groundData(
				rho(each fixed=true)=GROUND_groundDataMatrix[1, iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
				cp(each fixed=true)=GROUND_groundDataMatrix[2, iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
				lamda(each fixed=true)=GROUND_groundDataMatrix[3, iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR]),
			numberOfBHEsInRing(each fixed=true)=BHE_BHEsPerRingMatrix,
			each nRings=settingsData.dynamicModelOrder,
			each rEquivalent=rEquivalent,
			each rBorehole=BHEdata.dBorehole / 2,
			elementHeight(each fixed=true)=GROUND_elementHeightsMatrix[iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
			Tinitial(each fixed=true)=GROUND_TinitialMatrix[iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR]) "Local problem modeling approach" annotation(
			Placement(transformation(extent={{-10,-10},{10,10}})),
			Dialog(
				group="Local problem",
				tab="Modeling"));
		Modelica.Thermal.HeatTransfer.Components.HeatCapacitor GLOBAL_groundCapacitiesTop[iBHEheadElement-1,nElementsR](
			C=GROUND_capacityMatrix[1:iBHEheadElement - 1],
			T(
				start=GROUND_TinitialMatrix[1:iBHEheadElement - 1],
				each fixed=true)) "Thermal capacities of global model elements above the storage" annotation(
			choicesAllMatching=true,
			Placement(transformation(extent={{-10,-10},{10,10}})));
		Modelica.Thermal.HeatTransfer.Components.HeatCapacitor GLOBAL_groundCapacitiesSide[iBHEbottomElement-iBHEheadElement+1,nElementsR-nBHEelementsR](
			C=GROUND_capacityMatrix[iBHEheadElement:iBHEbottomElement, nBHEelementsR + 1:nElementsR],
			T(
				start=GROUND_TinitialMatrix[iBHEheadElement:iBHEbottomElement, nBHEelementsR + 1:nElementsR],
				each fixed=true)) "Thermal capacities of global model elements beside the storage" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
		Modelica.Thermal.HeatTransfer.Components.HeatCapacitor GLOBAL_groundCapacitiesBottom[nElementsZ-iBHEbottomElement,nElementsR](
			C=GROUND_capacityMatrix[iBHEbottomElement + 1:nElementsZ],
			T(
				start=GROUND_TinitialMatrix[iBHEbottomElement + 1:nElementsZ],
				each fixed=true)) "Thermal capacities of global model elements below the storage" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
		Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GLOBAL_outerBC[nElementsZ](T(each fixed=true)=GROUND_TinitialMatrix[:, 1]) "Fixed temperature boundary condition at the model side" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
		Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow GLOBAL_innerBC[nElementsZ](each Q_flow=0) "Fixed heat flow boundary condition at the inner model boundary" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
		Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GLOBAL_bottomBC[nElementsR](each T=location.Taverage + meshZ[nElementsZ + 1] * location.geoGradient) "Fixed temperature boundary condition at the model bottom" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
		Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature GLOBAL_topBC[nElementsR] "Variable temperature boundary condition at the model top" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
		UtilityComponents.FluidHeatFlow.Ambient_unconditional HYDR_BHEinlets[nBHEelementsR](each medium=BHEmedium) "Sources for BHE inlets" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
		UtilityComponents.FluidHeatFlow.Ambient_unconditional HYDR_BHEoutlets[nBHEelementsR](each medium=BHEmedium) "Sources for BHE outlets" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
		UtilityComponents.FluidHeatFlow.VolumeFlow_unconditional HYDR_BHEpumps[nBHEelementsR](
			each medium=BHEmedium,
			each m=1,
			each T0=location.Taverage,
			each T0fixed=true) "BHE pumps" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
		UtilityComponents.FluidHeatFlow.BHEhydraulics HYDR_Losses(
			BHEdata=BHEdata,
			BHEmedium=BHEmedium) "Advective thermal resistances between fluid and the pipe" annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
	initial algorithm
		assert(nBHEsInSeries == nSeries, "Number of BHEs in series and number of BHEs not compatibel. Using parallel connection as fallback!", AssertionLevel.warning);
		if settingsData.printModelStructure then
		  Modelica.Utilities.Streams.print("GLOBAL[" + String(nElementsZ) + "," + String(nElementsR) + "]:", "");
		  Modelica.Utilities.Streams.print("GLOBAL.groundData.lamda: " + Modelica.Math.Vectors.toString(GROUND_groundDataMatrix[3,:,1], "", 6), "");
		  
		  Modelica.Utilities.Streams.print("superMeshZ: " + Modelica.Math.Vectors.toString(MoBTES.Utilities.Functions.SupermeshZ(BHEstart, if useUpperGroutSection then lengthUpperGroutSection else 0, BHElength, settingsData.relativeModelDepth, location.layerThicknessVector), "", 6), "");
		  Modelica.Utilities.Streams.print("meshZ[" + String(nElementsZ) + "]" + Modelica.Math.Vectors.toString(meshZ, "", 6), "");
		  Modelica.Utilities.Streams.print("meshR[" + String(nElementsR) + "]" + Modelica.Math.Vectors.toString(meshR, "", 6), "");
		  Modelica.Utilities.Streams.print("LOCAL[" + String(nBHEelementsZ) + "," + String(nBHEelementsR) + "]:", "");
		  Modelica.Utilities.Streams.print("iBHEheadElement: " + String(iBHEheadElement) + "/ iGroutChange: " + String(iGroutChange) + "/ iBHEbottomElement: " + String(iBHEbottomElement), "");
		  Modelica.Utilities.Streams.print("#BHEs in series: " + String(nSeries) + " / #BHEs per ring: " + Modelica.Math.Vectors.toString(nBHEsPerRingVector, "", 3), "");
		  Modelica.Utilities.Streams.print("Area/BHE[r] " + Modelica.Math.Vectors.toString(array(Modelica.Constants.pi * (meshR[r] ^ 2 - meshR[r - 1] ^ 2) / nBHEsPerRingVector[r - 1] for r in 2:nBHEelementsR + 1), "", 6), "");
		  Modelica.Utilities.Streams.print("groutLamda: " + Modelica.Math.Vectors.toString(BHE_SegmentMatrix[:, 1].groutData.lamda, "", 6), "");
		end if;
	equation
		/*Outputs---------------------------------------------*/
		V_BTES = BTESflow.m_flow / BHEmedium.rho;
		P_BTES = (TflowArray - TreturnArray) * BTESflow.m_flow * BHEmedium.cp;
		der(Q_BTES) = P_BTES;
		der(Q_BTESin) = max(P_BTES, 0);
		der(Q_BTESout) = abs(min(P_BTES, 0));
		TflowArray = if nSeries == 1 then sum(BHE_SegmentMatrix[1, r].topFlowPort.h / BHEmedium.cp * nBHEsPerRingVector[r] / nBHEs for r in 1:nBHEelementsR) else BHE_SegmentMatrix[1, 1].topFlowPort.h / BHEmedium.cp;
		TreturnArray = if nSeries == 1 then sum(BHE_SegmentMatrix[1, r].topReturnPort.h / BHEmedium.cp * nBHEsPerRingVector[r] / nBHEs for r in 1:nBHEelementsR) else BHE_SegmentMatrix[1, nBHEelementsR].topReturnPort.h / BHEmedium.cp;
		Tstorage = sum(GLOBAL_elementMatrix[z, r].groundCenterPort.T * GROUND_capacityMatrix[z, r] for z in iBHEheadElement:iBHEbottomElement, r in 1:nBHEelementsR) / GROUND_storageCapacity;
		TboreholeWall = BHE_SegmentMatrix[integer((iBHEbottomElement + iBHEheadElement) / 2)].boreholeWallPort.T;
		BTESflow.p = if V_BTES > 0 then BTESreturn.p + dp else BTESreturn.p + dp;
		Tflow = BTESflow.h / BHEmedium.cp;
		Treturn = BTESreturn.h / BHEmedium.cp;
		BTESflow.m_flow + BTESreturn.m_flow = 0;
		BTESflow.H_flow = semiLinear(BTESflow.m_flow, BTESflow.h, TflowArray * BHEmedium.cp);
		BTESreturn.H_flow = semiLinear(BTESreturn.m_flow, BTESreturn.h, TreturnArray * BHEmedium.cp);
		dp = HYDR_Losses.dp;
		/*diagnostics*/
		assert(GLOBAL_elementMatrix[iBHEheadElement + integer((iBHEbottomElement + iBHEheadElement) / 2), nElementsR].groundCenterPort.T < GROUND_TinitialMatrix[iBHEheadElement + integer((iBHEbottomElement + iBHEheadElement) / 2), nElementsR] + 1, "Temperature of outer model boundary increased by more than 1K --> increase radial model size", AssertionLevel.warning);
		assert(GLOBAL_elementMatrix[nElementsZ, 1].groundCenterPort.T < GROUND_TinitialMatrix[nElementsZ, 1] + 1, "Temperature at model bottom increased by more than 1K --> increase model depth", AssertionLevel.warning);
		/*GLOBAL elements connection----------------------------------------*/
		/*connect element thermal ports horizontally*/
		for z in 1:nElementsZ loop
		  connect(GLOBAL_innerBC[z].port, GLOBAL_elementMatrix[z, 1].innerHeatPort);
		  connect(GLOBAL_elementMatrix[z, nElementsR].outerHeatPort, GLOBAL_outerBC[z].port);
		  for r in 1:nElementsR - 1 loop
		    connect(GLOBAL_elementMatrix[z, r].outerHeatPort, GLOBAL_elementMatrix[z, r + 1].innerHeatPort);
		  end for;
		end for;
		/*connect element thermal ports vertically*/
		for r in 1:nElementsR loop
		  /*GLOBAL to top/bottom boundary conditions*/
		  connect(Tsurface, GLOBAL_topBC[r].T);
		  connect(TsurfaceAverage.y, GLOBAL_topBC[r].T);
		  connect(GLOBAL_topBC[r].port, GLOBAL_elementMatrix[1, r].topHeatPort);
		  connect(GLOBAL_elementMatrix[nElementsZ, r].bottomHeatPort, GLOBAL_bottomBC[r].port);
		  /*GLOBAL to GLOBAL*/
		  for z in 1:nElementsZ - 1 loop
		    connect(GLOBAL_elementMatrix[z, r].bottomHeatPort, GLOBAL_elementMatrix[z + 1, r].topHeatPort);
		  end for;
		end for;
		/*Connect GLOBAL elements without LOCAL elements to capacities*/
		/*above storage*/
		for r in 1:nElementsR loop
		  for z in 1:iBHEheadElement - 1 loop
		    connect(GLOBAL_groundCapacitiesTop[z, r].port, GLOBAL_elementMatrix[z, r].groundCenterPort);
		  end for;
		end for;
		/*beside storage*/
		for r in nBHEelementsR + 1:nElementsR loop
		  for z in iBHEheadElement:iBHEbottomElement loop
		    connect(GLOBAL_groundCapacitiesSide[z - iBHEheadElement + 1, r - nBHEelementsR].port, GLOBAL_elementMatrix[z, r].groundCenterPort);
		  end for;
		end for;
		/*below storage*/
		for r in 1:nElementsR loop
		  for z in iBHEbottomElement + 1:nElementsZ loop
		    connect(GLOBAL_groundCapacitiesBottom[z - iBHEbottomElement, r].port, GLOBAL_elementMatrix[z, r].groundCenterPort);
		  end for;
		end for;
		/*LOCAL & BHE element connection----------------------------------------*/
		/*BTES inlet and outlet ports*/
		HYDR_Losses.volFlow = V_BTES * nSeries / (nBHEs * max(BHEdata.nShanks, 1));
		/*connect BHE segments & LOCAL elements*/
		for r in 1:nBHEelementsR loop
		  for z in 1:nBHEelementsZ loop
		    if z < nBHEelementsZ then
		      connect(BHE_SegmentMatrix[z, r].bottomFlowPort, BHE_SegmentMatrix[z + 1, r].topFlowPort);
		      connect(BHE_SegmentMatrix[z, r].bottomReturnPort, BHE_SegmentMatrix[z + 1, r].topReturnPort);
		    else
		      connect(BHE_SegmentMatrix[z, r].bottomFlowPort, BHE_SegmentMatrix[z, r].bottomReturnPort);
		    end if;
		    connect(BHE_SegmentMatrix[z, r].boreholeWallPort, LOCAL_elementMatrix[z, r].boreholeWallPort);
		    connect(LOCAL_elementMatrix[z, r].local2globalPort, GLOBAL_elementMatrix[z + iBHEheadElement - 1, r].groundCenterPort);
		    BHE_SegmentMatrix[z, r].Radvective = HYDR_Losses.R;
		  end for;
		  /*connect BHE outlets*/
		  connect(HYDR_BHEinlets[r].flowPort, HYDR_BHEpumps[r].flowPort_a);
		  connect(HYDR_BHEpumps[r].flowPort_b, BHE_SegmentMatrix[1, r].topFlowPort);
		  connect(BHE_SegmentMatrix[1, r].topReturnPort, HYDR_BHEoutlets[r].flowPort);
		  if nSeries == 1 then
		    HYDR_BHEinlets[r].ambientTemperature = BTESflow.h / BHEmedium.cp;
		    HYDR_BHEoutlets[r].ambientTemperature = BTESreturn.h / BHEmedium.cp;
		    HYDR_BHEpumps[r].volumeFlow = V_BTES / (nBHEs * max(BHEdata.nShanks, 1));
		  else
		    if r == 1 then
		      HYDR_BHEinlets[r].ambientTemperature = BTESflow.h / BHEmedium.cp;
		    else
		      HYDR_BHEinlets[r].ambientTemperature = BHE_SegmentMatrix[1, r - 1].topReturnPort.h / BHEmedium.cp;
		    end if;
		    if r == nBHEelementsR then
		      HYDR_BHEoutlets[r].ambientTemperature = BTESreturn.h / BHEmedium.cp;
		    else
		      HYDR_BHEoutlets[r].ambientTemperature = BHE_SegmentMatrix[1, r + 1].topFlowPort.h / BHEmedium.cp;
		    end if;
		    HYDR_BHEpumps[r].volumeFlow = nSeries * V_BTES / (nBHEs * max(BHEdata.nShanks, 1));
		  end if;
		end for;
	annotation(
		Icon(
			coordinateSystem(extent={{-200,-200},{200,200}}),
			graphics={
							Bitmap(
								imageSource="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",
								extent={{-200,-199.4},{200,199.4}})}),
		Documentation(info="<html>
<h4>General</h4>
<p>The Modelica Borehole Thermal Energy Storage model (MoBTES) consists of 3 sub-models (see Fig. 1):</p>
<ol>
<li>Global model</li>
<li>Local model</li>
<li>BHE model</li>
</ol>
<p>For each sub-model different modelling approaches can be selected. Additional approaches can be added by the user, provided that the new model uses the same interface (extends from the global/local/BHE partial model).</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>Model structure</caption>
  <tr>
    <td>
      <img src=\"modelica://MoBTES/Components/SeasonalThermalStorages/BTESstructure.png\" width=\"700\">
    </td>
  </tr>
</table>

<h5>Global model</h5>
<p>The global model handles the heat diffusion processes between BHEs and the ground surrounding the storage. This process can be sufficiently simulated by considering the average temperature inside each global volume element. The only model which is currently implemented is a 2D finite differences model.</p>

<h5>Local model</h5>
<p>The local models represent the heat diffusion process around single BHEs. Since the storage model assumes radial symmetry, only one local model and one BHE model are simulated per storage ring. The BHEs inside each ring of the storage are assumed to behave similar. Each local model defines the relation between the borehole wall temperature of one BHE segment and the global temperature, i.e. the average temperature inside the volume element. Currently two options are implemented:</p>
<ol>
<li>steady flux model</li>
<li>finite differences model</li>
</ol>
<p>The steady flux model exploits the fact that the thermal resistance between the borehole wall and the average volume temperature can be considered constant for the steady-flux regime. The transition period until the steady-flux regime is approximated by an one artificial capacity. This approach is most valid for scenarios with strong thermal interactions between neighbouring BHEs. It should not be used for systems with large disctances between BHEs. The finite differences approach divides the local model into ring segments. The heat diffusion process between the ring segments is handled with the finite-differences method. The weighted average temperature of the rings defines the associated global temperature. The user has the option to choose the number of rings that should be generated.</p>
<h5>BHE model</h5>
<p>For the BHE models there are currently two options. A thermal-resistance model (TRM) which only considers the thermal resistance between the fluid and the borehole wall and a thermal-resistance-capacitance model (TRCM) which additionally considers the thermal capacity of the grout. For each modelling approach models for single-U, double-U and coaxial heat exchangers are available.</p>

<h4>Model parametrization</h4>
<h5>Storage</h5>
<p>Even though the actual storage model is a cylindrical model with radial symmetry, the user has the option to choose between different layouts (see Fig. 2). The minimal distance <strong>BHEspacing (D)</strong> beweteen BHEs which is defined by the user is converted to an equivalent distance for the actual model. The resulting cylindrical model has the same specific storage volume per BHE as the configuration defined by the user.</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2: </strong>BTES layout options</caption>
  <tr>
    <td>
   <img src=\"modelica://MoBTES/Components/SeasonalThermalStorages/BHEspacing.png\" width=\"500\">
    </td>
  </tr>
</table>

<p>The <strong>location</strong> record contains information on the local geology at the storage site. Up to 5 different layers can be defined in the record, including the insulation layer. Each layer is defined by its type of soil/rock and thickness. The layer thickness can generally be any number greater 0.5 m, but it is strongly recommended to use integer values to avoid unwanted model behaviour and to limit the size of the model's mesh. The average surface temperature and the geothermal gradient define the initial temperature of the model and the boundary conditions.</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3: </strong>Vertical cross section</caption>
  <tr>
    <td>
   <img src=\"modelica://MoBTES/Components/SeasonalThermalStorages/BTESsideView.png\" width=\"500\">
    </td>
  </tr>
</table>
<h5>BHEs</h5>
<p>The parameters in the BHE tab define the model inside the borehole. The type of BHE can be selected from single-U, double-U or coaxial. Accordingly a matching BHE data record has to be chosen. Optionally an upper grout section can be defined. For each of the two grout sections a different grout data record can be chosen, allowing the user to use a grout material with a reduced thermal conductivity in the top section, thus reducing thermal losses through the surface. </p>
<p>Serial connections can be defined by the parameter <strong>nBHEsInSeries</strong>. If the number of BHEs and the number of BHEs in series are not compatible, a warning is issued and parallel BHE connection is used as fallback option. Name conventions regarding serial connection correspond to charging of the storage from center BHEs to outer BHEs (see Fig. 3). For this case the volume flow <strong>V_BTES</strong> is positive. </p>
<p>Charging (V_BTES > 0):</p>
<ul>
<li><strong>Tflow:</strong> inlet temperature of BHEs in the center region of the storage</li>
<li><strong>Treturn:</strong> outlet temperature of BHEs in the outermost region of the storage</li>
</ul>
<p>Discharging (V_BTES < 0):</p>
<ul>
<li><strong>Tflow:</strong> outlet temperature of BHEs in the center region of the storage</li>
<li><strong>Treturn:</strong> inlet temperature of BHEs in the outermost region of the storage</li>
</ul>

<h5>Modeling</h5>
<p>The numerical settings <strong>settingsData</strong> of the model are collected in records. The level of discretization (number of volume elements) are defined by the model's geometry and the parameters <strong>nAdditionalElementsR, dZminDesired, nBHEelementsZdesired, growthFactor and relativeModelDepth</strong>. The term \"desired\" indicates that the parameter is not fixed and will be ignored if another parameter value results in a finer level of discretization.</p>
<p>If the parameter <strong>useAverageSurfaceTemperature</strong> is set to false, the temperature at the ground surface has to be given to the model by a real input.</p> 

<h4>Implementation</h4>
<p>The model has been tested in several Modelica environments and efforts have been put into compatibility. An overview of the tested environments and restrictions can be found in the <a href=\"modelica://MoBTES.UsersGuide.ReleaseNotes.Version_1_0\">release notes</a></p>
</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.002));
end BTES;
