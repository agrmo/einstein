u = symunit;

mega = 10^6;
giga = 10^9;
micro = 10^(-6);
nano = 10^(-9);

e = exp(1);
c = 299792458 * u.m / u.s;
f = 9.3 * giga * (1/u.s);
omega = 2 * pi * f;
p_0 = 1.7 * mega * u.watt;
r = 144 * mega * u.ohm / u.m;
q_0 = 6800;
L = 0.6 * u.m;
duty = 0.0008;
lambda = c / f;
i_0 = 0.07 * u.Ampere;
n_cavities = f_unit_strip(round(L/cell_length));
n_particles = 1000;
% beta_phase = 1 is incorrect
beta_phase = 1;
% change of the phase of the rf em wave where some given particle is located, per
% cell
phase_per_cell = 120;
cell_length = lambda / (360 / phase_per_cell);
aperture_lambda = 0.1;
tau = 1.0;
p_L = p_0 * exp(-2 * tau);

z = 0:0.01*u.m:L;
group_velocity = group_velocity_f(omega, L, q_0, tau, z);
alpha = alpha_f(omega, group_velocity, q_0);
power = power_f(p_0, z, p_L, L);
plot(z/u.m, power/u.Watt);
hold on
power_maybe = power_derived_f(p_0, alpha, z);
plot(z/u.m, power_maybe/u.Watt);
dpdz = dpdz_f(p_0, p_L, L)

%x = 0:0.01*u.m:L;
% plot(x/u.m, vpa(group_velocity_f(omega, L, q_0, tau, x)/c))
function group_velocity = group_velocity_f(omega, L, q_0, tau, z)
    group_velocity = (omega * L / q_0) * (1 - (z/L) * (1 - exp(-2 * tau)) / (1 - exp(-2 * tau)));
end

function alpha = alpha_f(omega, group_velocity, q_0)
    alpha = omega ./ (2 * group_velocity * q_0);
end

function power = power_f(p_0, z, p_L, L)
    power = p_0 - (z/L) * (p_0 - p_L);
end

function dpdz = dpdz_f(p_0, p_L, L)
    dpdz = - (p_0 - p_L) / L
end

function power_maybe = power_derived_f(p_0, alpha, z)
    power_maybe = p_0 .* exp(-alpha .* z);
end

function tau = tau_f(alpha, L)
    tau = alpha * L
end

function unit_strip = f_unit_strip(v_unit)
    unit_strip = separateUnits(f_unit(v_unit));
end

function un = f_unit(v_un)
    un = vpa(simplify(v_un));
end

% make_input_f(i_0, n_particles, p_0, f, lambda, Q, beta_group, beta_phase, r, alpha, n_cavities, phase_per_cell, aperture_lambda);
