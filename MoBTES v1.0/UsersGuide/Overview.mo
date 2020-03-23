within MoBTES.UsersGuide;
class Overview "Overview of Modelica Library"
	extends Modelica.Icons.Information;
	annotation(
		Documentation(info="<html>
<p>
The Modelica MoBTES library consists of the following components:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Library Components</th> <th>Description</th></tr>

<tr><td >
 <img align=\"middle\" src=\"modelica://MoBTES/Components/MoBTES.png\">
 </td>
 <td>
 <a href=\"modelica://MoBTES.Components.SeasonalThermalStorages\">SeasonalThermalStorages</a><br>
 Components for the simulation of seasonal thermal underground storages.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://MoBTES/Components/BHE.png\">
 </td>
 <td>
 <a href=\"modelica://MoBTES.Components.BoreholeHeatExchangers\">BoreholeHeatExchangers</a><br>
Components for the simulation of borehole heat exchangers.
 </td>
</tr>
</table>

</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end Overview;
