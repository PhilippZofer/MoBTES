﻿within MoBTES.Parameters;
package Settings "model settings"
	extends Modelica.Icons.Package;
	partial record SettingsPartial "partial settings record"
		extends Modelica.Icons.Record;
		parameter Integer nAdditionalElementsR(
			min=1,
			max=10) "Number of additional radial ring elements (nBHErings+3+x)";
		parameter Real dZminDesired(
			min=0.1,
			max=3,
			quantity="Length",
			displayUnit="m") "Desired size of the smallest vertical discretization.";
		parameter Integer nBHEelementsZdesired(
			min=4,
			max=20) "Desired number of vertical elements for the BHE.";
		parameter Real growthFactor(
			min=1,
			max=2) "Maximum relative size difference between neighbouring elements.";
		parameter Real relativeModelDepth(
			min=1.2,
			max=2) "Model depth in relation to bhe bottom depth.";
		parameter Integer dynamicModelOrder(
			min=2,
			max=20) "Desired number of vertical elements for the BHE.";
		parameter Boolean printModelStructure "Print model structure to output area";
		parameter Boolean useAverageSurfaceTemperature "=true, if temperature boundary condition at model top is defined by the average location temperature, else defined by input";
	end SettingsPartial;
	record SettingsDefault "default model settings"
		extends SettingsPartial(
			nAdditionalElementsR=5,
			dZminDesired=1,
			nBHEelementsZdesired=6,
			growthFactor=sqrt(2),
			relativeModelDepth=1.5,
			dynamicModelOrder=8,
			printModelStructure=false,
			useAverageSurfaceTemperature=true);
	end SettingsDefault;
	record SettingsDetailed "detailed model settings"
		extends SettingsPartial(
			nAdditionalElementsR=7,
			dZminDesired=0.5,
			nBHEelementsZdesired=10,
			growthFactor=sqrt(2),
			relativeModelDepth=1.7,
			dynamicModelOrder=12,
			printModelStructure=true,
			useAverageSurfaceTemperature=false);
	end SettingsDetailed;
	record SettingsSKEWS "settings for SKEWS simulation"
		extends SettingsPartial(
			nAdditionalElementsR=6,
			dZminDesired=1,
			nBHEelementsZdesired=10,
			growthFactor=sqrt(2),
			relativeModelDepth=1.3,
			dynamicModelOrder=8,
			printModelStructure=false,
			useAverageSurfaceTemperature=true);
	end SettingsSKEWS;
	annotation(
		dateModified="2020-02-14 10:35:56Z",
		Documentation(info="<html>
<p>
Colelction of different modelling pre-settings
</p>

</html>"));
end Settings;
