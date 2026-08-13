u = symunit;

mega = 10^6;
giga = 10^9;
micro = 10^(-6);
nano = 10^(-9);

c = 299792458 * u.m / u.s;
f = 9.3 * giga * (1/u.s);
omega = 2 * pi * f;
p_0 = 1.7 * mega * u.watt;
r = 144 * mega * u.ohm / u.m;
Q = 6800;
L = 0.6 * u.m;
duty = 0.0008;
lambda = c / f;
i_0 = 0.07 * u.Ampere;
cell_length = lambda / 3;
n_cavities = f_unit_strip(round(L/cell_length));
n_particles = 1000;
tau = 1.25643;
alpha = tau/L;
v_group = omega/(2*Q*alpha);
beta_group = v_group/c;
% beta_phase = 1 is incorrect
beta_phase = 1;
% change of the phase of the rf em wave where some given particle is located, per
% cell
phase_per_cell = 120;
weird_parameter = 0.1;

make_input_f(i_0, n_particles, p_0, f, lambda, Q, beta_group, beta_phase, r, alpha, n_cavities, phase_per_cell, weird_parameter);

function unit_string = f_unit_string(v_unit)
    unit_string = string(f_unit_strip(v_unit));
end

function unit_strip = f_unit_strip(v_unit)
    unit_strip = separateUnits(f_unit(v_unit));
end

function un = f_unit(v_un)
    un = vpa(simplify(v_un));
end

function make_input = make_input_f(i_0, n_particles, p_0, f, lambda, Q, beta_group, beta_phase, r, alpha, n_cavities, phase_per_cell, weird_parameter)
    % Given list of either string, concat them with tabs
    function concat_string = f_concat_string(v_list)
        concat_string = sprintf('%s', v_list{1});
        for i = 2:length(v_list)
            concat_string = sprintf('%s\t%s', concat_string, v_list{i});
        end
    end

    fid = fopen('Hellweg_CZ_INPUT_template.txt','rt');
    X = fread(fid);
    fclose(fid);
    X = char(X.');
   
    X = strrep(X, 'replace_i0', f_unit_string(i_0));
    X = strrep(X, 'replace_num_particles', string(n_particles));
    X = strrep(X, 'replace_p0', f_unit_string(p_0/10^6));
    X = strrep(X, 'replace_frequency', f_unit_string(f/10^6));
    
    term1 = f_unit_string((2*pi*lambda*r/(Q*beta_group))^(1/2));
    term2 = f_unit_string(alpha*lambda^(3/2));
    term3 = string(weird_parameter);
    cells_string = {string(int32(n_cavities)), string(phase_per_cell), string(beta_phase), term1, term2, term3};
    cells_string_concat = f_concat_string(cells_string);
    X = strrep(X, 'replace_cells', cells_string_concat);
   
    fid2 = fopen('INPUT.txt','wt');
    fwrite(fid2, X);
    fclose (fid2);
end