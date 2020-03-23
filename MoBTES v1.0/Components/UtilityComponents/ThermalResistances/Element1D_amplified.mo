within MoBTES.Components.UtilityComponents.ThermalResistances;
partial model Element1D_amplified "Partial heat transfer element with two HeatPort connectors that does not store energy, where the heat flow at port B is amplified by a factor n"
	Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
	Modelica.SIunits.TemperatureDifference dT "port_a.T - port_b.T";
	Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(
		transformation(extent={{-110,-10},{-90,10}}),
		iconTransformation(extent={{-110,-10},{-90,10}})));
	Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(
		transformation(extent={{90,-10},{110,10}}),
		iconTransformation(extent={{90,-10},{110,10}})));
	protected
		parameter Integer amplification=1;
	equation
		dT = port_a.T - port_b.T;
		port_a.Q_flow = Q_flow;
		port_b.Q_flow = -Q_flow*amplification;
	annotation(Documentation(info="<html>
<p>
This partial model contains the basic connectors and variables to
allow heat transfer models to be created that <b>do not store energy</b>,
This model defines and includes equations for the temperature
drop across the element, <b>dT</b>, and the heat flow rate
through the element from port_a to port_b, <b>Q_flow</b>.
</p>
<p>
By extending this model, it is possible to write simple
constitutive equations for many types of heat transfer components.
</p>
</html>"));
end Element1D_amplified;
