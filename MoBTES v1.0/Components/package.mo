within MoBTES;
package Components "Components"
	extends Modelica.Icons.Package;
	annotation(
		dateModified="2020-02-04 15:24:30Z",
		Icon(graphics={
			Rectangle(
				fillColor={255,255,255},
				extent={{-30,-20.1488},{30,20.1488}},
				origin={0,35.1488}),
			Rectangle(
				fillColor={255,255,255},
				extent={{-30,-20.1488},{30,20.1488}},
				origin={0,-34.8512}),
			Line(
				points={{21.25,-35},{-13.75,-35},{-13.75,35},{6.25,35}},
				origin={-51.25,0}),
			Polygon(
				points={{10,0},{-5,5},{-5,-5}},
				pattern=LinePattern.None,
				fillPattern=FillPattern.Solid,
				origin={-40,35}),
			Line(
				points={{-21.25,35},{13.75,35},{13.75,-35},{-6.25,-35}},
				origin={51.25,0}),
			Polygon(
				points={{-10,0},{5,5},{5,-5}},
				pattern=LinePattern.None,
				fillPattern=FillPattern.Solid,
				origin={40,-35})}),
		Documentation(info="<html>
<p>
Collection of components for the simulation of underground thermal energy storage systems:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr>
  <td><a href=\"modelica://MoBTES.Components.SeasonalThermalStorages\">SeasonalThermalStorages</a></td>
  <td>borehole thermal energy storage model</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Components.BoreholeHeatExchangers\">BoreholeHeatExchangers</a></td>
  <td>Models for different borehole heat exchanger types</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Components.Ground\">Ground</a></td>
  <td>Models for the heat transport inside the ground</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Components.UtilityComponents\">UtilityComponents</a></td>
  <td>Small utility components, that are not specific for one component.</td>
</tr>
</table>

</html>"));
end Components;
